import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace SeriesGenerator

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
  match expected |> (·.getObjVal? "error") with
  | .ok _ =>
      s!"
      |>.addTest {description} (do
          return assertEqual none {call})"
  | .error _ =>
      s!"
      |>.addTest {description} (do
          return assertEqual (some #{expected}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end SeriesGenerator
