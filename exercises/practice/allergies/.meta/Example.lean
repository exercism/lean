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

def Allergen.toNat : Allergen -> Nat
  | .eggs => 1
  | .peanuts => 2
  | .shellfish => 4
  | .strawberries => 8
  | .tomatoes => 16
  | .chocolate => 32
  | .pollen => 64
  | .cats => 128

def allergicTo (allergen : Allergen) (score : Nat) : Bool :=
  score &&& allergen.toNat != 0

def list (score : Nat) : List Allergen :=
  [.eggs, .peanuts, .shellfish, .strawberries, .tomatoes, .chocolate, .pollen, .cats].filter (allergicTo · score)

end Allergies
