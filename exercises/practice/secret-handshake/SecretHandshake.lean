namespace SecretHandshake

inductive Action where
  | wink
  | doubleBlink
  | closeYourEyes
  | jump
  deriving BEq, Repr

def commands (number : BitVec 5) : Array Action :=
  sorry

end SecretHandshake
