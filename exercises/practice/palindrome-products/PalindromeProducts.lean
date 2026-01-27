namespace PalindromeProducts

structure Factors where
  a : Nat
  b : Nat
  deriving BEq, Repr

inductive Result where
  | invalid : Result
  | empty   : Result
  | valid   : Nat -> List Factors -> Result
  deriving BEq, Repr

def smallest (min : Nat) (max : Nat) : Result :=
  sorry

def largest (min : Nat) (max : Nat) : Result :=
  sorry

end PalindromeProducts
