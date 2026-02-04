namespace Sublist

inductive Classification where
  | sublist | superlist | equal | unequal
  deriving BEq, Repr

def sublist (listOne listTwo : List Nat) : Classification :=
  sorry

end Sublist
