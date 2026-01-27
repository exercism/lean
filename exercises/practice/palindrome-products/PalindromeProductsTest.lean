import LeanTest
import PalindromeProducts

open LeanTest

def palindromeProductsTests : TestSuite :=
  (TestSuite.empty "PalindromeProducts")
    |>.addTest "find the smallest palindrome from single digit factors" (do
        return assertEqual (.valid 1 [⟨1,1⟩]) (PalindromeProducts.smallest 1 9))
    |>.addTest "find the largest palindrome from single digit factors" (do
        return assertEqual (.valid 9 [⟨1,9⟩,⟨3,3⟩]) (PalindromeProducts.largest 1 9))
    |>.addTest "find the smallest palindrome from double digit factors" (do
        return assertEqual (.valid 121 [⟨11,11⟩]) (PalindromeProducts.smallest 10 99))
    |>.addTest "find the largest palindrome from double digit factors" (do
        return assertEqual (.valid 9009 [⟨91,99⟩]) (PalindromeProducts.largest 10 99))
    |>.addTest "find the smallest palindrome from triple digit factors" (do
        return assertEqual (.valid 10201 [⟨101,101⟩]) (PalindromeProducts.smallest 100 999))
    |>.addTest "find the largest palindrome from triple digit factors" (do
        return assertEqual (.valid 906609 [⟨913,993⟩]) (PalindromeProducts.largest 100 999))
    |>.addTest "find the smallest palindrome from four digit factors" (do
        return assertEqual (.valid 1002001 [⟨1001,1001⟩]) (PalindromeProducts.smallest 1000 9999))
    |>.addTest "find the largest palindrome from four digit factors" (do
        return assertEqual (.valid 99000099 [⟨9901,9999⟩]) (PalindromeProducts.largest 1000 9999))
    |>.addTest "empty result for smallest if no palindrome in the range" (do
        return assertEqual .empty (PalindromeProducts.smallest 1002 1003))
    |>.addTest "empty result for largest if no palindrome in the range" (do
        return assertEqual .empty (PalindromeProducts.largest 15 15))
    |>.addTest "error result for smallest if min is more than max" (do
        return assertEqual .invalid (PalindromeProducts.smallest 10000 1))
    |>.addTest "error result for largest if min is more than max" (do
        return assertEqual .invalid (PalindromeProducts.largest 2 1))
    |>.addTest "smallest product does not use the smallest factor" (do
        return assertEqual (.valid 10988901 [⟨3297,3333⟩]) (PalindromeProducts.smallest 3215 4000))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [palindromeProductsTests]
