import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace KnapsackGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def serializeItem (item : Json) : String :=
  let weight := item.getObjValD "weight" |>.getInt? |> getOk |> intLiteral
  let value := item.getObjValD "value" |>.getInt? |> getOk |> intLiteral
  "{ weight := " ++ weight ++ ", value := " ++ value ++ " }"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let maximumWeight := input.getObjValD "maximumWeight"
  let items := serializeList (input.getObjValD "items") serializeItem
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {maximumWeight} #{items})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end KnapsackGenerator
