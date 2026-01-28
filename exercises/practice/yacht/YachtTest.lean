import LeanTest
import Yacht

open LeanTest

def yachtTests : TestSuite :=
  (TestSuite.empty "Yacht")
  |>.addTest "Yacht" (do
      return assertEqual 50 (Yacht.score ⟨#[⟨5, by decide⟩, ⟨5, by decide⟩, ⟨5, by decide⟩, ⟨5, by decide⟩, ⟨5, by decide⟩], by decide⟩ .yacht))
  |>.addTest "Not Yacht" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨2, by decide⟩, ⟨5, by decide⟩], by decide⟩ .yacht))
  |>.addTest "Ones" (do
      return assertEqual 3 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨1, by decide⟩, ⟨1, by decide⟩, ⟨3, by decide⟩, ⟨5, by decide⟩], by decide⟩ .ones))
  |>.addTest "Ones, out of order" (do
      return assertEqual 3 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨1, by decide⟩, ⟨1, by decide⟩, ⟨5, by decide⟩, ⟨1, by decide⟩], by decide⟩ .ones))
  |>.addTest "No ones" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨4, by decide⟩, ⟨3, by decide⟩, ⟨6, by decide⟩, ⟨5, by decide⟩, ⟨5, by decide⟩], by decide⟩ .ones))
  |>.addTest "Twos" (do
      return assertEqual 2 (Yacht.score ⟨#[⟨2, by decide⟩, ⟨3, by decide⟩, ⟨4, by decide⟩, ⟨5, by decide⟩, ⟨6, by decide⟩], by decide⟩ .twos))
  |>.addTest "Fours" (do
      return assertEqual 8 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨4, by decide⟩, ⟨1, by decide⟩, ⟨4, by decide⟩, ⟨1, by decide⟩], by decide⟩ .fours))
  |>.addTest "Yacht counted as threes" (do
      return assertEqual 15 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩], by decide⟩ .threes))
  |>.addTest "Yacht of 3s counted as fives" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩], by decide⟩ .fives))
  |>.addTest "Fives" (do
      return assertEqual 10 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨5, by decide⟩, ⟨3, by decide⟩, ⟨5, by decide⟩, ⟨3, by decide⟩], by decide⟩ .fives))
  |>.addTest "Sixes" (do
      return assertEqual 6 (Yacht.score ⟨#[⟨2, by decide⟩, ⟨3, by decide⟩, ⟨4, by decide⟩, ⟨5, by decide⟩, ⟨6, by decide⟩], by decide⟩ .sixes))
  |>.addTest "Full house two small, three big" (do
      return assertEqual 16 (Yacht.score ⟨#[⟨2, by decide⟩, ⟨2, by decide⟩, ⟨4, by decide⟩, ⟨4, by decide⟩, ⟨4, by decide⟩], by decide⟩ .fullHouse))
  |>.addTest "Full house three small, two big" (do
      return assertEqual 19 (Yacht.score ⟨#[⟨5, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨5, by decide⟩, ⟨3, by decide⟩], by decide⟩ .fullHouse))
  |>.addTest "Two pair is not a full house" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨2, by decide⟩, ⟨2, by decide⟩, ⟨4, by decide⟩, ⟨4, by decide⟩, ⟨5, by decide⟩], by decide⟩ .fullHouse))
  |>.addTest "Four of a kind is not a full house" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨4, by decide⟩, ⟨4, by decide⟩, ⟨4, by decide⟩, ⟨4, by decide⟩], by decide⟩ .fullHouse))
  |>.addTest "Yacht is not a full house" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨2, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩], by decide⟩ .fullHouse))
  |>.addTest "Four of a Kind" (do
      return assertEqual 24 (Yacht.score ⟨#[⟨6, by decide⟩, ⟨6, by decide⟩, ⟨4, by decide⟩, ⟨6, by decide⟩, ⟨6, by decide⟩], by decide⟩ .fourOfAKind))
  |>.addTest "Yacht can be scored as Four of a Kind" (do
      return assertEqual 12 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩], by decide⟩ .fourOfAKind))
  |>.addTest "Full house is not Four of a Kind" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨3, by decide⟩, ⟨3, by decide⟩, ⟨5, by decide⟩, ⟨5, by decide⟩], by decide⟩ .fourOfAKind))
  |>.addTest "Little Straight" (do
      return assertEqual 30 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨5, by decide⟩, ⟨4, by decide⟩, ⟨1, by decide⟩, ⟨2, by decide⟩], by decide⟩ .littleStraight))
  |>.addTest "Little Straight as Big Straight" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨2, by decide⟩, ⟨3, by decide⟩, ⟨4, by decide⟩, ⟨5, by decide⟩], by decide⟩ .bigStraight))
  |>.addTest "Four in order but not a little straight" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨1, by decide⟩, ⟨2, by decide⟩, ⟨3, by decide⟩, ⟨4, by decide⟩], by decide⟩ .littleStraight))
  |>.addTest "No pairs but not a little straight" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨2, by decide⟩, ⟨3, by decide⟩, ⟨4, by decide⟩, ⟨6, by decide⟩], by decide⟩ .littleStraight))
  |>.addTest "Minimum is 1, maximum is 5, but not a little straight" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨1, by decide⟩, ⟨1, by decide⟩, ⟨3, by decide⟩, ⟨4, by decide⟩, ⟨5, by decide⟩], by decide⟩ .littleStraight))
  |>.addTest "Big Straight" (do
      return assertEqual 30 (Yacht.score ⟨#[⟨4, by decide⟩, ⟨6, by decide⟩, ⟨2, by decide⟩, ⟨5, by decide⟩, ⟨3, by decide⟩], by decide⟩ .bigStraight))
  |>.addTest "Big Straight as little straight" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨6, by decide⟩, ⟨5, by decide⟩, ⟨4, by decide⟩, ⟨3, by decide⟩, ⟨2, by decide⟩], by decide⟩ .littleStraight))
  |>.addTest "No pairs but not a big straight" (do
      return assertEqual 0 (Yacht.score ⟨#[⟨6, by decide⟩, ⟨5, by decide⟩, ⟨4, by decide⟩, ⟨3, by decide⟩, ⟨1, by decide⟩], by decide⟩ .bigStraight))
  |>.addTest "Choice" (do
      return assertEqual 23 (Yacht.score ⟨#[⟨3, by decide⟩, ⟨3, by decide⟩, ⟨5, by decide⟩, ⟨6, by decide⟩, ⟨6, by decide⟩], by decide⟩ .choice))
  |>.addTest "Yacht as choice" (do
      return assertEqual 10 (Yacht.score ⟨#[⟨2, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩], by decide⟩ .choice))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [yachtTests]
