namespace NthPrime

def updateTable (index : Nat) (increment : Nat) (table : Array Bool) : Array Bool :=
  if positiveIncrement : increment > 0 then
    if validIndex : index < table.size then
      updateTable (index + increment) increment (table.set index false)
    else table
  else table

def prime' (remaining : Nat) (index : Nat) (table : Array Bool) : Option Nat :=
  if valuesLeft : remaining > 0 then
    if validIndex : index < table.size then
      if table[index] then
        if remaining == 1 then some index
        else prime' (remaining - 1) (index + 1) (updateTable (index * index) index table)
      else prime' remaining (index + 1) table
    else none
  else none

def prime (n : Nat) : Option Nat :=
  let logn := n.log2
  let loglogn := logn.log2
  let upperBound := n * (logn + loglogn) + 3
  let firstPrime := 2
  prime' n firstPrime (Array.replicate upperBound true)

end NthPrime
