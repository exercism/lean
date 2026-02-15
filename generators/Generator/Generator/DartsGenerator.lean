import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace DartsGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def toLiteral (v : Json) : String :=
  let str := s!"{Json.getNum? v |> getOk}"
  if str.startsWith "-" then s!"({str})" else str

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let x := input |> (·.getObjValD "x") |> toLiteral
  let y := input |> (·.getObjValD "y") |> toLiteral
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {x} {y})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end DartsGenerator
