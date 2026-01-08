import LeanTest
import ScrabbleScore

open LeanTest

def scrabbleScoreTests : TestSuite :=
  (TestSuite.empty "ScrabbleScore")
  |>.addTest "lowercase letter" (do
      return assertEqual 1 (ScrabbleScore.score "a"))
  |>.addTest "uppercase letter" (do
      return assertEqual 1 (ScrabbleScore.score "A"))
  |>.addTest "valuable letter" (do
      return assertEqual 4 (ScrabbleScore.score "f"))
  |>.addTest "short word" (do
      return assertEqual 2 (ScrabbleScore.score "at"))
  |>.addTest "short, valuable word" (do
      return assertEqual 12 (ScrabbleScore.score "zoo"))
  |>.addTest "medium word" (do
      return assertEqual 6 (ScrabbleScore.score "street"))
  |>.addTest "medium, valuable word" (do
      return assertEqual 22 (ScrabbleScore.score "quirky"))
  |>.addTest "long, mixed-case word" (do
      return assertEqual 41 (ScrabbleScore.score "OxyphenButazone"))
  |>.addTest "english-like word" (do
      return assertEqual 8 (ScrabbleScore.score "pinata"))
  |>.addTest "empty input" (do
      return assertEqual 0 (ScrabbleScore.score ""))
  |>.addTest "entire alphabet available" (do
      return assertEqual 87 (ScrabbleScore.score "abcdefghijklmnopqrstuvwxyz"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [scrabbleScoreTests]
