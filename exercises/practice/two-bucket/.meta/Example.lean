import Std

open Std

namespace TwoBucket

inductive BucketId where
  | one | two
  deriving BEq, Repr

abbrev Capacity := Nat
abbrev Volume := Nat

structure Result where
  moves  : Nat
  goal   : BucketId
  other  : Volume
  deriving BEq, Repr

structure Volumes where
  first   : Volume
  second  : Volume
  deriving BEq, Repr, Hashable

structure State where
  moves     : Nat
  volumes   : Volumes
  deriving BEq, Repr

abbrev Transform := State -> State
abbrev Constraint := State -> Bool

def pourOneToTwo (second : Capacity) (state : State) : State :=
  let poured := min state.volumes.first (second - state.volumes.second)
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { first := state.volumes.first - poured,
        second := state.volumes.second + poured }
  }

def pourTwoToOne (first : Capacity) (state : State) : State :=
  let poured := min (first - state.volumes.first) state.volumes.second
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { first := state.volumes.first + poured,
        second := state.volumes.second - poured }
  }

def emptyOne (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with first := 0 }
  }

def emptyTwo (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with second := 0 }
  }

def fillOne (first : Capacity) (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with first := first }
  }

def fillTwo (second : Capacity) (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with second := second }
  }

def checkConstraint (first second : Capacity) : BucketId -> State -> Bool
  | .one, state => state.volumes.first ≠ 0 ∨ state.volumes.second ≠ second
  | .two, state => state.volumes.first ≠ first ∨ state.volumes.second ≠ 0

def simulate (fuel : Nat) (goal : Volume) (transforms : List Transform) (constraint : Constraint) (seen : HashSet Volumes) (queue : Queue State) : Option Result :=
  match fuel with -- search is bounded by `fuel` and thus terminates
  | 0 => none
  | n + 1 =>
    match queue.dequeue? with
    | none               => none
    | some (state, tail) =>
        let nextSeen := seen.insert state.volumes
        if state.volumes.first = goal then
          some { moves := state.moves, goal := .one, other := state.volumes.second }
        else if state.volumes.second = goal then
          some { moves := state.moves, goal := .two, other := state.volumes.first }
        else
          let nextStates := transforms.map (· state) |>.filter (λ s => s.volumes ∉ nextSeen ∧ constraint s)
          simulate n goal transforms constraint nextSeen (tail.enqueueAll nextStates)

def measure (first second : Capacity) (goal : Volume) (start : BucketId) : Option Result :=
  if goal > first ∧ goal > second then none
  else
    let fuel := (first + 1) * (second + 1) -- max number of distinct volume configurations the system can assume
    let transforms : List Transform := [pourOneToTwo second, pourTwoToOne first, emptyOne, emptyTwo, fillOne first, fillTwo second]
    let constraint : Constraint := checkConstraint first second start
    let startState : State := match start with
                              | .one => { moves := 1, volumes := { first := first, second := 0 } }
                              | .two => { moves := 1, volumes := { first := 0, second := second } }
    simulate fuel goal transforms constraint {} (Queue.enqueue startState .empty)

end TwoBucket
