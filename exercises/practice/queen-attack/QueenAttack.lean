namespace QueenAttack

structure Queen where
  /-
    define here a type Queen that satisfies the following theorem:

    theorem check (q : QueenAttack.Queen) : q.row ≥ 0 ∧ q.row < 8 ∧ q.col ≥ 0 ∧ q.col < 8 := by
      simp [q.h]
  -/

def create? (row col : Int) : Option Queen :=
  sorry --remove this line and implement the function

def canAttack (white black : Queen) : Bool :=
  sorry --remove this line and implement the function

end QueenAttack
