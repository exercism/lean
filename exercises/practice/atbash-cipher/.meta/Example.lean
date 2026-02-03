namespace AtbashCipher

def clean (phrase : String) : List Char :=
  (String.toLower phrase).toList.filter Char.isAlphanum

def process (phrase : String) : List Char :=
  let helper := fun (c : Char) =>
    if Char.isDigit c then c
    else Char.ofNat (219 - c.val.toNat)
  List.map helper (clean phrase)

def chunk (list : List Char) : List Char :=
  match list with
  | a :: b :: c :: d :: e :: f :: rest => a :: b :: c :: d :: e :: ' ' :: (chunk (f :: rest))
  | _ => list

def encode (phrase : String) : String :=
  (chunk (process phrase)).asString

def decode (phrase : String) : String :=
  (process phrase).asString

end AtbashCipher
