import LeanTest
import MountainHike

open LeanTest

def mountainHikeTests : TestSuite :=
  (TestSuite.empty "MountainHike")
  |>.addTest "two hours and thirty minutes" (do
      return assertEqual 150 (MountainHike.totalMinutes 2 30)) (taskId := some 1)
  |>.addTest "zero hours and forty-five minutes" (do
      return assertEqual 45 (MountainHike.totalMinutes 0 45)) (taskId := some 1)
  |>.addTest "one hundred fifty minutes is two full hours" (do
      return assertEqual 2 (MountainHike.fullHours 150)) (taskId := some 2)
  |>.addTest "one hundred fifty minutes leaves thirty minutes over" (do
      return assertEqual 30 (MountainHike.remainingMinutes 150)) (taskId := some 2)
  |>.addTest "forty-five minutes is zero full hours" (do
      return assertEqual 0 (MountainHike.fullHours 45)) (taskId := some 2)
  |>.addTest "forty-five minutes leaves forty-five minutes over" (do
      return assertEqual 45 (MountainHike.remainingMinutes 45)) (taskId := some 2)
  |>.addTest "some water left in the canteen" (do
      return assertEqual 1500 (MountainHike.waterLeft 2000 500)) (taskId := some 3)
  |>.addTest "using more water than the canteen holds" (do
      return assertEqual 0 (MountainHike.waterLeft 2000 5000)) (taskId := some 3)
  |>.addTest "hiking uphill" (do
      return assertEqual 250 (MountainHike.elevationChange 1200 1450)) (taskId := some 4)
  |>.addTest "hiking downhill" (do
      return assertEqual (-250) (MountainHike.elevationChange 1200 950)) (taskId := some 4)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [mountainHikeTests]
