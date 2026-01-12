namespace Matrix

def row (xs : String) (n : Nat) : List Nat :=
  let matrix := xs.splitOn "\n" |> List.map (·.splitOn " ")
  matrix.drop (n - 1) |> List.head! |> (·.map String.toNat!)

def column (xs : String) (n : Nat) : List Nat :=
  let matrix := xs.splitOn "\n" |> List.map (·.splitOn " ")
  matrix.map (·.drop (n - 1) |> List.head! |> String.toNat!)

end Matrix
