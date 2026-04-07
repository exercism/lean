import Lean.Data.Json
import Std

open Lean
open Std

namespace BinarySearchGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
(TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let description := case.get! "description"
              |> (·.compress)
  let funName := case.get! "property"
              |> (·.compress)
              |> String.toList
              |> (·.filter (·!='"'))
              |> String.ofList
  let input := case.get! "input"
  let value := input.getObjValD "value"
  let array := input.getObjValD "array"
  let expected := case.get! "expected"
  match expected.getObjVal? "error" with
  | .error _ =>
    s!"
    |>.addTest {description} (do
        return assertEqual (some {expected}) ({exercise}.{funName} {value} #{array}))"
  | .ok _ =>
    s!"
    |>.addTest {description} (do
        return assertEqual none ({exercise}.{funName} {value} #{array}))"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end BinarySearchGenerator
