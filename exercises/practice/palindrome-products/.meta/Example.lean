namespace PalindromeProducts

structure Factors where
  a : Nat
  b : Nat
  h : a ≤ b
  deriving BEq, Repr

structure Result where
  product : Nat
  factors : List Factors
  deriving BEq, Repr

def isPalindromic (n : Nat) : Bool :=
  let digits := Nat.toDigits 10 n
  digits == digits.reverse

def smallest (min max : Nat) (_ : min ≤ max) : Option Result := do
    let mut smallestPalindrome := max*max + 1
    let mut factors : List Factors := []
    let mut f1 := min
    while f1 <= max do
      let mut f2 : { x : Nat // f1 <= x } := ⟨f1, by simp⟩
      while f2 <= max do
        let product := f1 * f2
        let crt := f2
        f2 := ⟨f2.val + 1, by grind⟩
        match compare product smallestPalindrome with
        | .gt => break
        | .eq => factors := ⟨f1, crt, crt.property⟩ :: factors
        | .lt =>
          if isPalindromic product then
            smallestPalindrome := product
            factors := [⟨f1, crt, crt.property⟩]
      f1 := f1 + 1
    guard !factors.isEmpty
    some ⟨smallestPalindrome, factors.reverse⟩

def largest (min max : Nat) (_ : min ≤ max) : Option Result := do
    let mut largestPalindrome := min*min - 1
    let mut factors : List Factors := []
    let mut f1 := max
    while min <= f1 do
      let mut f2 := max
      while valid: f1 <= f2 do
        let product := f1 * f2
        let crt := f2
        f2 := f2 - 1
        match compare product largestPalindrome with
        | .lt => break
        | .eq => factors := ⟨f1, crt, valid⟩ :: factors
        | .gt =>
          if isPalindromic product then
            largestPalindrome := product
            factors := [⟨f1, crt, valid⟩]
      f1 := f1 - 1
    guard !factors.isEmpty
    some ⟨largestPalindrome, factors⟩

end PalindromeProducts
