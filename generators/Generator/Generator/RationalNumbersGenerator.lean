import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace RationalNumbersGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

theorem check : ∀ (r : {exercise}.RationalNumber), r.den > 0 ∧ Int.gcd r.num r.den = 1 := by
  exact {exercise}.RationalNumber.h

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def getNum (json : Json) : Float :=
  getOk json.getNum? |>.toFloat

def rationalNumberLiteral (json : Json) : String :=
  toStruct s!"{json}" |>.replace "⟩" ", by decide⟩"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  match funName with
  | "exprational" =>
    let call := s!"({exercise}.{funName} {rationalNumberLiteral <| input.getObjValD "r"} {input.getObjValD "n" |>.getInt? |> getOk |> intLiteral})"
    s!"
    |>.addTest {description} (do
        return assertEqual {rationalNumberLiteral expected} {call})"
  | "expreal" =>
    let call := s!"({exercise}.{funName} {input.getObjValD "x"} {rationalNumberLiteral <| input.getObjValD "r"})"
    let result := getNum expected
    s!"
    |>.addTest {description} (do
        return assertInRange {call} {result - 0.001} {result + 0.001})"
  | _ =>
    let call := match input.getObjVal? "r1" with
                | .ok r1 => s!"({exercise}.{funName} {rationalNumberLiteral r1} {rationalNumberLiteral (input.getObjValD "r2")})"
                | .error _ => s!"({exercise}.{funName} {rationalNumberLiteral (input.getObjValD "r")})"
    s!"
    |>.addTest {description} (do
        return assertEqual {rationalNumberLiteral expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end RationalNumbersGenerator
