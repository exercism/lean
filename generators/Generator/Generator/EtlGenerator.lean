import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace EtlGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}
import Std

open LeanTest
open Std

instance : BEq (HashMap Char Nat) where
  beq h1 h2 :=
    h1.size == h2.size &&
    h1.fold (fun acc k v =>
      acc && match h2.get? k with
      | some v' => v == v'
      | none    => false
    ) true

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input" |> (·.getObjValD "legacy")
  let legacyKeys := (getKeyValues input).map (λ (k, v) => (toLiteral k, v.replace "\"" "'"))
  let expected := case.get! "expected"
  let expectedKeys := (getKeyValues expected).map (λ (k, v) => (s!"'{k}'", toLiteral v))
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} (.ofList {legacyKeys}))"
  s!"
  |>.addTest {description} (do
      return assertEqual (.ofList {expectedKeys}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end EtlGenerator
