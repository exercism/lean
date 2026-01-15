import LeanTest
import PythagoreanTriplet

open LeanTest

def pythagoreanTripletTests : TestSuite :=
  (TestSuite.empty "PythagoreanTriplet")
  |>.addTest "triplets whose sum is 12" (do
      return assertEqual [[3, 4, 5]] (PythagoreanTriplet.tripletsWithSum 12))
  |>.addTest "triplets whose sum is 108" (do
      return assertEqual [[27, 36, 45]] (PythagoreanTriplet.tripletsWithSum 108))
  |>.addTest "triplets whose sum is 1000" (do
      return assertEqual [[200, 375, 425]] (PythagoreanTriplet.tripletsWithSum 1000))
  |>.addTest "no matching triplets for 1001" (do
      return assertEqual [] (PythagoreanTriplet.tripletsWithSum 1001))
  |>.addTest "returns all matching triplets" (do
      return assertEqual [[9, 40, 41], [15, 36, 39]] (PythagoreanTriplet.tripletsWithSum 90))
  |>.addTest "several matching triplets" (do
      return assertEqual [[40, 399, 401], [56, 390, 394], [105, 360, 375], [120, 350, 370], [140, 336, 364], [168, 315, 357], [210, 280, 350], [240, 252, 348]] (PythagoreanTriplet.tripletsWithSum 840))
  |>.addTest "triplets for large number" (do
      return assertEqual [[1200, 14375, 14425], [1875, 14000, 14125], [5000, 12000, 13000], [6000, 11250, 12750], [7500, 10000, 12500]] (PythagoreanTriplet.tripletsWithSum 30000))
  |>.addTest "triplets for very large number" (do
      return assertEqual [[68145, 71672, 98897]] (PythagoreanTriplet.tripletsWithSum 238714))

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [pythagoreanTripletTests]
