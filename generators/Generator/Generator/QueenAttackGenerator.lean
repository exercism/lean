import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace QueenAttackGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

theorem check (q : {exercise}.Queen) : q.row ≥ 0 ∧ q.row < 8 ∧ q.col ≥ 0 ∧ q.col < 8 := by
  simp [q.h]

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def getPos (queen : Json) : (String × String) :=
  let position := queen.getObjValD "position"
  let row := position.getObjValD "row" |>.getInt? |> getOk |> intLiteral
  let col := position.getObjValD "column" |>.getInt? |> getOk |> intLiteral
  (row, col)

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  match getFunName (case.get! "property") with
  | "create" =>
    let (row, col) := getPos (input.getObjValD "queen")
    let result := match expected.getObjVal? "error" with
      | .ok _    => "none"
      | .error _ => s!"(some \{ row := {row}, col := {col}, h := by decide })"
    s!"
  |>.addTest {description} (do
      let queen : Option {exercise}.Queen := {exercise}.create? {row} {col}
      return assertEqual {result} queen)"
  | "canAttack" =>
    let (wrow, wcol) := getPos (input.getObjValD "white_queen")
    let (brow, bcol) := getPos (input.getObjValD "black_queen")
    let result := expected.getBool? |> getOk |> (s!"{·}") |>.capitalize
    s!"
  |>.addTest {description} (do
      match {exercise}.create? {wrow} {wcol}, {exercise}.create? {brow} {bcol} with
      | some white, some black => return assert{result} ({exercise}.canAttack white black)
      | _, _ => return (.failure \"failed to create a valid queen\"))"
  | _ => ""

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end QueenAttackGenerator
