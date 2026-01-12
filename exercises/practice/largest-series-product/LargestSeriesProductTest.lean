import LeanTest
import LargestSeriesProduct

open LeanTest

def largestSeriesProductTests : TestSuite :=
  (TestSuite.empty "largestSeriesProduct")
  |>.addTest "finds the largest product if span equals length" (do
      return assertEqual (some 18) (LargestSeriesProduct.largestProduct 2 "29"))
  |>.addTest "can find the largest product of 2 with numbers in order" (do
      return assertEqual (some 72) (LargestSeriesProduct.largestProduct 2 "0123456789"))
  |>.addTest "can find the largest product of 2" (do
      return assertEqual (some 48) (LargestSeriesProduct.largestProduct 2 "576802143"))
  |>.addTest "can find the largest product of 3 with numbers in order" (do
      return assertEqual (some 504) (LargestSeriesProduct.largestProduct 3 "0123456789"))
  |>.addTest "can find the largest product of 3" (do
      return assertEqual (some 270) (LargestSeriesProduct.largestProduct 3 "1027839564"))
  |>.addTest "can find the largest product of 5 with numbers in order" (do
      return assertEqual (some 15120) (LargestSeriesProduct.largestProduct 5 "0123456789"))
  |>.addTest "can get the largest product of a big number" (do
      return assertEqual (some 23520) (LargestSeriesProduct.largestProduct 6 "73167176531330624919225119674426574742355349194934"))
  |>.addTest "reports zero if the only digits are zero" (do
      return assertEqual (some 0) (LargestSeriesProduct.largestProduct 2 "0000"))
  |>.addTest "reports zero if all spans include zero" (do
      return assertEqual (some 0) (LargestSeriesProduct.largestProduct 3 "99099"))
  |>.addTest "rejects span longer than string length" (do
      return assertEqual none (LargestSeriesProduct.largestProduct 4 "123"))
  |>.addTest "reports 1 for empty string and empty product (0 span)" (do
      return assertEqual (some 1) (LargestSeriesProduct.largestProduct 0 ""))
  |>.addTest "reports 1 for nonempty string and empty product (0 span)" (do
      return assertEqual (some 1) (LargestSeriesProduct.largestProduct 0 "123"))
  |>.addTest "rejects empty string and nonzero span" (do
      return assertEqual none (LargestSeriesProduct.largestProduct 1 ""))
  |>.addTest "rejects invalid character in digits" (do
      return assertEqual none (LargestSeriesProduct.largestProduct 2 "1234a5"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [largestSeriesProductTests]
