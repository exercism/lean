namespace EliudsEggs

def eggCount (number : Nat) : Nat :=
  if number > 0 then (number &&& 1) + eggCount (number >>> 1)
  else 0

end EliudsEggs
