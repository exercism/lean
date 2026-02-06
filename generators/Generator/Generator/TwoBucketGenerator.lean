import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace TwoBucketGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let one := input.getObjValD "bucketOne"
  let two := input.getObjValD "bucketTwo"
  let goal := input.getObjValD "goal"
  let start := "." ++ toLiteral s!"{input.getObjValD "startBucket"}"
  let expected := case.get! "expected"
  let moves := expected.getObjValD "moves"
  let goalBucket := "." ++ toLiteral s!"{expected.getObjValD "goalBucket"}"
  let other := expected.getObjValD "otherBucket"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {one} {two} {goal} {start})"
  let result := match expected.getObjVal? "error" with
                | .error _ => s!"(some ⟨{moves}, {goalBucket}, {other}⟩)"
                | .ok _ => "none"
  s!"
  |>.addTest {description} (do
      return assertEqual {result} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end TwoBucketGenerator
