namespace Hamming

def differences (list1 : List Char) (list2 : List Char) (acc : Nat) : Option Nat :=
  match list1, list2 with
  | [], [] => some acc
  | [], _ => none
  | _, [] => none
  | (first1 :: rest1), (first2 :: rest2) => differences rest1 rest2 (acc + (if first1 == first2 then 0 else 1))

def zip (l₁ : List α) (l₂ : List β) : List (α × β) :=
  match l₁, l₂ with
  | [], _ => []
  | _, [] => []
  | (x :: xs), (y :: ys) => (x, y) :: zip xs ys

def distance (strand1 : String) (strand2 : String) : Option Nat :=
  differences (String.toList strand1) (String.toList strand2) 0

end Hamming
