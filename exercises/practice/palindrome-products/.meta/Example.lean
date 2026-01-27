namespace PalindromeProducts

structure Factors where
  a : Nat
  b : Nat
  deriving BEq, Repr

inductive Result where
  | invalid : Result
  | empty   : Result
  | valid   : Nat -> List Factors -> Result
  deriving BEq, Repr

def isPalindromic (n : Nat) : Bool :=
  let digits := Nat.toDigits 10 n
  digits == digits.reverse

def smallest (min max : Nat) : Result :=
  if min > max then .invalid
  else Id.run do
    let mut smallestPalindrome := max*max + 1
    let mut factors : Array Factors := #[]
    for f1 in min...=max do
      for f2 in f1...=max do
        let product := f1 * f2
        match compare product smallestPalindrome with
        | .gt => break
        | .eq => factors := factors.push ⟨f1, f2⟩
        | .lt =>
          if isPalindromic product then
            smallestPalindrome := product
            factors := #[⟨f1, f2⟩]
    if factors.isEmpty then return .empty
    else return .valid smallestPalindrome factors.toList

def largest (min max : Nat) : Result :=
  if min > max then .invalid
  else Id.run do
    let mut largestPalindrome := min*min - 1
    let mut factors : List Factors := []
    for k1 in [: (max - min + 1)] do
      let f1 := max - k1
      for k2 in [: (max - f1 + 1)] do
        let f2 := max - k2
        let product := f1 * f2
        match compare product largestPalindrome with
        | .lt => break
        | .eq => factors := ⟨f1, f2⟩ :: factors
        | .gt =>
          if isPalindromic product then
            largestPalindrome := product
            factors := [⟨f1, f2⟩]
    if factors.isEmpty then return .empty
    else return .valid largestPalindrome factors

end PalindromeProducts
