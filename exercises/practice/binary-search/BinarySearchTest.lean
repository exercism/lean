import LeanTest
import BinarySearch

open LeanTest

def binarySearchTests : TestSuite :=
(TestSuite.empty "BinarySearch")
    |>.addTest "finds a value in an array with one element" (do
        return assertEqual (some 0) (BinarySearch.find 6 #[6]))
    |>.addTest "finds a value in the middle of an array" (do
        return assertEqual (some 3) (BinarySearch.find 6 #[1, 3, 4, 6, 8, 9, 11]))
    |>.addTest "finds a value at the beginning of an array" (do
        return assertEqual (some 0) (BinarySearch.find 1 #[1, 3, 4, 6, 8, 9, 11]))
    |>.addTest "finds a value at the end of an array" (do
        return assertEqual (some 6) (BinarySearch.find 11 #[1, 3, 4, 6, 8, 9, 11]))
    |>.addTest "finds a value in an array of odd length" (do
        return assertEqual (some 9) (BinarySearch.find 144 #[1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634]))
    |>.addTest "finds a value in an array of even length" (do
        return assertEqual (some 5) (BinarySearch.find 21 #[1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]))
    |>.addTest "identifies that a value is not included in the array" (do
        return assertEqual none (BinarySearch.find 7 #[1, 3, 4, 6, 8, 9, 11]))
    |>.addTest "a value smaller than the array's smallest value is not found" (do
        return assertEqual none (BinarySearch.find 0 #[1, 3, 4, 6, 8, 9, 11]))
    |>.addTest "a value larger than the array's largest value is not found" (do
        return assertEqual none (BinarySearch.find 13 #[1, 3, 4, 6, 8, 9, 11]))
    |>.addTest "nothing is found in an empty array" (do
        return assertEqual none (BinarySearch.find 1 #[]))
    |>.addTest "nothing is found when the left and right bounds cross" (do
        return assertEqual none (BinarySearch.find 0 #[1, 2]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [binarySearchTests]
