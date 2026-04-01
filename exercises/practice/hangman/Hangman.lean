namespace Hangman

inductive State where
  | ongoing | win | lose
  deriving BEq, Repr

structure Result where
  state : State
  remainingFailures : Nat
  maskedWord : String
  deriving BEq, Repr

def guess (word : String) (guesses : List Char) : Except String Result :=
  sorry --remove this line and implement the function

end Hangman
