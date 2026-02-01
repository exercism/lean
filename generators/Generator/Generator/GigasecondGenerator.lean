import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace GigasecondGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import Std
import Lean
import {exercise}

open LeanTest
open Lean
open Std.Time

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := toLiteral <| insertAllInputs <| case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let adjustedInput := if !input.contains 'T' then s!"\"{input ++ "T00:00:00"}\"" else s!"\"{input}\""
  let call := s!"({exercise}.{funName} datetime({adjustedInput}))"
  s!"
  |>.addTest {description} (do
      return assertEqual datetime({expected}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end GigasecondGenerator
