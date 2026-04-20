import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace AlphameticsGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

-- Canonical data's `expected` is either `null` (no solution) or an
-- object like `{\"I\": 1, \"B\": 9, \"L\": 0}`. We render as
-- `none` or `(some [('B', 9), ('I', 1), ('L', 0)])`; keys are read out
-- of the JSON object in RBNode order, which is alphabetical by string,
-- matching what Example.lean's `solve` produces.
def renderExpected (expected : Json) : String :=
  if expected.isNull then
    "none"
  else
    let pairs := getOk expected.getObj?
                  |>.toList
                  |>.map (fun (k, v) => s!"('{k.toList.head!}', {v})")
                  |> String.intercalate ", "
    s!"(some [{pairs}])"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {insertAllInputs input})"
  s!"
  |>.addTest {description} (do
      return assertEqual {renderExpected expected}\n          {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end AlphameticsGenerator
