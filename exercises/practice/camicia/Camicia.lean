namespace Camicia

inductive Card where
  | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9
  | C10 | CJ | CQ | CK | CA
  deriving BEq, Repr

inductive Status where
  | finished | loop
  deriving BEq, Repr

structure Result where
  status : Status
  cards  : Nat
  tricks : Nat
  deriving BEq, Repr

def simulateGame (playerA playerB : List Card) : Result :=
  sorry

end Camicia
