namespace Change

inductive Result where
  | ok : Array Nat -> Result
  | error : String -> Result
  deriving BEq, Repr

def findFewestCoins (coins : Array Nat) (target : Int) : Result :=
  sorry

end Change
