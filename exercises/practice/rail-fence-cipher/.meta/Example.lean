namespace RailFenceCipher

def Positive := { x : Nat // x > 0 }

def railLengths (rails : Positive) (n : Nat) : Array Nat := Id.run do
  let mut lengths := Array.replicate rails.val (0 : Nat)
  let mut rail : Nat := 0
  let mut direction : Int := if rails.val = 1 then 0 else 1
  for _ in [0:n] do
    let length := lengths[rail]! + 1
    lengths := lengths.set! rail length
    rail := ((Int.ofNat rail) + direction).toNat
    direction := if ((rail > 0) && (rail + 1 < rails.val)) then direction else -direction
  lengths

def railOffsets (rails : Positive) (n : Nat) : Array Nat := Id.run do
  let lengths := railLengths rails n
  let mut offsets := Array.replicate rails.val (0 : Nat)
  let mut acc := 0
  for rail in [0:rails.val] do
    offsets := offsets.set! rail acc
    acc := acc + lengths[rail]!
  offsets

def process (rails : Positive) (msg : String) (isDecode: Bool) : String := Id.run do
  let input := List.toArray (String.toList msg)
  let n := input.size
  let mut output := Array.replicate n (' ' : Char)
  let mut offsets := railOffsets rails n
  let mut rail : Nat := 0
  let mut direction : Int := if rails.val = 1 then 0 else 1
  for i in [0:n] do
    let offset := offsets[rail]!
    offsets := offsets.set! rail (offset + 1)
    rail := ((Int.ofNat rail) + direction).toNat
    direction := if ((rail > 0) && (rail + 1 < rails.val)) then direction else -direction
    output := if isDecode then output.set! i input[offset]! else output.set! offset input[i]!
  (Array.toList output).asString

def encode (rails : Positive) (msg : String) : String :=
  process rails msg false

def decode (rails : Positive) (msg : String) : String :=
  process rails msg true

end RailFenceCipher
