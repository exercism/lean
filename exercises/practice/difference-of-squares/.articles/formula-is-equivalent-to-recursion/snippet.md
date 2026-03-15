@[csimp]
theorem sumFirstNPositive_eq_sumFirstNPositive' : sumFirstNPositive = sumFirstNPositive' := by
    funext n
    induction n with
    | zero => rfl
    | succ x h =>
      simp [sumFirstNPositive, sumFirstNPositive', h]
      grind
