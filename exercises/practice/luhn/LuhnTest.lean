import LeanTest
import Luhn

open LeanTest

def luhnTests : TestSuite :=
  (TestSuite.empty "Luhn")
  |>.addTest "single digit strings can not be valid" (do
      return assertFalse (Luhn.valid "1"))
  |>.addTest "a single zero is invalid" (do
      return assertFalse (Luhn.valid "0"))
  |>.addTest "a simple valid SIN that remains valid if reversed" (do
      return assertTrue (Luhn.valid "059"))
  |>.addTest "a simple valid SIN that becomes invalid if reversed" (do
      return assertTrue (Luhn.valid "59"))
  |>.addTest "a valid Canadian SIN" (do
      return assertTrue (Luhn.valid "055 444 285"))
  |>.addTest "invalid Canadian SIN" (do
      return assertFalse (Luhn.valid "055 444 286"))
  |>.addTest "invalid credit card" (do
      return assertFalse (Luhn.valid "8273 1232 7352 0569"))
  |>.addTest "invalid long number with an even remainder" (do
      return assertFalse (Luhn.valid "1 2345 6789 1234 5678 9012"))
  |>.addTest "invalid long number with a remainder divisible by 5" (do
      return assertFalse (Luhn.valid "1 2345 6789 1234 5678 9013"))
  |>.addTest "valid number with an even number of digits" (do
      return assertTrue (Luhn.valid "095 245 88"))
  |>.addTest "valid number with an odd number of spaces" (do
      return assertTrue (Luhn.valid "234 567 891 234"))
  |>.addTest "valid strings with a non-digit added at the end become invalid" (do
      return assertFalse (Luhn.valid "059a"))
  |>.addTest "valid strings with punctuation included become invalid" (do
      return assertFalse (Luhn.valid "055-444-285"))
  |>.addTest "valid strings with symbols included become invalid" (do
      return assertFalse (Luhn.valid "055# 444$ 285"))
  |>.addTest "single zero with space is invalid" (do
      return assertFalse (Luhn.valid " 0"))
  |>.addTest "more than a single zero is valid" (do
      return assertTrue (Luhn.valid "0000 0"))
  |>.addTest "input digit 9 is correctly converted to output digit 9" (do
      return assertTrue (Luhn.valid "091"))
  |>.addTest "very long input is valid" (do
      return assertTrue (Luhn.valid "9999999999 9999999999 9999999999 9999999999"))
  |>.addTest "valid luhn with an odd number of digits and non zero first digit" (do
      return assertTrue (Luhn.valid "109"))
  |>.addTest "using ascii value for non-doubled non-digit isn't allowed" (do
      return assertFalse (Luhn.valid "055b 444 285"))
  |>.addTest "using ascii value for doubled non-digit isn't allowed" (do
      return assertFalse (Luhn.valid ":9"))
  |>.addTest "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed" (do
      return assertFalse (Luhn.valid "59%59"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [luhnTests]
