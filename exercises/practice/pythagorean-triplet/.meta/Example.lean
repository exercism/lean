import Std

namespace PythagoreanTriplet

def getDivisors (n : Nat) : Std.TreeSet Nat := Id.run do
  let mut array := #[]
  for divisor in [1:n+1] do
    if n % divisor == 0 then
      array := array.push divisor
  return Std.TreeSet.ofArray array

def tripletsWithSum (sum : Nat) : List (List Nat) := Id.run do
  /-
    for any primitive pythagorean triplet:
      a = m² - n²
      b = 2mn
      c = m² + n²
    for some m > n > 0
    a, b, c in a non-primitive pythagorean triplet is k multiplied by its primitive counterpart
    So, k*a, k*b, k*c, for a k <- [1..]
    Note that k*a + k*b + k*c = k*(m² - n²) + k*2mn + k*(m² + n²) = k*2m² + k*2mn = k*2m * (m + n)
    This means that:
    1. sum must be even.
    2. k*m and m + n are divisors of sum / 2
    3. k and m are divisors of k*m
    -/
  if sum &&& 1 == 1 then return []
  else
    let mut triplets : Std.TreeSet (List Nat) := {}
    let target := sum >>> 1 /- k * m * (m + n)-/
    let divisors := getDivisors target
    for factor1 in divisors do
      let factor2 := target / factor1
      for divisor in getDivisors factor1 do
        let m1 := factor1 / divisor
        let n1 := factor2 - m1
        let k1 := divisor
        if n1 > 0 && m1 > n1 then
          let a := m1*m1 - n1*n1
          let b := 2*m1*n1
          let c := m1*m1 + n1*n1
          triplets := triplets.insert [k1*a, k1*b, k1*c].mergeSort
    return triplets.toList

end PythagoreanTriplet
