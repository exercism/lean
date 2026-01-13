import Lean
import Std

open Lean
open Std

namespace ForthGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  match input.getObjVal? "instructions" with
  | .error _ => ""
  | .ok inputValueJson =>
    let inputValue := inputValueJson.getArr?
                      |> Except.toOption
                      |> Option.get!
                      |> Array.toList

    let expected := case.get! "expected"
    let result := match expected |> (·.getObjVal? "error") with
                  | .error _ =>
                      some (
                        expected.getArr?
                        |> Except.toOption
                        |> Option.get!
                        |> Array.toList
                      )
                  | .ok _ => none
    let description := case.get! "description"
                |> (·.compress)
    let funName := case.get! "property"
                |> (·.compress)
                |> String.toList
                |> (·.filter (·!='"'))
                |> List.asString
    s!"
    |>.addTest {description} (do
        return assertEqual {result} ({exercise}.{funName} {inputValue}))"

def genEnd (exercise : String) : String :=
  s!"

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
  "

end ForthGenerator
