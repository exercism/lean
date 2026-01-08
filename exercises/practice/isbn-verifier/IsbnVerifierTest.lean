import LeanTest
import IsbnVerifier

open LeanTest

def isbnVerifierTests : TestSuite :=
  (TestSuite.empty "IsbnVerifier")
  |>.addTest "valid isbn" (do
      return assertTrue (IsbnVerifier.isValid "3-598-21508-8"))
  |>.addTest "invalid isbn check digit" (do
      return assertFalse (IsbnVerifier.isValid "3-598-21508-9"))
  |>.addTest "valid isbn with a check digit of 10" (do
      return assertTrue (IsbnVerifier.isValid "3-598-21507-X"))
  |>.addTest "check digit is a character other than X" (do
      return assertFalse (IsbnVerifier.isValid "3-598-21507-A"))
  |>.addTest "invalid check digit in isbn is not treated as zero" (do
      return assertFalse (IsbnVerifier.isValid "4-598-21507-B"))
  |>.addTest "invalid character in isbn is not treated as zero" (do
      return assertFalse (IsbnVerifier.isValid "3-598-P1581-X"))
  |>.addTest "X is only valid as a check digit" (do
      return assertFalse (IsbnVerifier.isValid "3-598-2X507-9"))
  |>.addTest "only one check digit is allowed" (do
      return assertFalse (IsbnVerifier.isValid "3-598-21508-96"))
  |>.addTest "X is not substituted by the value 10" (do
      return assertFalse (IsbnVerifier.isValid "3-598-2X507-5"))
  |>.addTest "valid isbn without separating dashes" (do
      return assertTrue (IsbnVerifier.isValid "3598215088"))
  |>.addTest "isbn without separating dashes and X as check digit" (do
      return assertTrue (IsbnVerifier.isValid "359821507X"))
  |>.addTest "isbn without check digit and dashes" (do
      return assertFalse (IsbnVerifier.isValid "359821507"))
  |>.addTest "too long isbn and no dashes" (do
      return assertFalse (IsbnVerifier.isValid "3598215078X"))
  |>.addTest "too short isbn" (do
      return assertFalse (IsbnVerifier.isValid "00"))
  |>.addTest "isbn without check digit" (do
      return assertFalse (IsbnVerifier.isValid "3-598-21507"))
  |>.addTest "check digit of X should not be used for 0" (do
      return assertFalse (IsbnVerifier.isValid "3-598-21515-X"))
  |>.addTest "empty isbn" (do
      return assertFalse (IsbnVerifier.isValid ""))
  |>.addTest "input is 9 characters" (do
      return assertFalse (IsbnVerifier.isValid "134456729"))
  |>.addTest "invalid characters are not ignored after checking length" (do
      return assertFalse (IsbnVerifier.isValid "3132P34035"))
  |>.addTest "invalid characters are not ignored before checking length" (do
      return assertFalse (IsbnVerifier.isValid "3598P215088"))
  |>.addTest "input is too long but contains a valid isbn" (do
      return assertFalse (IsbnVerifier.isValid "98245726788"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [isbnVerifierTests]
