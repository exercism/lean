namespace Dominoes

def Half := { x : Nat // x ≥ 1 ∧ x ≤ 6 }

def Stone := Half × Half

def findRoot (parents : Array Nat) (entry : Nat) : Nat := Id.run do
  let mut current := entry
  while current != parents[current]! do
    current := parents[current]!
  return current

def canChain (dominoes : List Stone) : Bool := Id.run do
  let mut tally := Array.replicate 7 (0 : Nat)
  for stone in dominoes do
    let first := stone.1.val
    let firstCount := tally[first]! + 1
    tally := tally.set! first firstCount
    let second := stone.2.val
    let secondCount := tally[second]! + 1
    tally := tally.set! second secondCount
  for entry in tally do
    if (entry &&& 1) != 0 then return false

  let mut parents : Array Nat := List.range 7 |> List.toArray
  for stone in dominoes do
    let firstRoot := findRoot parents stone.1.val
    let secondRoot := findRoot parents stone.2.val
    parents := parents.set! secondRoot firstRoot

  let mut count := 0
  for i in [0:7] do
    if (tally[i]! > 0) && (i == parents[i]!) then count := count + 1
  return count ≤ 1

end Dominoes
