namespace Sublist

inductive Classification where
  | sublist | superlist | equal | unequal
  deriving BEq, Repr

def find (needle haystack : List Nat) (needleLen : Nat) : Nat -> Bool
  | 0        => false
  | n + 1    =>
    haystack.take needleLen == needle || find needle (haystack.drop 1) needleLen n

def sublist (listOne listTwo : List Nat) : Classification :=
  let len1 := listOne.length
  let len2 := listTwo.length
  match compare len1 len2 with
  | .eq => if listOne == listTwo then .equal else .unequal
  | .lt => if find listOne listTwo len1 (len2 - len1 + 1) then .sublist else .unequal
  | .gt => if find listTwo listOne len2 (len1 - len2 + 1) then .superlist else .unequal

end Sublist
