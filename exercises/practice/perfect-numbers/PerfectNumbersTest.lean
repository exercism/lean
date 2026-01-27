import LeanTest
import PerfectNumbers

open LeanTest

def perfectNumbersTests : TestSuite :=
  (TestSuite.empty "PerfectNumbers")
  |>.addTest "Perfect numbers -> Smallest perfect number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.perfect (PerfectNumbers.classify ⟨6, (by decide)⟩))
  |>.addTest "Perfect numbers -> Medium perfect number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.perfect (PerfectNumbers.classify ⟨28, (by decide)⟩))
  |>.addTest "Perfect numbers -> Large perfect number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.perfect (PerfectNumbers.classify ⟨33550336, (by decide)⟩))
  |>.addTest "Abundant numbers -> Smallest abundant number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.abundant (PerfectNumbers.classify ⟨12, (by decide)⟩))
  |>.addTest "Abundant numbers -> Medium abundant number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.abundant (PerfectNumbers.classify ⟨30, (by decide)⟩))
  |>.addTest "Abundant numbers -> Large abundant number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.abundant (PerfectNumbers.classify ⟨33550335, (by decide)⟩))
  |>.addTest "Abundant numbers -> Perfect square abundant number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.abundant (PerfectNumbers.classify ⟨196, (by decide)⟩))
  |>.addTest "Deficient numbers -> Smallest prime deficient number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.deficient (PerfectNumbers.classify ⟨2, (by decide)⟩))
  |>.addTest "Deficient numbers -> Smallest non-prime deficient number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.deficient (PerfectNumbers.classify ⟨4, (by decide)⟩))
  |>.addTest "Deficient numbers -> Medium deficient number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.deficient (PerfectNumbers.classify ⟨32, (by decide)⟩))
  |>.addTest "Deficient numbers -> Large deficient number is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.deficient (PerfectNumbers.classify ⟨33550337, (by decide)⟩))
  |>.addTest "Deficient numbers -> Edge case (no factors other than itself) is classified correctly" (do
      return assertEqual PerfectNumbers.Classification.deficient (PerfectNumbers.classify ⟨1, (by decide)⟩))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [perfectNumbersTests]
