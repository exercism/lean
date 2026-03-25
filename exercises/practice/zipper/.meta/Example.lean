namespace Zipper

inductive BinTree (α : Type) where
  | nil  : BinTree α
  | node : α → BinTree α → BinTree α → BinTree α
  deriving BEq, Repr, Inhabited

inductive Crumb (α : Type) where
  | leftOf  : α → BinTree α → Crumb α
  | rightOf : α → BinTree α → Crumb α
  deriving BEq, Repr

structure Zipper (α : Type) where
  focus  : BinTree α
  crumbs : List (Crumb α)
  deriving BEq, Repr

def fromTree (tree : BinTree α) : Zipper α :=
  { focus := tree, crumbs := [] }

def Zipper.toTree : Zipper α → BinTree α
  | { focus, crumbs := [] } => focus
  | { focus, crumbs := .leftOf v r :: cs } =>
    Zipper.toTree { focus := .node v focus r, crumbs := cs }
  | { focus, crumbs := .rightOf v l :: cs } =>
    Zipper.toTree { focus := .node v l focus, crumbs := cs }

def Zipper.value : Zipper α → Option α
  | { focus := .nil, .. } => none
  | { focus := .node v _ _, .. } => some v

def Zipper.left : Zipper α → Option (Zipper α)
  | { focus := .nil, .. } => none
  | { focus := .node v l r, crumbs } =>
    match l with
    | .nil => none
    | _    => some { focus := l, crumbs := .leftOf v r :: crumbs }

def Zipper.right : Zipper α → Option (Zipper α)
  | { focus := .nil, .. } => none
  | { focus := .node v l r, crumbs } =>
    match r with
    | .nil => none
    | _    => some { focus := r, crumbs := .rightOf v l :: crumbs }

def Zipper.up : Zipper α → Option (Zipper α)
  | { crumbs := [], .. } => none
  | { focus, crumbs := .leftOf v r :: cs } =>
    some { focus := .node v focus r, crumbs := cs }
  | { focus, crumbs := .rightOf v l :: cs } =>
    some { focus := .node v l focus, crumbs := cs }

def Zipper.setValue (val : α) : Zipper α → Zipper α
  | { focus := .nil, crumbs } => { focus := .nil, crumbs }
  | { focus := .node _ l r, crumbs } => { focus := .node val l r, crumbs }

def Zipper.setLeft (tree : BinTree α) : Zipper α → Zipper α
  | { focus := .nil, crumbs } => { focus := .nil, crumbs }
  | { focus := .node v _ r, crumbs } => { focus := .node v tree r, crumbs }

def Zipper.setRight (tree : BinTree α) : Zipper α → Zipper α
  | { focus := .nil, crumbs } => { focus := .nil, crumbs }
  | { focus := .node v l _, crumbs } => { focus := .node v l tree, crumbs }

end Zipper
