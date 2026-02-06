import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace PerfectNumbersGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let number := toLiteral (input.getObjValD "number" |> (·.compress))
  let expected := toLiteral (case.get! "expected" |> (·.compress))
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} ⟨{number}, by decide⟩)"
  s!"
  |>.addTest {description} (do
      return assertEqual {exercise}.Classification.{expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end PerfectNumbersGenerator
