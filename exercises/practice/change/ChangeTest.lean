import LeanTest
import Change

open LeanTest

def changeTests : TestSuite :=
  (TestSuite.empty "Change")
  |>.addTest "change for 1 cent" (do
      return assertEqual (.ok #[1]) (Change.findFewestCoins #[1, 5, 10, 25] 1))
  |>.addTest "single coin change" (do
      return assertEqual (.ok #[25]) (Change.findFewestCoins #[1, 5, 10, 25, 100] 25))
  |>.addTest "multiple coin change" (do
      return assertEqual (.ok #[5, 10]) (Change.findFewestCoins #[1, 5, 10, 25, 100] 15))
  |>.addTest "change with Lilliputian Coins" (do
      return assertEqual (.ok #[4, 4, 15]) (Change.findFewestCoins #[1, 4, 15, 20, 50] 23))
  |>.addTest "change with Lower Elbonia Coins" (do
      return assertEqual (.ok #[21, 21, 21]) (Change.findFewestCoins #[1, 5, 10, 21, 25] 63))
  |>.addTest "large target values" (do
      return assertEqual (.ok #[2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100]) (Change.findFewestCoins #[1, 2, 5, 10, 20, 50, 100] 999))
  |>.addTest "possible change without unit coins available" (do
      return assertEqual (.ok #[2, 2, 2, 5, 10]) (Change.findFewestCoins #[2, 5, 10, 20, 50] 21))
  |>.addTest "another possible change without unit coins available" (do
      return assertEqual (.ok #[4, 4, 4, 5, 5, 5]) (Change.findFewestCoins #[4, 5] 27))
  |>.addTest "a greedy approach is not optimal" (do
      return assertEqual (.ok #[10, 10]) (Change.findFewestCoins #[1, 10, 11] 20))
  |>.addTest "no coins make 0 change" (do
      return assertEqual (.ok #[]) (Change.findFewestCoins #[1, 5, 10, 21, 25] 0))
  |>.addTest "error testing for change smaller than the smallest of coins" (do
      return assertEqual (.error "can't make target with given coins") (Change.findFewestCoins #[5, 10] 3))
  |>.addTest "error if no combination can add up to target" (do
      return assertEqual (.error "can't make target with given coins") (Change.findFewestCoins #[5, 10] 94))
  |>.addTest "cannot find negative change values" (do
      return assertEqual (.error "target can't be negative") (Change.findFewestCoins #[1, 2, 5] (-5)))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [changeTests]
