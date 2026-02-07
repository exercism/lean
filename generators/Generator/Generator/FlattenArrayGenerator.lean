import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace FlattenArrayGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def serializeList2
  (indent : String)
  (json : Json)
  (serializer : Json → String := fun j => s!"{j}")
    : String :=
    let separator : String := s!",\n{indent}  "
    let contents := serializeContent json serializer
    match contents with
    | [] => "[]"
    | xs =>
      let joined := String.intercalate separator xs
      s!"[\n{indent}  {joined}\n{indent}]"

partial def serializeInt (num : Json) : String :=
  num |>.getInt? |> getOk |> intLiteral

partial def serializer (indent : String) (array : Json) : String :=
  match array with
  | .num _ => s!"(FlattenArray.Box.one {serializeInt array})"
  | .arr _ => "(FlattenArray.Box.many #" ++ (serializeList2 indent array (serializer (indent ++ "  "))) ++ ")"
  | _ => "FlattenArray.Box.zero"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let array := case.get! "input"
              |> (·.getObjValD "array")
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {serializer indent array})"
  s!"
  |>.addTest {description} (do
      return assertEqual #{serializeList expected serializeInt ", "} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end FlattenArrayGenerator
