import LeanTest
import Darts

open LeanTest

def dartsTests : TestSuite :=
  (TestSuite.empty "Darts")
  |>.addTest "Missed target" (do
      return assertEqual 0 (Darts.score (-9) 9))
  |>.addTest "On the outer circle" (do
      return assertEqual 1 (Darts.score 0 10))
  |>.addTest "On the middle circle" (do
      return assertEqual 5 (Darts.score (-5) 0))
  |>.addTest "On the inner circle" (do
      return assertEqual 10 (Darts.score 0 (-1)))
  |>.addTest "Exactly on center" (do
      return assertEqual 10 (Darts.score 0 0))
  |>.addTest "Near the center" (do
      return assertEqual 10 (Darts.score (-0.1) (-0.1)))
  |>.addTest "Just within the inner circle" (do
      return assertEqual 10 (Darts.score 0.7 0.7))
  |>.addTest "Just outside the inner circle" (do
      return assertEqual 5 (Darts.score 0.8 (-0.8)))
  |>.addTest "Just within the middle circle" (do
      return assertEqual 5 (Darts.score (-3.5) 3.5))
  |>.addTest "Just outside the middle circle" (do
      return assertEqual 1 (Darts.score (-3.6) (-3.6)))
  |>.addTest "Just within the outer circle" (do
      return assertEqual 1 (Darts.score (-7.0) 7.0))
  |>.addTest "Just outside the outer circle" (do
      return assertEqual 0 (Darts.score 7.1 (-7.1)))
  |>.addTest "Asymmetric position between the inner and middle circles" (do
      return assertEqual 5 (Darts.score 0.5 (-4)))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [dartsTests]
