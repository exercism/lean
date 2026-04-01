namespace QueenAttack

structure Queen where
  row : Nat
  col : Nat
  h : row < 8 ∧ col < 8
  deriving BEq, Repr

def create? (row col : Int) : Option Queen :=
  sorry

def canAttack (white black : Queen) : Bool :=
  sorry

end QueenAttack
