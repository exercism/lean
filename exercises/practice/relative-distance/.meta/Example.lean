import Std

namespace RelativeDistance

abbrev Name := String
abbrev Relatives := Std.HashSet String
abbrev Parent := String
abbrev Children := List String

partial def traverse (target : Name) (firstDegree : Std.HashMap Name Relatives) (degree : Nat) (seen : Relatives) (layer : Relatives) : Option Nat := do
  if target ∈ layer
  then some degree
  else
    let nextSeen := seen.insertMany layer
    let nextLayer : Relatives := layer.fold (fun m c => m.insertMany $ firstDegree[c]!.filter (λ f => f ∉ nextSeen)) {}
    guard !nextLayer.isEmpty
    traverse target firstDegree (degree + 1) nextSeen nextLayer

def degreeOfSeparation (familyTree : List (Parent × Children)) (personA : String) (personB : String) : Option Nat :=
  let firstDegree : Std.HashMap Name Relatives :=
    familyTree.foldl (fun map (p, cs) =>
      cs.foldl (fun map c =>
        map
          |>.alter p (fun
            | none    => some $ .ofList cs
            | some rs => some $ rs.insertMany cs
          )
          |>.alter c (fun
            | none    => some $ .ofList (p :: cs.erase c)
            | some rs => some $ rs.insertMany (p :: cs.erase c)
          )
      ) map
    ) {}
  let layer : Relatives := firstDegree[personA]!
  traverse personB firstDegree 1 {} layer

end RelativeDistance
