import LeanTest
import GameNight

open LeanTest

def gameNightTests : TestSuite :=
  (TestSuite.empty "GameNight")
  |>.addTest "Confirmed and invited can join" (do
      return assertEqual true (GameNight.canJoin true true)) (taskId := some 1)
  |>.addTest "Confirmed but not invited cannot join" (do
      return assertEqual false (GameNight.canJoin true false)) (taskId := some 1)
  |>.addTest "invited but has not confirmed cannot join" (do
      return assertEqual false (GameNight.canJoin false true)) (taskId := some 1)
  |>.addTest "host brings snacks" (do
      return assertEqual true (GameNight.bringsSnacks true false)) (taskId := some 2)
  |>.addTest "volunteer brings snacks" (do
      return assertEqual true (GameNight.bringsSnacks false true)) (taskId := some 2)
  |>.addTest "neither host nor volunteer brings no snacks" (do
      return assertEqual false (GameNight.bringsSnacks false false)) (taskId := some 2)
  |>.addTest "coming is not skipping" (do
      return assertEqual false (GameNight.isSkipping true)) (taskId := some 3)
  |>.addTest "not coming is skipping" (do
      return assertEqual true (GameNight.isSkipping false)) (taskId := some 3)
  |>.addTest "both voted for the board game" (do
      return assertEqual true (GameNight.votedSame true true)) (taskId := some 4)
  |>.addTest "voted for different games" (do
      return assertEqual false (GameNight.votedSame true false)) (taskId := some 4)
  |>.addTest "both voted for the video game" (do
      return assertEqual true (GameNight.votedSame false false)) (taskId := some 4)
  |>.addTest "exactly one volunteer is the scorekeeper" (do
      return assertEqual true (GameNight.hasScorekeeper true false)) (taskId := some 5)
  |>.addTest "both volunteering means no single scorekeeper" (do
      return assertEqual false (GameNight.hasScorekeeper true true)) (taskId := some 5)
  |>.addTest "neither volunteering means no scorekeeper" (do
      return assertEqual false (GameNight.hasScorekeeper false false)) (taskId := some 5)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [gameNightTests]
