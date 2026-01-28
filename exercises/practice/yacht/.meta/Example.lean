namespace Yacht

inductive Category where
  | ones | twos | threes | fours | fives | sixes
  | choice | fourOfAKind | fullHouse | yacht
  | littleStraight | bigStraight
  deriving BEq, Repr

abbrev Die   := { x : Nat // 1 ≤ x ∧ x ≤ 6 }
abbrev Throw := Vector Die 5

def sortedDice : Throw -> List Nat :=
  List.mergeSort ∘ List.map (λ (d : Die) => d.val) ∘ Vector.toList -- composition is like in Haskell, right to left

def score (dice : Throw) : Category -> Nat
  | .ones           => 1 * dice.count ⟨1, by decide⟩
  | .twos           => 2 * dice.count ⟨2, by decide⟩
  | .threes         => 3 * dice.count ⟨3, by decide⟩
  | .fours          => 4 * dice.count ⟨4, by decide⟩
  | .fives          => 5 * dice.count ⟨5, by decide⟩
  | .sixes          => 6 * dice.count ⟨6, by decide⟩
  | .yacht          => if dice.all (λ x => dice[0] == x) then 50 else 0
  | .choice         => dice.foldl (λ acc ⟨d, _⟩ => acc + d) 0
  | .littleStraight => if sortedDice dice == [1, 2, 3, 4, 5] then 30 else 0
  | .bigStraight    => if sortedDice dice == [2, 3, 4, 5, 6] then 30 else 0
  | .fourOfAKind    => (do
      let ⟨d, _⟩ ← dice.find? (λ x => dice.count x >= 4)
      some (4 * d)
    ).getD 0
  | .fullHouse      => (do
      let ⟨d1, _⟩ ← dice.find? (λ x => dice.count x == 3)
      let ⟨d2, _⟩ ← dice.find? (λ x => dice.count x == 2)
      some (3 * d1 + 2 * d2)
    ).getD 0

end Yacht
