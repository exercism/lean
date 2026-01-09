import LeanTest
import SumOfMultiples

open LeanTest

def sumOfMultiplesTests : TestSuite :=
  (TestSuite.empty "SumOfMultiples")
  |>.addTest "no multiples within limit" (do
      return assertEqual 0 (SumOfMultiples.sum [3, 5] 1))
  |>.addTest "one factor has multiples within limit" (do
      return assertEqual 3 (SumOfMultiples.sum [3, 5] 4))
  |>.addTest "more than one multiple within limit" (do
      return assertEqual 9 (SumOfMultiples.sum [3] 7))
  |>.addTest "more than one factor with multiples within limit" (do
      return assertEqual 23 (SumOfMultiples.sum [3, 5] 10))
  |>.addTest "each multiple is only counted once" (do
      return assertEqual 2318 (SumOfMultiples.sum [3, 5] 100))
  |>.addTest "a much larger limit" (do
      return assertEqual 233168 (SumOfMultiples.sum [3, 5] 1000))
  |>.addTest "three factors" (do
      return assertEqual 51 (SumOfMultiples.sum [7, 13, 17] 20))
  |>.addTest "factors not relatively prime" (do
      return assertEqual 30 (SumOfMultiples.sum [4, 6] 15))
  |>.addTest "some pairs of factors relatively prime and some not" (do
      return assertEqual 4419 (SumOfMultiples.sum [5, 6, 8] 150))
  |>.addTest "one factor is a multiple of another" (do
      return assertEqual 275 (SumOfMultiples.sum [5, 25] 51))
  |>.addTest "much larger factors" (do
      return assertEqual 2203160 (SumOfMultiples.sum [43, 47] 10000))
  |>.addTest "all numbers are multiples of 1" (do
      return assertEqual 4950 (SumOfMultiples.sum [1] 100))
  |>.addTest "no factors means an empty sum" (do
      return assertEqual 0 (SumOfMultiples.sum [] 10000))
  |>.addTest "the only multiple of 0 is 0" (do
      return assertEqual 0 (SumOfMultiples.sum [0] 1))
  |>.addTest "the factor 0 does not affect the sum of multiples of other factors" (do
      return assertEqual 3 (SumOfMultiples.sum [3, 0] 4))
  |>.addTest "solutions using include-exclude must extend to cardinality greater than 3" (do
      return assertEqual 39614537 (SumOfMultiples.sum [2, 3, 5, 7, 11] 10000))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [sumOfMultiplesTests]
