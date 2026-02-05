import LeanTest
import HighScores

open LeanTest

def highScoresTests : TestSuite :=
  (TestSuite.empty "HighScores")
    |>.addTest "Latest score" (do
        return assertEqual 30 (HighScores.latestList [100, 0, 90, 30]))
    |>.addTest "Latest score" (do
        return assertEqual 30 (HighScores.latestArray #[100, 0, 90, 30]))
    |>.addTest "Personal best" (do
        return assertEqual 100 (HighScores.personalBestList [40, 100, 70]))
    |>.addTest "Personal best" (do
        return assertEqual 100 (HighScores.personalBestArray #[40, 100, 70]))
    |>.addTest "Top 3 scores -> Personal top three from a list of scores" (do
        return assertEqual [100, 90, 70] (HighScores.personalTopThreeList [10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]))
    |>.addTest "Top 3 scores -> Personal top three from a list of scores" (do
        return assertEqual #[100, 90, 70] (HighScores.personalTopThreeArray #[10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]))
    |>.addTest "Top 3 scores -> Personal top highest to lowest" (do
        return assertEqual [30, 20, 10] (HighScores.personalTopThreeList [20, 10, 30]))
    |>.addTest "Top 3 scores -> Personal top highest to lowest" (do
        return assertEqual #[30, 20, 10] (HighScores.personalTopThreeArray #[20, 10, 30]))
    |>.addTest "Top 3 scores -> Personal top when there is a tie" (do
        return assertEqual [40, 40, 30] (HighScores.personalTopThreeList [40, 20, 40, 30]))
    |>.addTest "Top 3 scores -> Personal top when there is a tie" (do
        return assertEqual #[40, 40, 30] (HighScores.personalTopThreeArray #[40, 20, 40, 30]))
    |>.addTest "Top 3 scores -> Personal top when there are less than 3" (do
        return assertEqual [70, 30] (HighScores.personalTopThreeList [30, 70]))
    |>.addTest "Top 3 scores -> Personal top when there are less than 3" (do
        return assertEqual #[70, 30] (HighScores.personalTopThreeArray #[30, 70]))
    |>.addTest "Top 3 scores -> Personal top when there is only one" (do
        return assertEqual [40] (HighScores.personalTopThreeList [40]))
    |>.addTest "Top 3 scores -> Personal top when there is only one" (do
        return assertEqual #[40] (HighScores.personalTopThreeArray #[40]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [highScoresTests]
