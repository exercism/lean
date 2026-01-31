import LeanTest
import TwoBucket

open LeanTest

def twoBucketTests : TestSuite :=
  (TestSuite.empty "TwoBucket")
  |>.addTest "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one" (do
      return assertEqual (some ⟨4, .one, 5⟩) (TwoBucket.measure 3 5 1 .one))
  |>.addTest "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two" (do
      return assertEqual (some ⟨8, .two, 3⟩) (TwoBucket.measure 3 5 1 .two))
  |>.addTest "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one" (do
      return assertEqual (some ⟨14, .one, 11⟩) (TwoBucket.measure 7 11 2 .one))
  |>.addTest "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two" (do
      return assertEqual (some ⟨18, .two, 7⟩) (TwoBucket.measure 7 11 2 .two))
  |>.addTest "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two" (do
      return assertEqual (some ⟨1, .two, 0⟩) (TwoBucket.measure 1 3 3 .two))
  |>.addTest "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two" (do
      return assertEqual (some ⟨2, .two, 2⟩) (TwoBucket.measure 2 3 3 .one))
  |>.addTest "Measure using bucket one much bigger than bucket two" (do
      return assertEqual (some ⟨6, .one, 1⟩) (TwoBucket.measure 5 1 2 .one))
  |>.addTest "Measure using bucket one much smaller than bucket two" (do
      return assertEqual (some ⟨6, .two, 0⟩) (TwoBucket.measure 3 15 9 .one))
  |>.addTest "Not possible to reach the goal" (do
      return assertEqual none (TwoBucket.measure 6 15 5 .one))
  |>.addTest "With the same buckets but a different goal, then it is possible" (do
      return assertEqual (some ⟨10, .two, 0⟩) (TwoBucket.measure 6 15 9 .one))
  |>.addTest "Goal larger than both buckets is impossible" (do
      return assertEqual none (TwoBucket.measure 5 7 8 .one))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [twoBucketTests]
