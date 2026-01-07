import LeanTest
import EliudsEggs

open LeanTest

def eliudsEggsTests : TestSuite :=
  (TestSuite.empty "EliudsEggs")
  |>.addTest "0 eggs" (do
      return assertEqual 0 (EliudsEggs.eggCount 0))
  |>.addTest "1 egg" (do
      return assertEqual 1 (EliudsEggs.eggCount 16))
  |>.addTest "4 eggs" (do
      return assertEqual 4 (EliudsEggs.eggCount 89))
  |>.addTest "13 eggs" (do
      return assertEqual 13 (EliudsEggs.eggCount 2000000000))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [eliudsEggsTests]
