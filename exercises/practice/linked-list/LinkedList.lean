namespace LinkedList

variable {α : Type} [BEq α]

structure LinkedList (α : Type) where
  -- You should define a data structure LinkedList to represent your doubly-linked list here.

def LinkedList.empty : IO (LinkedList α) :=
  sorry

def LinkedList.count (list : LinkedList α) : IO Nat :=
  sorry

def LinkedList.push (value : α) (list : LinkedList α) : IO Unit :=
  sorry

def LinkedList.unshift (value : α) (list : LinkedList α) : IO Unit :=
  sorry

def LinkedList.pop (list : LinkedList α) : IO (Option α) :=
  sorry

def LinkedList.shift (list : LinkedList α) : IO (Option α) :=
  sorry

def LinkedList.delete (value : α) (list : LinkedList α) : IO Unit :=
  sorry

end LinkedList
