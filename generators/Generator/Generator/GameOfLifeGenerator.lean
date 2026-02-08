import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace GameOfLifeGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def serializeRow (json : Json) : String :=
  s!"#{json.compress |>.replace "0" "false" |>.replace "1" "true" |>.replace "," ", "}"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input" |>.getObjValD "matrix"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} #{serializeList input serializeRow})"
  s!"
  |>.addTest {description} (do
      return assertEqual #{serializeList expected serializeRow} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end GameOfLifeGenerator
