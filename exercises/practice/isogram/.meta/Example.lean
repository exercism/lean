namespace Isogram

def popCount (acc : Nat) (number : Nat) : Nat :=
  if number > 0 then popCount (acc + (number &&& 1)) (number >>> 1)
  else acc

def letterSet (letters : List Char) : Nat :=
  List.foldl (fun (seen : Nat) (c : Char) => seen ||| (1 <<< (c.val.toNat - 97))) 0 letters

def isIsogram (phrase : String) : Bool :=
  let letters := (String.toLower phrase).toList.filter Char.isAlpha
  List.length letters == popCount 0 (letterSet letters)

end Isogram
