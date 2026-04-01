namespace QueenAttack

structure Queen where
  row : Nat
  col : Nat
  h : row < 8 ∧ col < 8
  deriving BEq, Repr

def create? (row col : Int) : Option Queen := do
  if h₀: row ≥ 0 ∧ row < 8 ∧ col ≥ 0 ∧ col < 8 then
    some { row := row.toNat, col := col.toNat, h := (by omega) }
  else none

def canAttack (white black : Queen) : Bool :=
  let rowDist := Int.ofNat white.row - Int.ofNat black.row
  let colDist := Int.ofNat white.col - Int.ofNat black.col
  rowDist = 0 ∨ colDist = 0 ∨ rowDist.natAbs = colDist.natAbs

end QueenAttack
