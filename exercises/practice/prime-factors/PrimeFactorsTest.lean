import LeanTest
import PrimeFactors

open LeanTest

def primeFactorsTests : TestSuite :=
  (TestSuite.empty "PrimeFactors")
  |>.addTest "no factors" (do
      return assertEqual [] (PrimeFactors.factors 1))
  |>.addTest "prime number" (do
      return assertEqual [2] (PrimeFactors.factors 2))
  |>.addTest "another prime number" (do
      return assertEqual [3] (PrimeFactors.factors 3))
  |>.addTest "square of a prime" (do
      return assertEqual [3, 3] (PrimeFactors.factors 9))
  |>.addTest "product of first prime" (do
      return assertEqual [2, 2] (PrimeFactors.factors 4))
  |>.addTest "cube of a prime" (do
      return assertEqual [2, 2, 2] (PrimeFactors.factors 8))
  |>.addTest "product of second prime" (do
      return assertEqual [3, 3, 3] (PrimeFactors.factors 27))
  |>.addTest "product of third prime" (do
      return assertEqual [5, 5, 5, 5] (PrimeFactors.factors 625))
  |>.addTest "product of first and second prime" (do
      return assertEqual [2, 3] (PrimeFactors.factors 6))
  |>.addTest "product of primes and non-primes" (do
      return assertEqual [2, 2, 3] (PrimeFactors.factors 12))
  |>.addTest "product of primes" (do
      return assertEqual [5, 17, 23, 461] (PrimeFactors.factors 901255))
  |>.addTest "factors include a large prime" (do
      return assertEqual [11, 9539, 894119] (PrimeFactors.factors 93819012551))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [primeFactorsTests]
