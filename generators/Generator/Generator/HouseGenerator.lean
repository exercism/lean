import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace HouseGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let startVerse := input.getObjValD "startVerse" |> (s!"⟨{·}, by decide⟩")
  let endVerse := input.getObjValD "endVerse" |> (s!"⟨{·}, by decide⟩")
  let expected := serializeList (case.get! "expected")
                    |> (s!"(String.intercalate \"\\n\\n\" {·})")
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {startVerse} {endVerse})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end HouseGenerator
