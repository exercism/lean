namespace FlattenArray

inductive Box (α : Type) : Type where
  | zero
  | one (value : α)
  | many (boxes : Array (Box α))

def flatten (box : Box Int) : Array Int :=
  sorry --remove this line and implement the function

end FlattenArray
