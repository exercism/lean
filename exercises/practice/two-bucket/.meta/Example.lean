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
  one  : Volume
  two  : Volume
  deriving BEq, Repr, Hashable

structure State where
  moves     : Nat
  volumes   : Volumes
  deriving BEq, Repr

abbrev Transform := State -> State
abbrev Constraint := State -> Bool

def pourOneToTwo (two : Capacity) (state : State) : State :=
  let poured := min state.volumes.one (two - state.volumes.two)
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { one := state.volumes.one - poured,
        two := state.volumes.two + poured }
  }

def pourTwoToOne (one : Capacity) (state : State) : State :=
  let poured := min (one - state.volumes.one) state.volumes.two
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { one := state.volumes.one + poured,
        two := state.volumes.two - poured }
  }

def emptyOne (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with one := 0 }
  }

def emptyTwo (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with two := 0 }
  }

def fillOne (one : Capacity) (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with one := one }
  }

def fillTwo (two : Capacity) (state : State) : State :=
  {
    state with
      moves := state.moves + 1,
      volumes :=
      { state.volumes with two := two }
  }

def checkConstraint (one two : Capacity) : BucketId -> State -> Bool
  | .one, state => state.volumes.one ≠ 0 ∨ state.volumes.two ≠ two
  | .two, state => state.volumes.one ≠ one ∨ state.volumes.two ≠ 0

def simulate (fuel : Nat) (goal : Volume) (transforms : List Transform) (constraint : Constraint) (seen : HashSet Volumes) (queue : Queue State) : Option Result :=
  match fuel with -- search is bounded by `fuel` and thus terminates
  | 0 => none
  | n + 1 =>
    match queue.dequeue? with
    | none               => none
    | some (state, tail) =>
        if state.volumes ∈ seen then
          simulate n goal transforms constraint seen tail
        else
          let nextSeen := seen.insert state.volumes
          if state.volumes.one = goal then
            some { moves := state.moves, goal := .one, other := state.volumes.two }
          else if state.volumes.two = goal then
            some { moves := state.moves, goal := .two, other := state.volumes.one }
          else
            let nextStates := transforms.map (· state) |>.filter (λ s => s.volumes ∉ nextSeen ∧ constraint s)
            simulate n goal transforms constraint nextSeen (tail.enqueueAll nextStates)

def measure (one two : Capacity) (goal : Volume) (start : BucketId) : Option Result :=
  if goal > one ∧ goal > two then none
  else
    let fuel := (one + 1) * (two + 1) -- max number of distinct volume configurations the system can assume
    let transforms : List Transform := [pourOneToTwo two, pourTwoToOne one, emptyOne, emptyTwo, fillOne one, fillTwo two]
    let constraint : Constraint := checkConstraint one two start
    let startState : State := match start with
                              | .one => { moves := 1, volumes := { one := one, two := 0 } }
                              | .two => { moves := 1, volumes := { one := 0, two := two } }
    simulate fuel goal transforms constraint {} (Queue.enqueue startState .empty)

end TwoBucket
