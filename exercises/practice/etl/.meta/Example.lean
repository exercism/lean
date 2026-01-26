import Std

namespace Etl

def transform (legacy : Std.HashMap Nat (List Char)) : Std.HashMap Char Nat :=
  legacy.toList.flatMap (λ (k, vs) => vs.map (λ v => (v.toLower, k)))
  |> .ofList

end Etl
