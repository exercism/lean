namespace ListOps

def append (list1 : List α) (list2 : List α) : List α :=
  match list1 with
  | [] => list2
  | x :: xs => x :: append xs list2

def concat (lists : List (List α)) : List α :=
  match lists with
  | [] => []
  | xs :: rest => append xs (concat rest)

def filter (f : α → Bool) (list : List α) : List α :=
  match list with
  | [] => []
  | x :: xs => if f x then x :: filter f xs else filter f xs

def length (list : List α) : Nat :=
  match list with
  | [] => 0
  | _ :: xs => 1 + length xs

def map (f : α → β) (list : List α) : List β :=
  match list with
  | [] => []
  | x :: xs => f x :: map f xs

def foldl (f : β → α → β) (initial : β) (list : List α) : β :=
  match list with
  | [] => initial
  | x :: xs => foldl f (f initial x) xs

def foldr (f : α → β → β) (initial : β) (list : List α) : β :=
  match list with
  | [] => initial
  | x :: xs => f x (foldr f initial xs)

def reverse (list : List α) : List α :=
  let rec go (acc : List α) : List α → List α
    | [] => acc
    | x :: xs => go (x :: acc) xs
  go [] list

end ListOps
