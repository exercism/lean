namespace FlattenArray

inductive Box (α : Type) : Type where
  | zero
  | one (value : α)
  | many (boxes : Array (Box α))

def flatten (box : Box Int) : Array Int :=
  match box with
  | Box.zero => #[]
  | Box.one (value : Int) => #[value]
  | Box.many (boxes : Array (Box Int)) => Array.flatten (Array.map flatten boxes)

end FlattenArray
