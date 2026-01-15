namespace BinarySearch

def find (value : Int) (array : Array Int) : Option Nat := Id.run do
  let mut low := Int.ofNat 0
  let mut high := Int.ofNat array.size - 1
  while low <= high do
    let mid := (low + high) >>> 1
    let crt := array[mid.toNat]!
    match compare crt value with
    | Ordering.eq => return (some mid.toNat)
    | Ordering.gt => high := mid - 1
    | Ordering.lt => low := low + 1
  return none

end BinarySearch
