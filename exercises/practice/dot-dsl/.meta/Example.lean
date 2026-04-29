import Extra
import Std.Data.TreeSet
import Std.Data.HashMap

declare_syntax_cat graph_attr
syntax (name := graphAttr) "[" ident "=" term "]" : graph_attr

declare_syntax_cat graph_node
syntax (name := graphNode) ident : graph_node
syntax (name := graphNodeAttr) ident graph_attr : graph_node

declare_syntax_cat graph_edge
syntax (name := graphEdge) graphNode "-" graphNode ("-" graphNode)* : graph_edge
syntax (name := graphEdgeAttr) graphNode "-" graphNode ("-" graphNode)* graph_attr : graph_edge

declare_syntax_cat graph_comment
syntax (name := cStyleComment) "//" term* : graph_comment
syntax (name := shellStyleComment) "#" term* : graph_comment

declare_syntax_cat graph_line
syntax (name := graphLineAttr) graph_attr ";" : graph_line
syntax (name := graphLineNode) graph_node ";" : graph_line
syntax (name := graphLineEdge) graph_edge ";" : graph_line
syntax (name := graphLineComment) graph_comment ";" : graph_line

syntax (name := graphTree) "graph" "{" graph_line* "}" : term

namespace Extra

private def merge {α : Type v} {β : Type u} [BEq β] [Hashable β]
  (items : Array α)
  (getInsertKeys : α → Array β)
  (getLookupKey : α → β)
  (getAttrs : α -> Array Extra.Attribute)
  (setAttrs : α → Array Extra.Attribute → α)
  : Array α :=
  let (_, result) : Std.HashMap β Nat × Array α := items.foldl (init := ({}, #[])) fun (map, acc) item =>
    let key := getLookupKey item
    if h: key ∈ map then
      let idx := map[key]
      if h: idx < acc.size then
        let seen := acc[idx]
        let seenAttrs := getAttrs seen
        let newAttrs := (getAttrs item).foldl (init := seenAttrs) fun acc { property, value } =>
          match seenAttrs.findIdx? (fun attr => attr.property == property) with
          | some i => acc.modify i (fun attr => { attr with value := value })
          | none   => acc.push { property, value }
        (map, acc.modify idx (setAttrs · newAttrs))
      else (map, acc)
    else
      let insertKeys := getInsertKeys item
      let newMap := map.insertMany (insertKeys.map fun key => (key, acc.size))
      (newMap, acc.push item)
  result

private def Tree.dedup (tree : Extra.Tree) : Extra.Tree :=
  let validNodes := Extra.merge
    (items := tree.nodes)
    (getInsertKeys := fun { name, .. } => #[name])
    (getLookupKey := fun { name, .. } => name)
    (getAttrs := fun { attrs, .. } => attrs)
    (setAttrs := fun node attrs => { node with attrs := attrs })

  let validEdges := Extra.merge
    (items := tree.edges)
    (getInsertKeys := fun { node₁, node₂, .. } => #[(node₁.name, node₂.name), (node₂.name, node₁.name)])
    (getLookupKey := fun { node₁, node₂, .. } => (node₁.name, node₂.name))
    (getAttrs := fun { attrs, .. } => attrs)
    (setAttrs := fun edge attrs => { edge with attrs := attrs })

  { tree with nodes := validNodes, edges := validEdges }

private def Tree.sort (tree : Extra.Tree) : Extra.Tree := {
  nodes := tree.nodes.qsort fun n₁ n₂ => n₁.name < n₂.name
  edges := tree.edges.qsort (fun e₁ e₂ =>
    if e₁.node₁.name == e₂.node₁.name then
      e₁.node₂.name < e₂.node₂.name
    else e₁.node₁.name < e₂.node₁.name
  )
  attrs := tree.attrs.qsort fun a₁ a₂ => a₁.property < a₂.property
}

end Extra

namespace DotDsl

abbrev TIdent := Lean.TSyntax `ident
abbrev TAttr := Lean.TSyntax `graph_attr
abbrev TNode := Lean.TSyntax `graph_node
abbrev TEdge := Lean.TSyntax `graph_edge
abbrev TTerm := Lean.TSyntax `term

private def getAttribute : TAttr → Lean.MacroM TTerm
  | `(graphAttr| [ $name = $value ]) => do
    let nm := Lean.Syntax.mkStrLit name.getId.toString
    let vl ← (do match value with
      | `($n:num) => return Lean.Syntax.mkStrLit s!"{n.getNat}"
      | `(- $n:num) => return Lean.Syntax.mkStrLit s!"-{n.getNat}"
      | `($i:ident) => return Lean.Syntax.mkStrLit i.getId.toString
      | `($s:str) => return s
      | _ => Lean.Macro.throwUnsupported)
    `(({ property := $nm, value := $vl } : Extra.Attribute))
  | _ => Lean.Macro.throwUnsupported

private def identToNode : TIdent → Lean.MacroM TTerm
  | `(ident| $name) => do
    let nm := Lean.Syntax.mkStrLit name.getId.toString
    `(({ name := $nm, attrs := #[] } : Extra.Node))

private def getNode : TNode → Lean.MacroM TTerm
  | `(graphNode| $name) => identToNode name
  | `(graphNodeAttr| $name $attr) => do
    let nd ← identToNode name
    let att ← getAttribute attr
    `(({ $nd with attrs := #[$att] } : Extra.Node))
  | _ => Lean.Macro.throwUnsupported

private def getPairs (nodes : Array TTerm) : Array (TTerm × TTerm) := Id.run do
  let mut acc := #[]
  if h: 0 < nodes.size then
    let mut prev := nodes[0]
    for h: i in [1:nodes.size] do
      let crt := nodes[i]
      acc := acc.push (prev, crt)
      prev := crt
  return acc

private def generateEdge (n₁ n₂ : TIdent) (nₛ : Array TIdent) (attr : Option TAttr) : Lean.MacroM (TTerm × TTerm) := do
  let nodes ← (#[n₁, n₂] ++ nₛ).mapM identToNode
  let nodeArr ← `(#[$[$nodes],*])
  let pairs := getPairs nodes
  let attrArr ← match attr with
    | none => `(#[])
    | some attr => let att ← getAttribute attr; `(#[$att])
  let edgeTerms ← pairs.mapM fun (a, b) =>
    `(({ node₁ := $a, node₂ := $b, attrs := $attrArr } : Extra.Edge))
  let edgeArr ← `(#[$[$edgeTerms],*])
  return (nodeArr, edgeArr)

private def getEdge : TEdge → Lean.MacroM (TTerm × TTerm)
  | `(graphEdgeAttr| $n₁ - $n₂ $[- $nₛ]* $attr) => generateEdge n₁ n₂ nₛ (some attr)
  | `(graphEdge| $n₁ - $n₂ $[- $nₛ]* ) => generateEdge n₁ n₂ nₛ none
  | _ => Lean.Macro.throwUnsupported

macro_rules
  | `(graphTree| graph { $lines:graph_line* }) => do
    let mut tree ← `(({
      nodes := #[],
      edges := #[],
      attrs := #[]
    } : Extra.Tree))

    for line in lines do
      match line with
      | `(graphLineEdge| $edge ;) =>
        let (nds, edg) ← getEdge edge
        tree ← `(({ $tree with nodes := ($tree).nodes ++ $nds, edges := ($tree).edges ++ $edg }))
      | `(graphLineAttr| $attr ;) =>
        let att ← getAttribute attr
        tree ← `(({ $tree with attrs := ($tree).attrs.push $att }))
      | `(graphLineNode| $node ;) =>
        let nd ← getNode node
        tree ← `(({ $tree with nodes := ($tree).nodes.push $nd }))
      | `(graphLineComment| $_comment ;) => continue
      | _ => Lean.Macro.throwUnsupported

    `((Extra.Tree.sort $ Extra.Tree.dedup $tree))

end DotDsl
