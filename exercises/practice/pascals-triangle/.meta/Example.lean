namespace PascalsTriangle

structure Triangle where
  private mk ::
  rows : IO.Ref (Array (Array Nat))

def mkTriangle : IO Triangle := do
  return {
    rows := ← IO.mkRef #[ #[], #[1] ]
  }

private def buildRows (triangle : Triangle) (n : Nat) : IO (Array Nat) := do
  let mut crt ← triangle.rows.get
  while n ≥ crt.size do
    let last := crt.back!
    let next := (#[0] ++ last).zipWith (· + ·) (last.push 0)
    crt := crt.push next
  triangle.rows.set crt
  return crt[n]!

end PascalsTriangle

notation triangle "(" n ")" => PascalsTriangle.buildRows triangle n
