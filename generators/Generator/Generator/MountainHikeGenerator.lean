import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace MountainHikeGenerator

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
  let call := s!"({exercise}.{funName} {insertAllInputs input})"
  -- `expected` may be a negative Int (e.g. elevationChange going downhill), which needs
  -- parentheses: `assertEqual -250 (...)` parses as subtraction, not a negative literal.
  let expectedLiteral := match expected.getInt? with
    | .ok n => intLiteral n
    | .error _ => s!"{expected}"
  let taskArg := match case.get? "task" with
    | some task => s!" (taskId := some {task})"
    | none => ""
  s!"
  |>.addTest {description} (do
      return assertEqual {expectedLiteral} {call}){taskArg}"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end MountainHikeGenerator
