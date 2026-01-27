import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace PalindromeProductsGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let min := input.getObjValD "min"
  let max := input.getObjValD "max"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {min} {max})"
  match expected.getObjVal? "error" with
  | .error _ =>
    let expectedValue := expected.getObjValD "value"
    let expectedFactors := expected.getObjValD "factors"
                            |> (·.compress) |> (·.drop 1) |> (·.dropRight 1)
    let result := if expectedValue.isNull
                  then s!".empty"
                  else s!"(.valid {expectedValue} [{toStruct expectedFactors}])"
    s!"
    |>.addTest {description} (do
        return assertEqual {result} {call})"
  | _ =>
    s!"
    |>.addTest {description} (do
        return assertEqual .invalid {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end PalindromeProductsGenerator
