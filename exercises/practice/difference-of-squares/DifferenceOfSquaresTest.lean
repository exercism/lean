import LeanTest
import DifferenceOfSquares

open LeanTest

def differenceOfSquaresTests : TestSuite :=
  (TestSuite.empty "DifferenceOfSquares")
  |>.addTest "Square the sum of the numbers up to the given number - square of sum 1" (do
      return assertEqual 1 (DifferenceOfSquares.squareOfSum 1))
  |>.addTest "Square the sum of the numbers up to the given number - square of sum 5" (do
      return assertEqual 225 (DifferenceOfSquares.squareOfSum 5))
  |>.addTest "Square the sum of the numbers up to the given number - square of sum 100" (do
      return assertEqual 25502500 (DifferenceOfSquares.squareOfSum 100))
  |>.addTest "Sum the squares of the numbers up to the given number - sum of squares 1" (do
      return assertEqual 1 (DifferenceOfSquares.sumOfSquares 1))
  |>.addTest "Sum the squares of the numbers up to the given number - sum of squares 5" (do
      return assertEqual 55 (DifferenceOfSquares.sumOfSquares 5))
  |>.addTest "Sum the squares of the numbers up to the given number - sum of squares 100" (do
      return assertEqual 338350 (DifferenceOfSquares.sumOfSquares 100))
  |>.addTest "Subtract sum of squares from square of sums - difference of squares 1" (do
      return assertEqual 0 (DifferenceOfSquares.differenceOfSquares 1))
  |>.addTest "Subtract sum of squares from square of sums - difference of squares 5" (do
      return assertEqual 170 (DifferenceOfSquares.differenceOfSquares 5))
  |>.addTest "Subtract sum of squares from square of sums - difference of squares 100" (do
      return assertEqual 25164150 (DifferenceOfSquares.differenceOfSquares 100))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [differenceOfSquaresTests]
