namespace LinkedList

variable {α σ : Type} [BEq α]

structure LinkedList (σ α : Type) where
  -- You should define a data structure LinkedList to represent your doubly-linked list here.

def LinkedList.empty : ST σ (LinkedList σ α) :=
  sorry --remove this line and implement the function

def LinkedList.count (list : LinkedList σ α) : ST σ Nat :=
  sorry --remove this line and implement the function

def LinkedList.push (value : α) (list : LinkedList σ α) : ST σ Unit :=
  sorry --remove this line and implement the function

def LinkedList.unshift (value : α) (list : LinkedList σ α) : ST σ Unit :=
  sorry --remove this line and implement the function

def LinkedList.pop (list : LinkedList σ α) : ST σ (Option α) :=
  sorry --remove this line and implement the function

def LinkedList.shift (list : LinkedList σ α) : ST σ (Option α) :=
  sorry --remove this line and implement the function

def LinkedList.delete (value : α) (list : LinkedList σ α) : ST σ Unit :=
  sorry --remove this line and implement the function

end LinkedList
