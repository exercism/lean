namespace BinarySearchTree

inductive Tree (α : Type) [BEq α] [Repr α] [Ord α] [Inhabited α] where
  | nil  : Tree α
  | node : α → Tree α → Tree α → Tree α
  deriving Inhabited

def Tree.data! {α} [BEq α] [Repr α] [Ord α] [Inhabited α] : Tree α → α
  | .nil        => panic! "empty tree"
  | .node x _ _ => x

def Tree.left! {α} [BEq α] [Repr α] [Ord α] [Inhabited α] : Tree α → Tree α
  | .nil        => panic! "empty tree"
  | .node _ l _ => l

def Tree.right! {α} [BEq α] [Repr α] [Ord α] [Inhabited α] : Tree α → Tree α
  | .nil        => panic! "empty tree"
  | .node _ _ r => r

def Tree.insert {α} [BEq α] [Repr α] [Ord α] [Inhabited α] : Tree α → α → Tree α
  | .nil, x        => .node x .nil .nil
  | .node y l r, x =>
    match compare x y with
    | .eq | .lt => .node y (Tree.insert l x) r
    | .gt       => .node y l (Tree.insert r x)

def buildTree {α} [BEq α] [Repr α] [Ord α] [Inhabited α] (list : List α) : Tree α :=
  list.foldl Tree.insert .nil

def Tree.sort {α} [BEq α] [Repr α] [Ord α] [Inhabited α] : Tree α → List α
  | .nil        => []
  | .node x l r => l.sort ++ x :: r.sort

end BinarySearchTree
