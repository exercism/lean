namespace Pangram

def update (seen : UInt32) (c : Char) : UInt32 :=
  if Char.isAlpha c then seen ||| (1 <<< ((c.val ||| 32) - 97))
  else seen

def isPangram (sentence : String) : Bool :=
  0x3ffffff == String.foldl update 0 sentence

end Pangram
