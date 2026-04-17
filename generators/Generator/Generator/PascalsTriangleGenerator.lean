import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace PascalsTriangleGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{concatAsserts}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let count := case.get! "input" |>.getObjValD "count" |>.getNat? |> getOk
  let expected := case.get! "expected" |>.getArr? |> getOk
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"{exercise}.mkTriangle"
  match funName with
  | "rows" =>
    s!"
  |>.addTest {description} (do
      let triangle : {exercise}.Triangle ← {call}
      {(Id.run do
        let start := s!"let mut result := assertEqual #[] (← triangle(0))"
        let mut res := [start]
        for n in [:expected.size] do
          let row := expected[n]!
          res := s!"      result := result ++ assertEqual #{row} (← triangle({n + 1}))" :: res
        return String.intercalate "\n" res.reverse)}
      return result)"
  | "property" =>
    s!"
  |>.addTest {description} (do
      let triangle : {exercise}.Triangle ← {call}
      let row ← triangle({count})
      let prev ← triangle({count - 1})
      let mut result := (assertEqual {count} row.size) ++ (assertEqual {count - 1} prev.size)
      result := result ++ (assertEqual 1 row[0]!) ++ (assertEqual 1 row[row.size - 1]!)
      for i in [1:row.size - 1] do
        result := result ++ assertEqual row[i]! (prev[i - 1]! + prev[i]!)
      return result)"
  | _ => ""

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end PascalsTriangleGenerator
