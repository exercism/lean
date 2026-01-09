import LeanTest
import NthPrime

open LeanTest

def nthPrimeTests : TestSuite :=
  (TestSuite.empty "NthPrime")
  |>.addTest "first prime" (do
      return assertEqual (some 2) (NthPrime.prime 1))
  |>.addTest "second prime" (do
      return assertEqual (some 3) (NthPrime.prime 2))
  |>.addTest "sixth prime" (do
      return assertEqual (some 13) (NthPrime.prime 6))
  |>.addTest "big prime" (do
      return assertEqual (some 104743) (NthPrime.prime 10001))
  |>.addTest "there is no zeroth prime" (do
      return assertEqual none (NthPrime.prime 0))
  |>.addTest "very big prime" (do
      return assertEqual (some 821647) (NthPrime.prime 65537))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [nthPrimeTests]
