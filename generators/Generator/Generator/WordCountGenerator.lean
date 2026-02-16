import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace WordCountGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import Std
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected" |> (serializeObjectAsList · λ k v => s!"(\"{k}\", {v})")
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| {exercise}.{funName} {insertAllInputs input})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end WordCountGenerator
