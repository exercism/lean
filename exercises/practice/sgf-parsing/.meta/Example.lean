import Std

namespace SgfParsing

structure SgfTree where
  properties : Std.TreeMap String (Array String)
  children   : Array SgfTree
  deriving Repr

def SgfTree.empty : SgfTree := {
  properties := {},
  children := #[]
}

structure Result where
  result : SgfTree
  rest   : List Char

inductive State where
  | zero       : State
  | openTree   : State
  | property   : SgfTree → String → State
  | values     : SgfTree → String → Array String → State

partial def parseHelper : List Char → State → Except String Result
  | '(' :: xs, .zero           => parseHelper xs .openTree
  | '(' :: xs, .property m ps  =>
    if !ps.isEmpty
    then .error "properties without delimiter"
    else do
      let ⟨result, rest⟩ ← parseHelper ('(' :: xs) .zero
      parseHelper rest (.property { m with children := m.children.push result } "")
  | ';' :: xs, .openTree       => parseHelper xs (.property .empty "")
  | '[' :: xs, .property m ps  => parseHelper xs (.values m ps #[""])
  | '\\' :: '\\' :: xs, .values m ps vs => parseHelper xs (.values m ps (vs.modify (vs.size - 1) (·.push '\\')))
  | '\\' :: ']' :: xs, .values m ps vs => parseHelper xs (.values m ps (vs.modify (vs.size - 1) (·.push ']')))
  | '\\' :: '\n' :: xs, .values m ps vs => parseHelper xs (.values m ps vs)
  | '\\' :: xs, .values m ps vs => parseHelper xs (.values m ps vs)
  | ']' :: '[' :: xs, .values m ps vs => parseHelper xs (.values m ps (vs.push ""))
  | ']' :: ';' :: xs, .values m ps vs => do
    let ⟨result, rest⟩ ← parseHelper ('(' :: ';' :: xs) .zero
    parseHelper (')' :: rest) (.property {
      m with
        properties := m.properties.insert ps vs,
        children := m.children.push result
    } "")
  | ']' :: xs, .values m ps vs => parseHelper xs (.property {
    m with
      properties := m.properties.insert ps vs
    } "")
  | x :: xs, .values m ps vs =>
    let modifiedValue := if x.isWhitespace && x != '\n'
      then .values m ps (vs.modify (vs.size - 1) (·.push ' '))
      else .values m ps (vs.modify (vs.size - 1) (·.push x))
    parseHelper xs modifiedValue
  | ')' :: _, .openTree => .error "tree with no nodes"
  | ')' :: xs, .property m k =>
    if k.isEmpty
    then .ok { result := m, rest := xs }
    else .error "properties without delimiter"
  | x :: xs, .property m ps    =>
    if x.isUpper
    then parseHelper xs (.property m (ps.push x))
    else .error "property must be in uppercase"
  | _, _ => .error "tree missing"

def parse (encoded : String) : Except String SgfTree := do
  let ⟨result, _⟩ ← parseHelper encoded.toList .zero
  return result

end SgfParsing
