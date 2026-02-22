namespace ZebraPuzzle

inductive Nationality where
  | Englishman
  | Japanese
  | Norwegian
  | Spaniard
  | Ukrainian
  deriving BEq, Inhabited, Repr

def drinksWater : Nationality :=
  sorry --remove this line and implement the function

def ownsZebra : Nationality :=
  sorry --remove this line and implement the function

end ZebraPuzzle
