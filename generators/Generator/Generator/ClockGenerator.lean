import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ClockGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def formatInt (json : Json) (key : String) : String :=
  intLiteral $ getOk $ Json.getInt? $ json.getObjValD key

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  match funName with
  | "create" =>
    let clock := s!"let clock := {exercise}.{funName} {formatInt input "hour"} {formatInt input "minute"}"
    let call := s!"(s!\"\{clock}\")"
    s!"
    |>.addTest {description} (do
      {clock}
      return assertEqual {expected} {call})"
  | "add" | "subtract" =>
    let originalClock := s!"let original := {exercise}.create {formatInt input "hour"} {formatInt input "minute"}"
    let transformedClock := s!"let transformed := {exercise}.{funName} original {formatInt input "value"}"
    let call := s!"(s!\"\{transformed}\")"
    s!"
    |>.addTest {description} (do
      {originalClock}
      {transformedClock}
      return assertEqual {expected} {call})"
  | _ =>
    let clock1 := input.getObjValD "clock1"
    let clock2 := input.getObjValD "clock2"
    let clock1Str := s!"let clock1 := {exercise}.create {formatInt clock1 "hour"} {formatInt clock1 "minute"}"
    let clock2Str := s!"let clock2 := {exercise}.create {formatInt clock2 "hour"} {formatInt clock2 "minute"}"
    s!"
    |>.addTest {description} (do
      {clock1Str}
      {clock2Str}
      return assertEqual {expected} (clock1 == clock2))"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ClockGenerator
