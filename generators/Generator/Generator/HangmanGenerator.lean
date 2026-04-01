import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace HangmanGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{exceptEquality}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let word := input.getObjValD "word" |>.compress
  let guesses := input.getObjValD "guesses"
                 |>.getArr?
                 |> getOk
                 |>.map (fun j => s!"'{toLiteral s!"{j}"}'")
                 |>.toList
  let call := s!"({exercise}.{funName} {word} {guesses})"
  match expected.getObjVal? "error" with
  | .ok msg =>
    s!"
    |>.addTest {description} (do
        return assertEqual
          (.error {msg})
          {call})"
  | .error _ =>
    let state := expected.getObjValD "state" |>.compress |> toLiteral |>.decapitalize
    let remainingFailures := expected.getObjValD "remainingFailures"
    let maskedWord := expected.getObjValD "maskedWord"
    s!"
    |>.addTest {description} (do
        return assertEqual (.ok \{
            state := .{state},
            remainingFailures := {remainingFailures},
            maskedWord := {maskedWord}
          })
          {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end HangmanGenerator
