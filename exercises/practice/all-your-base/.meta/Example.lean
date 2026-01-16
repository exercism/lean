namespace AllYourBase

def ValidBase := { x : Nat // x >= 2 }

def rebase (inputBase : ValidBase) (digits : List (Fin inputBase.val)) (outputBase : ValidBase) : List (Fin outputBase.val) := Id.run do
  /-
    Nat.lt_of_lt_of_le = n < m -> m <= k -> n < k
    decide proves that 0 < 2 (0 is n and 2 is m in the theorem)
    outputBase.property = outputBase.val >= 2 (outputBase.val is k in the theorem)
    so: 0 < 2 -> 2 <= outputBase.val -> 0 < outputBase.val
  -/
  have hpos : 0 < outputBase.val :=
    Nat.lt_of_lt_of_le (by decide : 0 < 2) outputBase.property
  let mut base10 :=
    digits.reverse.mapIdx (inputBase.val ^ · * ·.val)
    |> (List.foldl (· + ·) 0 .)
  match base10 with
  | 0 => return [⟨0, hpos⟩] /- have already proved that 0 < outputBase.val, so 0 "fits" in Fin outputBase.val -/
  | _ =>
    let mut result : List (Fin outputBase.val) := []
    while base10 > 0 do
      let digit := base10 % outputBase.val
      /-
        Nat.mod_lt = x, y ∈ Nat -> 0 < y -> x % y < y
        digit = base10 % outputBase.val
        base10, outputBase.val ∈ Nat
        so, to prove that digit < outputBase.val, we can prove that 0 < outputBase.val
        which was already proved by hpos
      -/
      have hmod : digit < outputBase.val :=
        Nat.mod_lt base10 hpos
      result := ⟨digit, hmod⟩ :: result /- hmod proves that digit < outputBase.val, so digit "fits" in Fin outputBase.val -/
      base10 := base10 / outputBase.val
    return result

end AllYourBase
