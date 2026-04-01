import LeanTest
import QueenAttack

open LeanTest

theorem check (q : QueenAttack.Queen) : q.row ≥ 0 ∧ q.row < 8 ∧ q.col ≥ 0 ∧ q.col < 8 := by
  simp [q.h]

def queenAttackTests : TestSuite :=
  (TestSuite.empty "QueenAttack")
  |>.addTest "Test creation of Queens with valid and invalid positions -> queen with a valid position" (do
      let queen : Option QueenAttack.Queen := QueenAttack.create? 2 2
      return assertEqual (some { row := 2, col := 2, h := by decide }) queen)
  |>.addTest "Test creation of Queens with valid and invalid positions -> queen must have positive row" (do
      let queen : Option QueenAttack.Queen := QueenAttack.create? (-2) 2
      return assertEqual none queen)
  |>.addTest "Test creation of Queens with valid and invalid positions -> queen must have row on board" (do
      let queen : Option QueenAttack.Queen := QueenAttack.create? 8 4
      return assertEqual none queen)
  |>.addTest "Test creation of Queens with valid and invalid positions -> queen must have positive column" (do
      let queen : Option QueenAttack.Queen := QueenAttack.create? 2 (-2)
      return assertEqual none queen)
  |>.addTest "Test creation of Queens with valid and invalid positions -> queen must have column on board" (do
      let queen : Option QueenAttack.Queen := QueenAttack.create? 4 8
      return assertEqual none queen)
  |>.addTest "Test the ability of one queen to attack another -> cannot attack" (do
      match QueenAttack.create? 2 4, QueenAttack.create? 6 6 with
      | some white, some black => return assertFalse (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> can attack on same row" (do
      match QueenAttack.create? 2 4, QueenAttack.create? 2 6 with
      | some white, some black => return assertTrue (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> can attack on same column" (do
      match QueenAttack.create? 4 5, QueenAttack.create? 2 5 with
      | some white, some black => return assertTrue (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> can attack on first diagonal" (do
      match QueenAttack.create? 2 2, QueenAttack.create? 0 4 with
      | some white, some black => return assertTrue (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> can attack on second diagonal" (do
      match QueenAttack.create? 2 2, QueenAttack.create? 3 1 with
      | some white, some black => return assertTrue (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> can attack on third diagonal" (do
      match QueenAttack.create? 2 2, QueenAttack.create? 1 1 with
      | some white, some black => return assertTrue (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> can attack on fourth diagonal" (do
      match QueenAttack.create? 1 7, QueenAttack.create? 0 6 with
      | some white, some black => return assertTrue (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))
  |>.addTest "Test the ability of one queen to attack another -> cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" (do
      match QueenAttack.create? 4 1, QueenAttack.create? 2 5 with
      | some white, some black => return assertFalse (QueenAttack.canAttack white black)
      | _, _ => return (.failure "failed to create a valid queen"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [queenAttackTests]
