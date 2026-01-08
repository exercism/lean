namespace Knapsack

structure Item where
  weight : Nat
  value : Int

def maximumValue (maximumWeight : Nat) (items : Array Item) : Int := Id.run do
  let mut table := Array.replicate (maximumWeight + 1) (0 : Int)
  for item in items do
    for spare in [item.weight:maximumWeight + 1] do
      let index := maximumWeight + item.weight - spare
      let best := max (table[index - item.weight]! + item.value) table[index]!
      table := table.set! index best
  return table[maximumWeight]!

end Knapsack
