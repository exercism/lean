namespace CustomSet

abbrev Size := Nat

inductive Set where
  | nil  : Set
  | node : Size → Nat → Set → Set → Set
  deriving Repr, Inhabited

instance : EmptyCollection Set :=
  ⟨ .nil ⟩ -- takes care of ∅

private def Set.size : Set → Size
  | .nil          => 0
  | .node s _ _ _ => s

private def Set.contains : Set → Nat → Bool
  | .nil, _ => false
  | .node _ x l r, e => e == x || if e < x then l.contains e else r.contains e

private def Set.foldl {α} (fn : α → Nat → α) (init : α) (set : Set) : α :=
  match set with
  | .nil => init
  | .node _ x l r =>
    let leftAcc := l.foldl fn init
    let acc := fn leftAcc x
    r.foldl fn acc

instance : BEq Set where -- takes care of == and !=
  beq s1 s2 := s1.size == s2.size && s1.foldl (fun acc x => acc && s2.contains x) true

instance : Membership Nat Set where -- takes care of ∈ and ∉
  mem s n := s.contains n

instance (a : Nat) (s : Set) : Decidable (a ∈ s) := by
  simp [Membership.mem]
  exact inferInstance

private def Set.subset (set1 set2 : Set) : Bool :=
  set1.foldl (fun acc x => acc && set2.contains x) true

instance : HasSubset Set where
  Subset s1 s2 := s1.subset s2

instance (s1 s2 : Set) : Decidable (s1 ⊆ s2) := by
  simp [HasSubset.Subset]
  exact inferInstance

notation a " ⊈ " b => ¬(a ⊆ b)

private def Set.addHelper (e : Nat) (s : Set) : Set :=
  match s with
  | .nil => .node 1 e .nil .nil
  | .node s x l r =>
    if e < x
    then Set.node (s + 1) x (l.addHelper e) r
    else Set.node (s + 1) x l (r.addHelper e)

def Set.add (elem : Nat) (set : Set) : Set :=
  if elem ∈ set then set
  else set.addHelper elem

def Set.ofList (xs : List Nat) : Set :=
  xs.foldl (fun acc x => acc.add x) ∅

instance : Inter Set where -- takes care of ∩
  inter s1 s2 := s1.foldl (fun acc x => if s2.contains x then acc.add x else acc) ∅

instance : Union Set where -- takes care of ∪
  union s1 s2 := s1.foldl (fun acc x => acc.add x) s2

instance : SDiff Set where -- takes care of \
  sdiff s1 s2 := s1.foldl (fun acc x => if s2.contains x then acc else acc.add x) ∅

def Set.disjoint (set1 set2 : Set) : Bool :=
  set1.foldl (fun acc x => acc && !set2.contains x) true

end CustomSet
