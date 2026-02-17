import Lean.Data.Json
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

def Std.HashMap.toSortedList (map : Std.HashMap Char Nat) :=
  map.toArray.qsort (λ (k1, _) (k2, _) => k1 ≤ k2)

instance : BEq (Std.HashMap Char Nat) where
  beq a b := a.toSortedList == b.toSortedList

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def mapJsonArray (array : Json) : String :=
  array.getArr?
    |> getOk
    |>.map (λ v => s!"'{toLiteral v.compress}'")
    |>.toList
    |> (s!"{·}")

def serializeLegacy (key : String) (val : Json) : String :=
  s!"({key}, {mapJsonArray val})"

def serializeOutput (key : String) (val : Json) : String :=
  s!"('{key}', {val})"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input" |>.getObjValD "legacy"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"$ {exercise}.{funName} (.ofList {serializeObjectAsList input serializeLegacy})"
  s!"
  |>.addTest {description} (do
      return assertEqual (.ofList {serializeObjectAsList expected serializeOutput}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end EtlGenerator
