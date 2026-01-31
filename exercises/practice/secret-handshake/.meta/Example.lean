namespace SecretHandshake

inductive Action where
  | wink
  | doubleBlink
  | closeYourEyes
  | jump
  deriving BEq, Repr

def allActions : Array Action := #[.wink, .doubleBlink, .closeYourEyes, .jump]

def actionBit : Action -> BitVec 5
  | .wink          => 0b00001
  | .doubleBlink   => 0b00010
  | .closeYourEyes => 0b00100
  | .jump          => 0b01000

def reverseBit : BitVec 5 := 0b10000

def commands (number : BitVec 5) : Array Action :=
  let actions := allActions.filter (λ a => actionBit a &&& number ≠ 0)
  if number &&& reverseBit ≠ 0 then actions.reverse else actions

end SecretHandshake
