import LeanTest
import PalindromeProducts

open LeanTest

def palindromeProductsTests : TestSuite :=
  (TestSuite.empty "PalindromeProducts")
    |>.addTest "find the smallest palindrome from single digit factors" (do
        return assertEqual (some ⟨1, [⟨1, 1, by decide⟩]⟩) (PalindromeProducts.smallest 1 9 (by decide)))
    |>.addTest "find the largest palindrome from single digit factors" (do
        return assertEqual (some ⟨9, [⟨1, 9, by decide⟩, ⟨3, 3, by decide⟩]⟩) (PalindromeProducts.largest 1 9 (by decide)))
    |>.addTest "find the smallest palindrome from double digit factors" (do
        return assertEqual (some ⟨121, [⟨11, 11, by decide⟩]⟩) (PalindromeProducts.smallest 10 99 (by decide)))
    |>.addTest "find the largest palindrome from double digit factors" (do
        return assertEqual (some ⟨9009, [⟨91, 99, by decide⟩]⟩) (PalindromeProducts.largest 10 99 (by decide)))
    |>.addTest "find the smallest palindrome from triple digit factors" (do
        return assertEqual (some ⟨10201, [⟨101, 101, by decide⟩]⟩) (PalindromeProducts.smallest 100 999 (by decide)))
    |>.addTest "find the largest palindrome from triple digit factors" (do
        return assertEqual (some ⟨906609, [⟨913, 993, by decide⟩]⟩) (PalindromeProducts.largest 100 999 (by decide)))
    |>.addTest "find the smallest palindrome from four digit factors" (do
        return assertEqual (some ⟨1002001, [⟨1001, 1001, by decide⟩]⟩) (PalindromeProducts.smallest 1000 9999 (by decide)))
    |>.addTest "find the largest palindrome from four digit factors" (do
        return assertEqual (some ⟨99000099, [⟨9901, 9999, by decide⟩]⟩) (PalindromeProducts.largest 1000 9999 (by decide)))
    |>.addTest "empty result for smallest if no palindrome in the range" (do
        return assertEqual none (PalindromeProducts.smallest 1002 1003 (by decide)))
    |>.addTest "empty result for largest if no palindrome in the range" (do
        return assertEqual none (PalindromeProducts.largest 15 15 (by decide)))
    |>.addTest "smallest product does not use the smallest factor" (do
        return assertEqual (some ⟨10988901, [⟨3297, 3333, by decide⟩]⟩) (PalindromeProducts.smallest 3215 4000 (by decide)))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [palindromeProductsTests]
