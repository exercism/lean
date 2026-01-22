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
  let map := getOk json.getObj?
  let list := map.toList
  let string := json.compress
  let sorted := list.mergeSort (fun (k1, _) (k2, _) =>
                  let pos1 := string.toSlice.find? k1 |> (Option.get! ·)
                  let pos2 := string.toSlice.find? k2 |> (Option.get! ·)
                  pos1 < pos2
                )
  sorted.map (fun (k, v) => (k, v.compress))

def insertAllInputs (input : Json) : String :=
  let values := getKeyValues input
  values.map (fun (_,val) => s!"{val}") |> (String.intercalate " " .)

def toFloat (value : Json) : Float :=
  value.getNum? |> (getOk .) |> (·.toFloat)

def getFunName (property : Json) : String :=
  toLiteral property.compress

def toStruct (string : String) : String :=
  string.replace "[" "⟨" |> (·.replace "]" "⟩")

end Helper
