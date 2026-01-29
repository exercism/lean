import Std

namespace Camicia

inductive Card where
  | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9
  | C10 | CJ | CQ | CK | CA
  deriving BEq, Repr, Nonempty

inductive Status where
  | finished | loop
  deriving BEq, Repr, Nonempty

structure Result where
  status : Status
  cards  : Nat
  tricks : Nat
  deriving BEq, Repr, Nonempty

inductive Turn where
  | playerA | playerB
  deriving BEq, Repr, Nonempty

def Card.value : Card -> Nat
  | .C2 | .C3 | .C4 | .C5 | .C6 | .C7 | .C8 | .C9 | .C10 => 0
  | .CJ => 1
  | .CQ => 2
  | .CK => 3
  | .CA => 4

abbrev NumCards := Nat
abbrev NumTricks := Nat
abbrev Penalty := Nat
abbrev Deck := List Nat
abbrev Pile := List Nat

partial def takeTurn : Turn -> Deck -> Deck -> Pile -> NumCards -> NumTricks -> Penalty -> Std.HashSet (Deck × Deck) -> Result
  | .playerA, [], _, _, cards, tricks, _, _
  | .playerB, _, [], _, cards, tricks, _, _                         => { status := .finished, cards := cards, tricks := tricks + 1 }
  | .playerA, 0 :: deckA, deckB, pile, cards, tricks, 0, seen       => takeTurn .playerB deckA deckB (0 :: pile) (cards + 1) tricks 0 seen
  | .playerB, deckA, 0 :: deckB, pile, cards, tricks, 0, seen       => takeTurn .playerA deckA deckB (0 :: pile) (cards + 1) tricks 0 seen
  | .playerA, [0], _, _, cards, tricks, 1, _
  | .playerB, _, [0], _, cards, tricks, 1, _                        => { status := .finished, cards := cards + 1, tricks := tricks + 1 }
  | .playerA, 0 :: deckA, deckB, pile, cards, tricks, 1, seen       =>
      let newDeckB := deckB ++ (0 :: pile).reverse
      if seen.contains (deckA, newDeckB)
      then { status := .loop, cards := cards + 1, tricks := tricks + 1 }
      else takeTurn .playerB deckA newDeckB [] (cards + 1) (tricks + 1) 0 (seen.insert (deckA, newDeckB))
  | .playerB, deckA, 0 :: deckB, pile, cards, tricks, 1, seen       =>
      let newDeckA := deckA ++ (0 :: pile).reverse
      if seen.contains (newDeckA, deckB)
      then { status := .loop, cards := cards + 1, tricks := tricks + 1 }
      else takeTurn .playerA newDeckA deckB [] (cards + 1) (tricks + 1) 0 (seen.insert (newDeckA, deckB))
  | .playerA, 0 :: deckA, deckB, pile, cards, tricks, penalty, seen => takeTurn .playerA deckA deckB (0 :: pile) (cards + 1) tricks (penalty - 1) seen
  | .playerB, deckA, 0 :: deckB, pile, cards, tricks, penalty, seen => takeTurn .playerB deckA deckB (0 :: pile) (cards + 1) tricks (penalty - 1) seen
  | .playerA, n :: deckA, deckB, pile, cards, tricks, _, seen       => takeTurn .playerB deckA deckB (n :: pile) (cards + 1) tricks n seen
  | .playerB, deckA, n :: deckB, pile, cards, tricks, _, seen       => takeTurn .playerA deckA deckB (n :: pile) (cards + 1) tricks n seen

def simulateGame (playerA playerB : List Card) : Result :=
  let deckA := playerA.map Card.value
  let deckB := playerB.map Card.value
  takeTurn .playerA deckA deckB [] 0 0 0 (.ofList [(deckA, deckB)])

end Camicia
