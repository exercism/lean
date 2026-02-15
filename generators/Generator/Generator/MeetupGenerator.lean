import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace MeetupGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let year := input.getObjValD "year"
  let month := input.getObjValD "month"
  let week := "." ++ toLiteral s!"{input.getObjValD "week"}"
  let dayofweek := "." ++ toLiteral s!"{input.getObjValD "dayofweek"}"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {dayofweek} ⟨{month}, by decide⟩ {week} {year})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end MeetupGenerator
