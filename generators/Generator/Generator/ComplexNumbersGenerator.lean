import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ComplexNumbersGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

/- define equality between two complex numbers -/
instance : BEq {exercise}.ComplexNumber where
  beq x y := Float.abs (x.real - y.real) <= 0.001 &&
             Float.abs (x.imag - y.imag) <= 0.001

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def constantsToFloat (string : String) : String :=
  string.replace "pi" "3.14159265359"
    |> (·.replace "e" "2.71828182845")
    |> (·.replace "ln(2)" "(Float.log 2)")
    |> (toLiteral ·)

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let allInputs := toStruct (insertAllInputs input)
  let normalizedExpected :=
    match expected.getArr? with
    | .error _ => toStruct s!"{expected}"
    | .ok arr => arr.map (fun json => match json.getNum? with
                                      | .error _ => s!"{json}"
                                      | .ok num => s!"{num}")
                |> (·.toList)
                |> (s!"{·}")
                |> (toStruct ·)
  let call := s!"({exercise}.{funName} {constantsToFloat allInputs})"
  s!"
  |>.addTest {description} (do
      return assertEqual {constantsToFloat normalizedExpected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ComplexNumbersGenerator
