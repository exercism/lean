import LeanTest
import Series

open LeanTest

def seriesTests : TestSuite :=
  (TestSuite.empty "Series")
      |>.addTest "slices of one from one" (do
          return assertEqual (some #["1"]) (Series.slices "1" 1))
      |>.addTest "slices of one from two" (do
          return assertEqual (some #["1", "2"]) (Series.slices "12" 1))
      |>.addTest "slices of two" (do
          return assertEqual (some #["35"]) (Series.slices "35" 2))
      |>.addTest "slices of two overlap" (do
          return assertEqual (some #["91", "14", "42"]) (Series.slices "9142" 2))
      |>.addTest "slices can include duplicates" (do
          return assertEqual (some #["777", "777", "777", "777"]) (Series.slices "777777" 3))
      |>.addTest "slices of a long series" (do
          return assertEqual (some #["91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243"]) (Series.slices "918493904243" 5))
      |>.addTest "slice length is too large" (do
          return assertEqual none (Series.slices "12345" 6))
      |>.addTest "slice length is way too large" (do
          return assertEqual none (Series.slices "12345" 42))
      |>.addTest "slice length cannot be zero" (do
          return assertEqual none (Series.slices "12345" 0))
      |>.addTest "empty series is invalid" (do
          return assertEqual none (Series.slices "" 1))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [seriesTests]
