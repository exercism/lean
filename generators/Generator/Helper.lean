import Std
import Lean

open Std
open Lean

namespace Helper

def exceptEquality : String :=
s!"instance \{α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false"

def toLiteral (string : String) : String :=
  string.toList.filter (·!='"') |> (·.asString)

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> (·.get!)

def errorToOption (expected : Json) : Option String :=
  match expected.getObjVal? "error" with
  | .error _ => some s!"{expected}"
  | .ok _    => none

def toExcept (expected : Json) : Except String Json :=
  match expected.getObjVal? "error" with
  | .error _ => .ok expected
  | .ok msg  => .error msg.compress

def exceptToString {α β} [ToString α] [ToString β] (except : Except α β) : String :=
  match except with
  | .ok value => s!"(.ok {value})"
  | .error msg => s!"(.error {msg})"

def keyRest (delim : Char) : List Char -> List Char -> List Char × List Char
  | [], acc => (acc, [])
  | k :: rs, acc =>
    if k == delim then (acc, rs)
    else keyRest delim rs (k :: acc)

def getKeyValues (json : Json) : List (String × String) := Id.run do
  let mut chars := json.compress.toList.filter (fun c => c != '}' && c != '{')
  let mut acc := []
  while !chars.isEmpty do
    let (key, rest) := keyRest ':' chars []
    let (val, next) := keyRest ',' rest []
    chars := next
    acc := (key.reverse.asString, val.reverse.asString) :: acc
  acc.reverse

def insertAllInputs (input : Json) : String :=
  let values := getKeyValues input
  values.map (fun (_,val) => s!"{val}") |> (String.intercalate " " .)

def intLiteral (n : Int) : String :=
  if n < 0 then s!"({n})"
  else s!"{n}"

def toFloat (value : Json) : Float :=
  value.getNum? |> (getOk .) |> (·.toFloat)

def getFunName (property : Json) : String :=
  toLiteral property.compress

end Helper
