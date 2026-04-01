import LeanTest
import Hangman

open LeanTest

instance {α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false

def hangmanTests : TestSuite :=
  (TestSuite.empty "Hangman")
    |>.addTest "Initially 9 failures are allowed and no letters are guessed" (do
        return assertEqual (.ok {
            state := .ongoing,
            remainingFailures := 9,
            maskedWord := "____"
          })
          (Hangman.guess "loot" []))
    |>.addTest "After 10 failures the game is over" (do
        return assertEqual (.ok {
            state := .lose,
            remainingFailures := 0,
            maskedWord := "____"
          })
          (Hangman.guess "loot" ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']))
    |>.addTest "Losing with several correct guesses" (do
        return assertEqual (.ok {
            state := .lose,
            remainingFailures := 0,
            maskedWord := "_oot"
          })
          (Hangman.guess "loot" ['t', 'o', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']))
    |>.addTest "Feeding a correct letter removes underscores" (do
        return assertEqual (.ok {
            state := .ongoing,
            remainingFailures := 9,
            maskedWord := "___t"
          })
          (Hangman.guess "loot" ['t']))
    |>.addTest "Feeding a correct letter twice counts as a failure" (do
        return assertEqual (.ok {
            state := .ongoing,
            remainingFailures := 8,
            maskedWord := "___t"
          })
          (Hangman.guess "loot" ['t', 't']))
    |>.addTest "Guessing a repeated letter reveals all instances" (do
        return assertEqual (.ok {
            state := .ongoing,
            remainingFailures := 8,
            maskedWord := "_oot"
          })
          (Hangman.guess "loot" ['t', 't', 'o']))
    |>.addTest "Getting all the letters right makes for a win" (do
        return assertEqual (.ok {
            state := .win,
            remainingFailures := 8,
            maskedWord := "loot"
          })
          (Hangman.guess "loot" ['t', 't', 'o', 'l']))
    |>.addTest "Winning on the last guess is still a win" (do
        return assertEqual (.ok {
            state := .win,
            remainingFailures := 0,
            maskedWord := "loot"
          })
          (Hangman.guess "loot" ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 't', 'o', 'l']))
    |>.addTest "Guessing after a lose is error" (do
        return assertEqual
          (.error "cannot guess after the game is lost")
          (Hangman.guess "loot" ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k']))
    |>.addTest "Guessing after a win is error" (do
        return assertEqual
          (.error "cannot guess after the game is won")
          (Hangman.guess "loot" ['t', 'o', 'l', 'l']))
    |>.addTest "Big word, ongoing after many guesses" (do
        return assertEqual (.ok {
            state := .ongoing,
            remainingFailures := 3,
            maskedWord := "au__en_ic"
          })
          (Hangman.guess "authentic" ['a', 'e', 'p', 'm', 'i', 'l', 'c', 'n', 'o', 'r', 'q', 'u']))
    |>.addTest "Big word, win after few guesses" (do
        return assertEqual (.ok {
            state := .win,
            remainingFailures := 8,
            maskedWord := "intelligence"
          })
          (Hangman.guess "intelligence" ['a', 'e', 'i', 'l', 'n', 't', 'g', 'c']))
    |>.addTest "Small word, win after few guesses" (do
        return assertEqual (.ok {
            state := .win,
            remainingFailures := 7,
            maskedWord := "car"
          })
          (Hangman.guess "car" ['a', 'm', 'c', 'p', 'r']))
    |>.addTest "Small word, still lose with a gotcha" (do
        return assertEqual (.ok {
            state := .lose,
            remainingFailures := 0,
            maskedWord := "d_e"
          })
          (Hangman.guess "dye" ['a', 'r', 'm', 'p', 'c', 'o', 'q', 'n', 'u', 'e', 'd', 'i']))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [hangmanTests]
