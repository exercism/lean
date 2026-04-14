namespace VariableLengthQuantity

private def mask : Nat := (1 <<< 7) - 1
private def highBit : UInt8 := (1 <<< 7).toUInt8

def encode (integers : Array Nat) : ByteArray :=
  ByteArray.mk (integers.flatMap fun x => Id.run do
    let mut acc := #[]
    let mut num := x
    repeat
      let byte := num &&& mask
      num := num >>> 7
      acc := acc.push (byte.toUInt8 ||| highBit)
    until num == 0
    acc := acc.modify 0 (· &&& (~~~highBit)) -- array reversed, first byte is the last in sequence
    return acc.reverse)

def decode (bytes : ByteArray) : Option (Array Nat) := do
  let mut acc := #[0] -- starts non-empty and pops at the end. Makes bit logic easier
  for byte in bytes do
    let masked := byte.toNat &&& mask
    let last := acc.size - 1
    acc := acc.modify last (fun b => (b <<< 7) ||| masked)
    if (byte &&& highBit) == 0 then acc := acc.push 0
  acc := acc.pop
  guard !acc.isEmpty
  return acc

end VariableLengthQuantity
