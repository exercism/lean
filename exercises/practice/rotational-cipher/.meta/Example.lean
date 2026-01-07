namespace RotationalCipher

def rotateAlpha (shiftKey : UInt32) (c : Char) : Char :=
  Char.ofNat ((((c.val &&& 95) - 65 + shiftKey) % 26 + 65) ||| (c.val &&& 32)).toNat

def rotate (shiftKey : UInt32) (text : String) : String :=
  String.map (fun c => if Char.isAlpha c then rotateAlpha shiftKey c else c) text

end RotationalCipher
