namespace CollatzConjecture

def Positive := { x : Nat // 0 < x }

partial def steps : Positive -> Nat
  | ⟨1, _⟩ => 0
  | ⟨val + 2, _⟩ =>
    if val % 2 == 0 then
      let half := val / 2
      1 + steps ⟨half + 1, Nat.zero_lt_succ half⟩
    else
      let triple := 3*(val + 2)
      1 + steps ⟨triple + 1, Nat.zero_lt_succ triple⟩

end CollatzConjecture
