import LeanTest
import Pangram

open LeanTest

def pangramTests : TestSuite :=
  (TestSuite.empty "Pangram")
  |>.addTest "empty sentence" (do
      return assertFalse (Pangram.isPangram ""))
  |>.addTest "perfect lower case" (do
      return assertTrue (Pangram.isPangram "abcdefghijklmnopqrstuvwxyz"))
  |>.addTest "only lower case" (do
      return assertTrue (Pangram.isPangram "the quick brown fox jumps over the lazy dog"))
  |>.addTest "missing the letter 'x'" (do
      return assertFalse (Pangram.isPangram "a quick movement of the enemy will jeopardize five gunboats"))
  |>.addTest "missing the letter 'h'" (do
      return assertFalse (Pangram.isPangram "five boxing wizards jump quickly at it"))
  |>.addTest "with underscores" (do
      return assertTrue (Pangram.isPangram "the_quick_brown_fox_jumps_over_the_lazy_dog"))
  |>.addTest "with numbers" (do
      return assertTrue (Pangram.isPangram "the 1 quick brown fox jumps over the 2 lazy dogs"))
  |>.addTest "missing letters replaced by numbers" (do
      return assertFalse (Pangram.isPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"))
  |>.addTest "mixed case and punctuation" (do
      return assertTrue (Pangram.isPangram "\"Five quacking Zephyrs jolt my wax bed.\""))
  |>.addTest "a-m and A-M are 26 different characters but not a pangram" (do
      return assertFalse (Pangram.isPangram "abcdefghijklm ABCDEFGHIJKLM"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [pangramTests]
