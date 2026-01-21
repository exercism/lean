namespace GameOfLife

def countNeighbors (x : Nat) (y : Nat) (matrix : Array (Array Bool)) : Nat :=
  let (dxs, dys) := match x, y with
    | 0, 0           => ((x...=x+1), (y...=y+1))
    | 0, ny + 1      => ((x...=x+1), (ny...=y+1))
    | nx + 1, 0      => ((nx...=x+1), (y...=y+1))
    | nx + 1, ny + 1 => ((nx...=x+1), (ny...=y+1))
  dxs.toList.foldr (fun i1 => dys.toList.foldr (fun i2 is => is.push (i1, i2))) #[]
  |> (·.filterMap (fun (ox, oy) => if ox == x && oy == y then none else matrix[ox]? >>= (·[oy]?)))
  |> (·.count true)

def tick (matrix : Array (Array Bool)) : Array (Array Bool) :=
  matrix.mapIdx (fun x row => row.mapIdx (fun y e =>
    match countNeighbors x y matrix with
    | 3 => true
    | 2 => e
    | _ => false
  ))

end GameOfLife
