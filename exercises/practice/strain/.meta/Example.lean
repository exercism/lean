namespace Strain

class Partition (α : Type u) (β : Type v) where
  keep : (α → Bool) → β → β
  discard : (α → Bool) → β → β

instance {α : Type u} : Partition α (List α) where
  keep fn xs := xs.foldr (init := []) fun x acc => if fn x then x :: acc else acc
  discard fn xs := xs.foldr (init := []) fun x acc => if fn x then acc else x :: acc

end Strain
