import Std.Data

namespace Hangman

inductive State where
  | ongoing | win | lose
  deriving BEq, Repr

structure Result where
  state : State
  remainingFailures : Nat
  maskedWord : String
  deriving BEq, Repr

private abbrev LetterSet := Std.HashSet Char

private structure Game where
  word : String
  state : State
  remainingFailures : Nat
  foundLetters : LetterSet

private def Game.toResult : Game → Result
  | { word, state, remainingFailures, foundLetters} =>
    let maskedWord := word.map (fun x => if x ∈ foundLetters then x else '_')
    { state, remainingFailures, maskedWord }

private def step (charSet : LetterSet): Game → Char → Except String Game
  | { state := .win, .. }, _ => .error "cannot guess after the game is won"
  | { state := .lose, .. }, _ => .error "cannot guess after the game is lost"
  | game, guess =>
    if guess ∈ charSet ∧ guess ∉ game.foundLetters then
      let foundLetters' := game.foundLetters.insert guess
      let state' := if foundLetters'.size = charSet.size then State.win else game.state
      .ok { game with state := state', foundLetters := foundLetters' }
    else if game.remainingFailures = 0 then
      .ok { game with state := .lose }
    else
      let remainingFailures' := game.remainingFailures - 1
      .ok { game with remainingFailures := remainingFailures' }

private def maxFailures := 9

def guess (word : String) (guesses : List Char) : Except String Result :=
  let charSet : LetterSet := word.toList |> .ofList
  let init : Game := {
    word := word,
    state := .ongoing,
    remainingFailures := maxFailures,
    foundLetters := {}
  }
  guesses.foldlM (step charSet) init
  |>.map Game.toResult

end Hangman
