namespace Allergies

inductive Allergen where
  | eggs : Allergen
  | peanuts : Allergen
  | shellfish : Allergen
  | strawberries : Allergen
  | tomatoes : Allergen
  | chocolate : Allergen
  | pollen : Allergen
  | cats : Allergen
  deriving BEq, Repr

def allergicTo (allergen : Allergen) (score : Nat) : Bool :=
  sorry --remove this line and implement the function

def list (score : Nat) : List Allergen :=
  sorry --remove this line and implement the function

end Allergies
