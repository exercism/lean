import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace RunLengthEncodingGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String := Id.run do
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let mut funName := getFunName (case.get! "property")
  if funName == "consistency" then funName := s!"encode |> {exercise}.decode"
  let call := s!"({insertAllInputs input} |> {exercise}.{funName})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end RunLengthEncodingGenerator
