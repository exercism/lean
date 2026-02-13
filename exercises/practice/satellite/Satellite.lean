namespace Satellite

inductive Tree (α : Type) : Type where
  | leaf
  | branch (value : α) (left right : Tree α)
  deriving BEq, Repr

inductive Result where
  | ok : Tree Char -> Result
  | error : String -> Result
  deriving BEq, Repr

def treeFromTraversals (preorder inorder : List Char) : Result :=
  sorry

end Satellite
