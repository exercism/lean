import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace LinkedListGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{concatAsserts}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def iterateOperations (operations : Array Json) : String := Id.run do
  let mut acc : Array String := #[]
  for idx in [0:operations.size] do
    let obj := operations[idx]!
    let op := obj.getObjValD "operation" |>.compress |> toLiteral
    match obj.getObjVal? "value" with
    | .ok value =>
      acc := acc.push s!"list.{op} {value}"
    | .error _  =>
      match obj.getObjVal? "expected" with
      | .error _     =>
        acc := acc.push s!"let _ ← list.{op}"
      | .ok expected =>
        acc := acc.push s!"let result ← list.{op}"
        match op with
        | "count" =>
          acc := acc.push s!"asserts := asserts.push (assertEqual {expected} result)"
        | _ =>
          if expected.isNull then
            acc := acc.push s!"asserts := asserts.push (assertEqual none result)"
          else
            acc := acc.push s!"asserts := asserts.push (assertEqual (some {expected}) result)"
  return String.intercalate s!"\n{indent}" acc.toList

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let operations := case.get! "input" |>.getObjValD "operations" |>.getArr? |> getOk
  let description := case.get! "description"
              |> (·.compress)
  s!"
  |>.addTest {description} (do
      let list : {exercise}.{exercise} Int ← {exercise}.{exercise}.empty
      let mut asserts : Array AssertionResult := #[]
      {iterateOperations operations}
      return (asserts.foldl (· ++ ·) .success))"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end LinkedListGenerator
