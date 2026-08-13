namespace FruitStand

def applePrice : Nat := 50

def revenue (applesSold : Nat) : Nat :=
  applesSold * applePrice

def profit (applesSold expenses : Nat) : Nat :=
  revenue applesSold - expenses

end FruitStand
