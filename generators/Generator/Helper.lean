import Std
import Lean.Data.Json

open Std
open Lean

namespace Helper

def exceptEquality : String :=
s!"instance \{α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false"

def indent : String := "      "

def toCamel (string : String) : String :=
  (string.splitOn " ").map String.capitalize
    |> String.join
    |> String.decapitalize

def toLiteral (string : String) : String :=
  string.toList.filter (·!='"') |> (·.asString)

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> (·.get!)

def intLiteral (n : Int) : String :=
  if n < 0 then s!"({n})"
  else s!"{n}"

def errorToOption (expected : Json) : Option String :=
  match expected.getObjVal? "error" with
  | .ok _    => none
  | .error _ =>
      match expected.getInt? with
      | .error _ => some s!"{expected}"
      | .ok n => intLiteral n

def toExcept (expected : Json) : Except String Json :=
  match expected.getObjVal? "error" with
  | .error _ => .ok expected
  | .ok msg  => .error msg.compress

def exceptToString {α β} [ToString α] [ToString β] (except : Except α β) : String :=
  match except with
  | .ok value => s!"(.ok {value})"
  | .error msg => s!"(.error {msg})"

def getKeyValues (json : Json) : List (String × String) :=
  getOk json.getObj? |>.toList |>.map (λ (a, b) => (a, b.compress))

def insertAllInputs (input : Json) : String :=
  let values := getKeyValues input
  values.map (fun (_,val) => s!"{val}") |> (String.intercalate " " .)

def toFloat (value : Json) : Float :=
  value.getNum? |> (getOk .) |> (·.toFloat)

def getFunName (property : Json) : String :=
  toLiteral property.compress

def toStruct (string : String) : String :=
  string.replace "[" "⟨" |> (·.replace "]" "⟩")

def serializeContent
  (json : Json)
  (serializer : Json → String)
    : List String :=
  json.getArr?
      |> getOk
      |>.map serializer
      |>.toList

def serializeList
  (json : Json)
  (serializer : Json → String := fun j => s!"{j}")
  (separator : String := s!",\n{indent}  ")
    : String :=
    let contents := serializeContent json serializer
    match contents with
    | [] => "[]"
    | xs =>
      let joined := String.intercalate separator xs
      s!"[\n{indent}  {joined}\n{indent}]"

def serializeObjectAsList
  (json : Json)
  (serializer : String → Json → String := fun k v => s!"[{k}, {v}]")
  (separator : String := s!",\n{indent}  ")
    : String :=
    let joined := getOk json.getObj?
      |>.toList
      |>.map (Function.uncurry serializer)
      |> String.intercalate separator
    s!"[\n{indent}  {joined}\n{indent}]"

end Helper
