namespace Yacht

inductive Category where
  | ones | twos | threes | fours | fives | sixes
  | choice | fourOfAKind | fullHouse | yacht
  | littleStraight | bigStraight
  deriving BEq, Repr

abbrev Die   := { x : Nat // 1 ≤ x ∧ x ≤ 6 }
abbrev Throw := Vector Die 5

def score (dice : Throw) (category: Category) : Nat :=
  sorry

end Yacht
