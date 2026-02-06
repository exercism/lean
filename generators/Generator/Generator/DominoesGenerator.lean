import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace DominoesGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def serializer (domino : Json) : String :=
  let array := domino.getArr? |> getOk
  let first := array[0]!
  let second := array[1]!
  s!"(⟨{first}, by decide⟩, ⟨{second}, by decide⟩)"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let dominoes := case.get! "input" |>.getObjVal? "dominoes" |> getOk
  let expected := case.get! "expected" |>.getBool? |> getOk
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {serializeList dominoes serializer})"
  let assert := match expected with
                | true => s!"assertTrue {call}"
                | false => s!"assertFalse {call}"
  s!"
  |>.addTest {description} (do
      return {assert})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end DominoesGenerator
