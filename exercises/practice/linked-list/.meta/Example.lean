import Std
open Std

namespace LinkedList

variable {α σ : Type} [BEq α] [Inhabited α]

structure Node (α : Type) where
  prev  : Option Nat
  value : α
  next  : Option Nat
  deriving Inhabited

structure LinkedList σ α where
  nodes  : ST.Ref σ (Array (Node α))
  free   : ST.Ref σ (Array Nat)
  head   : ST.Ref σ (Option Nat)
  tail   : ST.Ref σ (Option Nat)
  length : ST.Ref σ Nat

def LinkedList.empty : ST σ (LinkedList σ α) := do
  return {
    nodes  := ← ST.mkRef #[],
    free   := ← ST.mkRef #[],
    head   := ← ST.mkRef none,
    tail   := ← ST.mkRef none,
    length := ← ST.mkRef 0
  }

private def buildNode (value : α) (list : LinkedList σ α) : ST σ Nat := do
  let node : Node α := { prev := none, value := value, next := none}
  match (← list.free.get).back? with
  | none =>
    let id := (← list.nodes.get).size
    list.nodes.modify (·.push node)
    return id
  | some id =>
    list.nodes.modify (·.set! id node)
    list.free.modify (·.pop)
    return id

private def LinkedList.unlinkPrev (node : Node α) (list : LinkedList σ α) : ST σ Unit := do
  match node.prev with
  | some p =>
    list.nodes.modify (·.modify p (λ pn => { pn with next := node.next }))
  | none =>
    list.head.set node.next

private def LinkedList.unlinkNext (node : Node α) (list : LinkedList σ α) : ST σ Unit := do
  match node.next with
  | some n =>
    list.nodes.modify (·.modify n (λ np => { np with prev := node.prev }))
  | none =>
    list.tail.set node.prev

private def LinkedList.unlink (node : Node α) (list : LinkedList σ α) : ST σ Unit := do
  list.unlinkPrev node
  list.unlinkNext node

def LinkedList.count (list : LinkedList σ α) : ST σ Nat :=
  list.length.get

def LinkedList.push (value : α) (list : LinkedList σ α) : ST σ Unit := do
  let id ← buildNode value list
  match ← list.tail.get with
  | none =>
    list.head.set (some id)
    list.tail.set (some id)
    list.length.modify (· + 1)
  | some t =>
    list.nodes.modify (λ ns =>
      ns.modify t (λ n => { n with next := some id })
      |>.modify id (λ n => { n with prev := some t })
    )
    list.tail.set (some id)
    list.length.modify (· + 1)

def LinkedList.unshift (value : α) (list : LinkedList σ α) : ST σ Unit := do
  let id ← buildNode value list
  match ← list.head.get with
  | none =>
    list.head.set (some id)
    list.tail.set (some id)
    list.length.modify (· + 1)
  | some h =>
    list.nodes.modify (λ ns =>
      ns.modify h (λ n => { n with prev := some id })
      |>.modify id (λ n => { n with next := some h })
    )
    list.head.set (some id)
    list.length.modify (· + 1)

def LinkedList.pop (list : LinkedList σ α) : ST σ (Option α) := do
  match (← list.length.get) with
  | 0 => return none
  | n + 1 =>
    let id := (← list.tail.get).get!
    let node := (← list.nodes.get)[id]!
    list.unlink node
    list.length.set n
    list.free.modify (·.push id)
    return node.value

def LinkedList.shift (list : LinkedList σ α) : ST σ (Option α) := do
  match (← list.length.get) with
  | 0 => return none
  | n + 1 =>
    let id := (← list.head.get).get!
    let node := (← list.nodes.get)[id]!
    list.unlink node
    list.length.set n
    list.free.modify (·.push id)
    return node.value

def LinkedList.delete (value : α) (list : LinkedList σ α) : ST σ Unit := do
  let mut crtId ← list.head.get
  while crtId.isSome do
    let id := crtId.get!
    let node := (← list.nodes.get)[id]!
    if node.value == value then
      list.unlink node
      list.length.modify (· - 1)
      list.free.modify (·.push id)
      break
    crtId := node.next

end LinkedList
