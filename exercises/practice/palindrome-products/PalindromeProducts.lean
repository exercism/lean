namespace PalindromeProducts

structure Factors where
  a : Nat
  b : Nat
  h : a ≤ b
  deriving BEq, Repr

structure Result where
  product : Nat
  factors : List Factors
  deriving BEq, Repr

def smallest (min max : Nat) (_ : min ≤ max) : Option Result :=
  sorry

def largest (min max : Nat) (_ : min ≤ max) : Option Result :=
  sorry

end PalindromeProducts
