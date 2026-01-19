import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace AllergiesGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  match expected.getArr? with
  | .error _ =>
    let call := s!"({exercise}.{funName} {"." ++ toLiteral (insertAllInputs input)})"
    s!"
    |>.addTest {description} (do
        return assertEqual {expected} {call})"
  | .ok _ =>
    let call := s!"({exercise}.{funName} {insertAllInputs input})"
    s!"
    |>.addTest {description} (do
        return assertEqual {getOk expected.getArr? |> (·.map ("." ++ toLiteral ·.compress)) |> (·.toList)} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end AllergiesGenerator
