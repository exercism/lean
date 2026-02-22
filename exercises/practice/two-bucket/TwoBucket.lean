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

def measure (first second : Capacity) (goal : Volume) (start : BucketId) : Option Result :=
  sorry --remove this line and implement the function

end TwoBucket
