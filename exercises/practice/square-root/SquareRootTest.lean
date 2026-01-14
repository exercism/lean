import LeanTest
import SquareRoot

open LeanTest

def squareRootTests : TestSuite :=
  (TestSuite.empty "SquareRoot")
  |>.addTest "root of 1" (do
      return assertEqual 1 (SquareRoot.squareRoot 1))
  |>.addTest "root of 4" (do
      return assertEqual 2 (SquareRoot.squareRoot 4))
  |>.addTest "root of 25" (do
      return assertEqual 5 (SquareRoot.squareRoot 25))
  |>.addTest "root of 81" (do
      return assertEqual 9 (SquareRoot.squareRoot 81))
  |>.addTest "root of 196" (do
      return assertEqual 14 (SquareRoot.squareRoot 196))
  |>.addTest "root of 65025" (do
      return assertEqual 255 (SquareRoot.squareRoot 65025))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [squareRootTests]
