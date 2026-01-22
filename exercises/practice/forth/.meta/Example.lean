import Std

namespace Forth

abbrev Stack := List Int
abbrev Op := Stack -> Except String Stack
abbrev OpMap := Std.TreeMap String Op

structure State where
  stack : Stack
  opMap : OpMap

def applyUnary (op : Int -> Except String Stack) (stack : Stack) : Except String Stack :=
  match stack with
  | [] => .error "empty stack"
  | x :: xs => op x >>= fun rs => .ok (rs ++ xs)

def applyBinary (op : Int -> Int -> Except String Stack) (stack : Stack) : Except String Stack :=
  match stack with
  | [] => .error "empty stack"
  | _ :: [] => .error "only one value on the stack"
  | x1 :: x2 :: xs => op x2 x1 >>= fun rs => .ok (rs ++ xs)

def parseExpression (state : State) (expression : String) : Except String State :=
  match expression.toInt? with
  | some value => .ok { state with stack := (value :: state.stack) } -- if number, adds it to the stack
  | none => match state.opMap.get? expression with
            | some op => op state.stack >>= (.ok { state with stack := · }) -- applies op, gets the resulting stack and replaces state stack with it
            | none => .error "undefined operation"                         

def checkOp (op : String) (opMap : OpMap) : Except String Op :=
  match opMap.get? op with
  | some op => .ok op  -- if op is a key already in map, return its op -> this allows for indirect ops that reference previously defined user-ops
  | none => .ok (fun stack => parseExpression { stack := stack, opMap := opMap } op >>= fun state => .ok state.stack) -- otherwise, an op is nothing more than an expression to parse

def addUserOp (pattern : String) (state : State) : Except String Op :=
  let exceptOps := pattern.splitOn " " |> (·.mapM (checkOp · state.opMap))
  exceptOps >>= fun ops => .ok (ops.foldlM (fun acc op => op acc))

def parseInstruction (state : State) (instruction : String) : Except String State :=
  let expressions := instruction.toLower.splitOn " "
  match expressions with
  | [] => .ok state
  | ":" :: key :: xs =>
    match key.toInt? with
    | some _ => .error "illegal operation"  -- number can't be an user-defined op
    | none =>
      let userOp := String.intercalate " " xs.dropLast -- drops ; at the end
      addUserOp userOp state >>= fun op => .ok { state with opMap := state.opMap.insert key op } -- adds op to map, possibly replacing previous op with same key
  | _ => expressions.foldlM parseExpression state -- parses expressions, short-circuiting on error

def evaluate (instructions : List String) : Except String Stack :=
  let initial : State := {
    stack := [],
    opMap := .ofList [
      -- in all binary ops, b is the top of the stack and a is further inside
      ("+", applyBinary (fun a b => .ok [a + b])),
      ("-", applyBinary (fun a b => .ok [a - b])),
      ("*", applyBinary (fun a b => .ok [a * b])),
      ("/", applyBinary (fun a b => if b == 0 then .error "divide by zero" else .ok [a / b])),
      ("dup", applyUnary (fun a => .ok [a, a])),
      ("drop", applyUnary (fun a => .ok [])),
      ("swap", applyBinary (fun a b => .ok [a, b])),
      ("over", applyBinary (fun a b => .ok [a, b, a]))
    ]
  }

  instructions.foldlM parseInstruction initial -- monadic fold, short-circuits on error
  >>= fun state => .ok state.stack.reverse     -- if successful, returns stack reversed lifted to Except

end Forth
