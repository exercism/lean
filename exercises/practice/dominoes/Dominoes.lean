namespace Dominoes

def Half := { x : Nat // x ≥ 1 ∧ x ≤ 6 }

def Stone := Half × Half

def canChain (dominoes : List Stone) : Bool :=
  sorry --remove this line and implement the function

end Dominoes
