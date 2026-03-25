namespace Zipper

inductive BinTree where
  | nil  : BinTree
  | node : Int → BinTree → BinTree → BinTree
  deriving BEq, Repr, Inhabited

inductive Crumb where
  | leftOf  : Int → BinTree → Crumb
  | rightOf : Int → BinTree → Crumb
  deriving BEq, Repr

structure Zipper where
  focus  : BinTree
  crumbs : List Crumb
  deriving BEq, Repr

def fromTree (tree : BinTree) : Zipper :=
  { focus := tree, crumbs := [] }

def Zipper.toTree : Zipper → BinTree
  | { focus, crumbs := [] } => focus
  | { focus, crumbs := .leftOf v r :: cs } =>
    Zipper.toTree { focus := .node v focus r, crumbs := cs }
  | { focus, crumbs := .rightOf v l :: cs } =>
    Zipper.toTree { focus := .node v l focus, crumbs := cs }

def Zipper.value : Zipper → Option Int
  | { focus := .nil, .. } => none
  | { focus := .node v _ _, .. } => some v

def Zipper.left : Zipper → Option Zipper
  | { focus := .nil, .. } => none
  | { focus := .node v l r, crumbs } =>
    match l with
    | .nil => none
    | _    => some { focus := l, crumbs := .leftOf v r :: crumbs }

def Zipper.right : Zipper → Option Zipper
  | { focus := .nil, .. } => none
  | { focus := .node v l r, crumbs } =>
    match r with
    | .nil => none
    | _    => some { focus := r, crumbs := .rightOf v l :: crumbs }

def Zipper.up : Zipper → Option Zipper
  | { crumbs := [], .. } => none
  | { focus, crumbs := .leftOf v r :: cs } =>
    some { focus := .node v focus r, crumbs := cs }
  | { focus, crumbs := .rightOf v l :: cs } =>
    some { focus := .node v l focus, crumbs := cs }

def Zipper.setValue (val : Int) : Zipper → Zipper
  | { focus := .nil, crumbs } => { focus := .nil, crumbs }
  | { focus := .node _ l r, crumbs } => { focus := .node val l r, crumbs }

def Zipper.setLeft (tree : BinTree) : Zipper → Zipper
  | { focus := .nil, crumbs } => { focus := .nil, crumbs }
  | { focus := .node v _ r, crumbs } => { focus := .node v tree r, crumbs }

def Zipper.setRight (tree : BinTree) : Zipper → Zipper
  | { focus := .nil, crumbs } => { focus := .nil, crumbs }
  | { focus := .node v l _, crumbs } => { focus := .node v l tree, crumbs }

end Zipper
