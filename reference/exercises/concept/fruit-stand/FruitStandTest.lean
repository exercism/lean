import LeanTest
import FruitStand

open LeanTest

def fruitStandTests : TestSuite :=
  (TestSuite.empty "FruitStand")
  |>.addTest "the price of one apple" (do
      return assertEqual 50 (FruitStand.applePrice )) (taskId := some 1)
  |>.addTest "revenue from selling some apples" (do
      return assertEqual 500 (FruitStand.revenue 10)) (taskId := some 2)
  |>.addTest "revenue from selling no apples" (do
      return assertEqual 0 (FruitStand.revenue 0)) (taskId := some 2)
  |>.addTest "profit after paying expenses" (do
      return assertEqual 470 (FruitStand.profit 10 30)) (taskId := some 3)
  |>.addTest "profit with no sales and no expenses" (do
      return assertEqual 0 (FruitStand.profit 0 0)) (taskId := some 3)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [fruitStandTests]
