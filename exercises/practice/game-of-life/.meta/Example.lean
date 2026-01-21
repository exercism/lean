namespace GameOfLife

/-
  The neighbors of a cell at (x, y) are at (x - 1, y - 1) ... (x + 1, y + 1)
  But those values might be out of bounds. So this exercise is all about bounds checking.

  The main idea here is to use arr[idx]? to automate this check.
  It returns an Option where an invalid index would result in none.

  However, idx must be a Nat and in Lean 0 - 1 == 0. Even making a round trip from Int won't solve this.
  One way to approach the problem is do the lower half of bounds checking manually. This is what `getBounds` do.
  Another way would be to erase duplicates coordinates by using, for example, List.removeDup.

  The notation (a...=b) is a Std.Rcc, a type of Range inclusive in both a and b.
  It is roughly equivalent to [a:b+1], but [x:y] only works with natural numbers and is exclusive on y.
-/
def getBounds (x : Nat) (y : Nat) : List Nat × List Nat :=
  let (dxs, dys) := match x, y with
    | 0, 0           => (x...=x+1, y...=y+1)
    | 0, ny + 1      => (x...=x+1, ny...=y+1)
    | nx + 1, 0      => (nx...=x+1, y...=y+1)
    | nx + 1, ny + 1 => (nx...=x+1, ny...=y+1)
  (dxs.toList, dys.toList)

/-
  Bounds are transformed to an Array of coordinates
-/
def getNeighbors (x : Nat) (y : Nat) : Array (Nat × Nat) :=
  let (dxs, dys) := getBounds x y
  dxs.foldr (fun i1 => dys.foldr (fun i2 is => is.push (i1, i2))) #[]

/-
  This removes the original (x, y) from the neighbors and performs upper bound checking

  The notation >>= is equivalent to monadic bind. For an Option, `x >>= f` is equivalent to:

  ```
  match x with
  | none => none
  | some v => some (f v)
  ```
-/
def getValidNeighbors (x : Nat) (y : Nat) (matrix : Array (Array Bool)) : Array Bool :=
  let neighbors := getNeighbors x y
  neighbors.filterMap (fun (ox, oy) => if ox == x && oy == y then none else matrix[ox]? >>= (·[oy]?))

def countLiveNeighbors (x : Nat) (y : Nat) (matrix : Array (Array Bool)) : Nat :=
  getValidNeighbors x y matrix
  |> (·.count true)

def tick (matrix : Array (Array Bool)) : Array (Array Bool) :=
  matrix.mapIdx (fun x row => row.mapIdx (fun y e =>
    match countLiveNeighbors x y matrix with
    | 3 => true
    | 2 => e
    | _ => false
  ))

end GameOfLife
