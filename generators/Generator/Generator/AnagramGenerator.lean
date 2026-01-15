import Lean
import Std

open Lean
open Std

namespace AnagramGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let subject := input.getObjValD "subject"
  let candidates := input.getObjValD "candidates"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := case.get! "property"
              |> (·.compress)
              |> String.toList
              |> (·.filter (·!='"'))
              |> List.asString
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} ({exercise}.{funName} {subject} {candidates}))"

def genEnd (exercise : String) : String :=
  s!"

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
  "

end AnagramGenerator
