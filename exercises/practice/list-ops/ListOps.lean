namespace ListOps

def append (list1 : List α) (list2 : List α) : List α :=
  sorry --remove this line and implement the function

def concat (lists : List (List α)) : List α :=
  sorry --remove this line and implement the function

def filter (f : α → Bool) (list : List α) : List α :=
  sorry --remove this line and implement the function

def length (list : List α) : Nat :=
  sorry --remove this line and implement the function

def map (f : α → β) (list : List α) : List β :=
  sorry --remove this line and implement the function

def foldl (f : β → α → β) (initial : β) (list : List α) : β :=
  sorry --remove this line and implement the function

def foldr (f : α → β → β) (initial : β) (list : List α) : β :=
  sorry --remove this line and implement the function

def reverse (list : List α) : List α :=
  sorry --remove this line and implement the function

end ListOps
