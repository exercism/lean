import LeanTest
import TwoFer

open LeanTest

def twoFerTests : TestSuite :=
  (TestSuite.empty "TwoFer")
  |>.addTest "no name given" (do
      return assertEqual "One for you, one for me." (TwoFer.twoFer none))
  |>.addTest "a name given" (do
      return assertEqual "One for Alice, one for me." (TwoFer.twoFer (some "Alice")))
  |>.addTest "another name given" (do
      return assertEqual "One for Bob, one for me." (TwoFer.twoFer (some "Bob")))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [twoFerTests]
