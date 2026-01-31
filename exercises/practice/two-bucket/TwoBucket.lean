namespace TwoBucket

inductive BucketId where
  | one | two
  deriving BEq, Repr

abbrev Capacity := Nat
abbrev Volume := Nat

structure Result where
  moves  : Nat
  goal   : BucketId
  other  : Volume
  deriving BEq, Repr

def measure (one two : Capacity) (goal : Volume) (start : BucketId) : Option Result :=
  sorry

end TwoBucket
