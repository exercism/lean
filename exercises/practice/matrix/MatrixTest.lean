import LeanTest
import Matrix

open LeanTest

def matrixTests : TestSuite :=
  (TestSuite.empty "Matrix")
  |>.addTest "extract row from one number matrix" (do
      return assertEqual [1] (Matrix.row "1" 1))
  |>.addTest "can extract row" (do
      return assertEqual [3, 4] (Matrix.row "1 2\n3 4" 2))
  |>.addTest "extract row where numbers have different widths" (do
      return assertEqual [10, 20] (Matrix.row "1 2\n10 20" 2))
  |>.addTest "can extract row from non-square matrix with no corresponding column" (do
      return assertEqual [8, 7, 6] (Matrix.row "1 2 3\n4 5 6\n7 8 9\n8 7 6" 4))
  |>.addTest "extract column from one number matrix" (do
      return assertEqual [1] (Matrix.column "1" 1))
  |>.addTest "can extract column" (do
      return assertEqual [3, 6, 9] (Matrix.column "1 2 3\n4 5 6\n7 8 9" 3))
  |>.addTest "can extract column from non-square matrix with no corresponding row" (do
      return assertEqual [4, 8, 6] (Matrix.column "1 2 3 4\n5 6 7 8\n9 8 7 6" 4))
  |>.addTest "extract column where numbers have different widths" (do
      return assertEqual [1903, 3, 4] (Matrix.column "89 1903 3\n18 3 1\n9 4 800" 2))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [matrixTests]
