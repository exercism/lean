import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace GigasecondGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}
import Std.Time

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

structure DateTimeValues where
  year   : Nat
  month  : Nat
  day    : Nat
  hour   : Nat
  minute : Nat
  second : Nat
  deriving Inhabited

def charsToNat (chars : List Char) : Nat :=
  chars.asString.toNat!

def parseInput : List Char → Option DateTimeValues
  | y1 :: y2 :: y3 :: y4 :: '-' :: m1 :: m2 :: '-' :: d1 :: d2 :: 'T' :: h1 :: h2 :: ':' :: mn1 :: mn2 :: ':' :: s1 :: s2 :: _ => some {
    year := charsToNat [y1, y2, y3, y4],
    month := charsToNat [m1, m2],
    day := charsToNat [d1, d2],
    hour := charsToNat [h1, h2],
    minute := charsToNat [mn1, mn2],
    second := charsToNat [s1, s2]
  }
  | y1 :: y2 :: y3 :: y4 :: '-' :: m1 :: m2 :: '-' :: d1 :: d2 :: _ => some {
    year := charsToNat [y1, y2, y3, y4],
    month := charsToNat [m1, m2],
    day := charsToNat [d1, d2],
    hour := 0,
    minute := 0,
    second := 0
  }
  | _ => none

def toPlainDateTime (values : DateTimeValues) : String :=
  s!"Std.Time.PlainDateTime.mk (Std.Time.PlainDate.mk {values.year} {values.month} {values.day} (by decide)) (Std.Time.PlainTime.mk {values.hour} {values.minute} {values.second} 0)"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := String.toList <| toLiteral <| insertAllInputs <| case.get! "input"
  let inputValues := Option.get! <| parseInput input
  let expected := String.toList <| toLiteral <| Json.compress <| case.get! "expected"
  let expectedValues := Option.get! <| parseInput expected
  let adjustedInput := toPlainDateTime inputValues
  let adjustedExpected := toPlainDateTime expectedValues
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} ({adjustedInput}))"
  s!"
  |>.addTest {description} (do
      return assertEqual ({adjustedExpected}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end GigasecondGenerator
