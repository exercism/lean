namespace ZebraPuzzle

inductive Nationality where
  | Englishman
  | Japanese
  | Norwegian
  | Spaniard
  | Ukrainian
  deriving BEq, Inhabited, Repr

def drinksWater : Nationality :=
  sorry

def ownsZebra : Nationality :=
  sorry

end ZebraPuzzle
