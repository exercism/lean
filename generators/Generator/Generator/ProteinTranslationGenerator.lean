import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace ProteinTranslationGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{exceptEquality}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := toExcept (case.get! "expected")
              |> (·.bind (·.getArr?))
              |> (·.bind (·.map (·.compress |> (s!"." ++ toLiteral ·)) |> (pure ·)))
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {insertAllInputs input})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected |> (exceptToString ·)} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ProteinTranslationGenerator
