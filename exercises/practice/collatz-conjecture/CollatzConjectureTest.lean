import LeanTest
import CollatzConjecture

open LeanTest

def collatzConjectureTests : TestSuite :=
  (TestSuite.empty "CollatzConjecture")
  |>.addTest "zero steps for one" (do
      return assertEqual 0 (CollatzConjecture.steps ⟨1, by decide⟩))
  |>.addTest "divide if even" (do
      return assertEqual 4 (CollatzConjecture.steps ⟨16, by decide⟩))
  |>.addTest "even and odd steps" (do
      return assertEqual 9 (CollatzConjecture.steps ⟨12, by decide⟩))
  |>.addTest "large number of even and odd steps" (do
      return assertEqual 152 (CollatzConjecture.steps ⟨1000000, by decide⟩))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [collatzConjectureTests]
