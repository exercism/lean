namespace Grains

def grains (square : Int) : Option Nat :=
  if (square < 1 || square > 64) then none
  else some (1 <<< (square.toNat - 1))

def totalGrains : Nat :=
  (1 <<< 64) - 1

end Grains
