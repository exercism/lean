namespace Satellite

inductive Tree (α : Type) : Type where
  | leaf
  | branch (value : α) (left right : Tree α)
  deriving BEq, Repr

inductive Result where
  | ok : Tree Char -> Result
  | error : String -> Result
  deriving BEq, Repr

structure Triple where
  tree : Tree Char
  preorder : List Char
  inorder : List Char
  deriving BEq, Repr

def startsWith (opt : Option Char) (list : List Char) : Bool :=
  match (opt, list) with
  | (some c, first :: _) => first == c
  | _ => false

partial def traverse (opt : Option Char) (preorder inorder : List Char) : Option Triple :=
  if startsWith opt inorder then some { tree := .leaf, preorder := preorder, inorder := inorder }
  else match preorder with
  | [] => none
  | (firstPreorder :: restPreorder) =>
      match traverse (some firstPreorder) restPreorder inorder with
      | none => none
      | (some triple) =>
        match triple.inorder with
        | [] => none
        | (_ :: []) => some { tree := (.branch firstPreorder triple.tree .leaf), preorder := triple.preorder, inorder := [] }
        | (_ :: restInorder) =>
            match traverse opt triple.preorder restInorder with
            | none => none
            | (some restTriple) => some { tree := (.branch firstPreorder triple.tree restTriple.tree), preorder := restTriple.preorder, inorder := restTriple.inorder }

def contains (letter : Char) (list : List Char) : Bool :=
  match list with
  | [] => false
  | (first :: rest) => (first == letter) || (contains letter rest)

def containsRepeat (list : List Char) : Bool :=
  match list with
  | [] => false
  | (first :: rest) => (contains first rest) || (containsRepeat rest)

def extractTree (opt : Option Triple) : Result :=
  match opt with
  | none => (.error "traversals must have the same elements")
  | some triple => (.ok triple.tree)

def treeFromTraversals (preorder inorder : List Char) : Result := Id.run do
  if preorder.length != inorder.length then return (.error "traversals must have the same length")
  if (containsRepeat preorder) || (containsRepeat inorder) then return (.error "traversals must contain unique items")
  if preorder.length == 0 then return (.ok Tree.leaf)
  extractTree $ traverse none preorder inorder

end Satellite
