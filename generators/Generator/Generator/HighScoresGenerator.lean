import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace HighScoresGenerator

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
  let callList := s!"({exercise}.{funName}List {input.getObjValD "scores"})"
  let callArr := s!"({exercise}.{funName}Array #{input.getObjValD "scores"})"
  match funName with
  | "scores" | "personalTopThree" =>
    s!"
    |>.addTest {description} (do
        return assertEqual {expected} {callList})
    |>.addTest {description} (do
        return assertEqual #{expected} {callArr})"
  | _ =>
    s!"
    |>.addTest {description} (do
        return assertEqual {expected} {callList})
    |>.addTest {description} (do
        return assertEqual {expected} {callArr})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end HighScoresGenerator
