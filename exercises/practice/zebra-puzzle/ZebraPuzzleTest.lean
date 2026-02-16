import LeanTest
import ZebraPuzzle

open LeanTest

def zebraPuzzleTests : TestSuite :=
  (TestSuite.empty "ZebraPuzzle")
  |>.addTest "resident who drinks water" (do
      return assertEqual .Norwegian (ZebraPuzzle.drinksWater ))
  |>.addTest "resident who owns zebra" (do
      return assertEqual .Japanese (ZebraPuzzle.ownsZebra ))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [zebraPuzzleTests]
