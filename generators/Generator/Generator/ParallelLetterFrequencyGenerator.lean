import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ParallelLetterFrequencyGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

instance : BEq (Std.TreeMap Char Nat) where
  beq a b := a.toList == b.toList

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
               |> (getKeyValues ·)
               |> (·.map (fun (k, v) => (s!"'{k}'", v)))
  let result := if expected.isEmpty
                then "{}"
                else s!"Std.TreeMap.ofList {expected}"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {insertAllInputs input})"
  s!"
  |>.addTest {description} (do
      let start ← IO.monoNanosNow
      let actual ← {call}
      let stop ← IO.monoNanosNow
      let expected : Std.TreeMap Char Nat := {result}
      IO.println s!\"Execution time for '{toLiteral description}': \{stop - start} ns\"
      return assertEqual expected actual)"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ParallelLetterFrequencyGenerator
