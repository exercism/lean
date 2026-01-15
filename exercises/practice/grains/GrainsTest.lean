import LeanTest
import Grains

open LeanTest

def grainsTests : TestSuite :=
  (TestSuite.empty "Grains")
          |>.addTest "returns the number of grains on the square -> grains on square 1" (do
              return assertEqual (some 1) (Grains.grains 1))
          |>.addTest "returns the number of grains on the square -> grains on square 2" (do
              return assertEqual (some 2) (Grains.grains 2))
          |>.addTest "returns the number of grains on the square -> grains on square 3" (do
              return assertEqual (some 4) (Grains.grains 3))
          |>.addTest "returns the number of grains on the square -> grains on square 4" (do
              return assertEqual (some 8) (Grains.grains 4))
          |>.addTest "returns the number of grains on the square -> grains on square 16" (do
              return assertEqual (some 32768) (Grains.grains 16))
          |>.addTest "returns the number of grains on the square -> grains on square 32" (do
              return assertEqual (some 2147483648) (Grains.grains 32))
          |>.addTest "returns the number of grains on the square -> grains on square 64" (do
              return assertEqual (some 9223372036854775808) (Grains.grains 64))
          |>.addTest "returns the number of grains on the square -> square 0 is invalid" (do
              return assertEqual none (Grains.grains 0))
          |>.addTest "returns the number of grains on the square -> negative square is invalid" (do
              return assertEqual none (Grains.grains (-1)))
          |>.addTest "returns the number of grains on the square -> square greater than 64 is invalid" (do
              return assertEqual none (Grains.grains 65))
      |>.addTest "returns the total number of grains on the board" (do
          return assertEqual 18446744073709551615 Grains.totalGrains)

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [grainsTests]
