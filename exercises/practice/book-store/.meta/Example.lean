namespace BookStore

def Book := { x : Nat // x ≥ 1 ∧ x ≤ 5 }

def tally (basket : List Book) : Array Nat := Id.run do
  let mut result := Array.replicate 6 (0 : Nat)
  for book in basket do
    result := result.set! book.val (result[book.val]! + 1)
  result

def sort (array : Array Nat) : Array Nat :=
  Array.qsort array (fun a b => a < b)

def difference (array : Array Nat) : Array Nat := Id.run do
  let mut result := Array.replicate 6 array[5]!
  result := result.set! 0 0
  for i in [1:6] do
    result := result.set! (6 - i) (array[i]! - array[i - 1]!)
  result

def adjust (array : Array Nat) : Array Nat := Id.run do
  let mut result := array.set! 0 0
  let adjustment := min array[3]! array[5]!
  result := result.set! 3 (array[3]! - adjustment)
  result := result.set! 4 (array[4]! + 2 * adjustment)
  result := result.set! 5 (array[5]! - adjustment)
  result

def price (array : Array Nat) : Nat :=
  let one := array[1]!
  let two := array[2]!
  let three := array[3]!
  let four := array[4]!
  let five := array[5]!
  800 * one + 1520 * two + 2160 * three + 2560 * four + 3000 * five

def total (basket : List Book) : Nat :=
  basket
  |> tally
  |> sort
  |> difference
  |> adjust
  |> price

end BookStore
