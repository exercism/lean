import LeanTest
import GameOfLife

open LeanTest

def gameOfLifeTests : TestSuite :=
  (TestSuite.empty "GameOfLife")
  |>.addTest "empty matrix" (do
      return assertEqual #[] (GameOfLife.tick #[]))
  |>.addTest "live cells with zero live neighbors die" (do
      return assertEqual #[#[false, false, false], #[false, false, false], #[false, false, false]] (GameOfLife.tick #[#[false, false, false], #[false, true, false], #[false, false, false]]))
  |>.addTest "live cells with only one live neighbor die" (do
      return assertEqual #[#[false, false, false], #[false, false, false], #[false, false, false]] (GameOfLife.tick #[#[false, false, false], #[false, true, false], #[false, true, false]]))
  |>.addTest "live cells with two live neighbors stay alive" (do
      return assertEqual #[#[false, false, false], #[true, false, true], #[false, false, false]] (GameOfLife.tick #[#[true, false, true], #[true, false, true], #[true, false, true]]))
  |>.addTest "live cells with three live neighbors stay alive" (do
      return assertEqual #[#[false, false, false], #[true, false, false], #[true, true, false]] (GameOfLife.tick #[#[false, true, false], #[true, false, false], #[true, true, false]]))
  |>.addTest "dead cells with three live neighbors become alive" (do
      return assertEqual #[#[false, false, false], #[true, true, false], #[false, false, false]] (GameOfLife.tick #[#[true, true, false], #[false, false, false], #[true, false, false]]))
  |>.addTest "live cells with four or more neighbors die" (do
      return assertEqual #[#[true, false, true], #[false, false, false], #[true, false, true]] (GameOfLife.tick #[#[true, true, true], #[true, true, true], #[true, true, true]]))
  |>.addTest "bigger matrix" (do
      return assertEqual #[#[true, true, false, true, true, false, false, false], #[false, false, false, false, false, true, true, false], #[true, false, true, true, true, true, false, true], #[true, false, false, false, false, false, false, true], #[true, true, false, false, true, false, false, true], #[true, true, false, true, false, false, false, true], #[true, false, false, false, false, false, false, false], #[false, false, false, false, false, false, true, true]] (GameOfLife.tick #[#[true, true, false, true, true, false, false, false], #[true, false, true, true, false, false, false, false], #[true, true, true, false, false, true, true, true], #[false, false, false, false, false, true, true, false], #[true, false, false, false, true, true, false, false], #[true, true, false, false, false, true, true, true], #[false, false, true, false, true, false, false, true], #[true, false, false, false, false, false, true, true]]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [gameOfLifeTests]
