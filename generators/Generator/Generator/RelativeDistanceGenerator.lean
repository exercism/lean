import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace RelativeDistanceGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := match case.get! "expected" |>.getNat? with
                  | .error _ => none
                  | .ok x    => some x
  let description := case.get! "description"
              |> (·.compress)
  let inputKeyVals := getKeyValues (input.getObjValD "familyTree")
                        |>.eraseP (λ (k, _) => k == "playerA")
                        |>.eraseP (λ (k, _) => k == "playerB")
                        |>.map (λ (k, v) => (s!"\"{k}\"", v))
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {inputKeyVals} {input.getObjValD "personA"} {input.getObjValD "personB"})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end RelativeDistanceGenerator
