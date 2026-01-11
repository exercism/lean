namespace AffineCipher

def clean (phrase : String) : List Char :=
  (String.toLower phrase).toList.filter Char.isAlphanum

def process (phrase : String) (a : Nat) (b : Nat) : List Char :=
  let helper := fun (c : Char) =>
    if Char.isDigit c then c
    else Char.ofNat ((a * (c.val.toNat - 97) + b) % 26 + 97)
  List.map helper (clean phrase)

def chunk (list : List Char) : List Char :=
  match list with
  | a :: b :: c :: d :: e :: f :: rest => a :: b :: c :: d :: e :: ' ' :: (chunk (f :: rest))
  | _ => list

def inverse(a : Nat) : Option Nat :=
  let inverses : Array (Option Nat) := #[
    none,
    some 1,
    none,
    some 9,
    none,
    some 21,
    none,
    some 15,
    none,
    some 3,
    none,
    some 19,
    none,
    none,
    none,
    some 7,
    none,
    some 23,
    none,
    some 11,
    none,
    some 5,
    none,
    some 17,
    none,
    some 25
  ]
  inverses[a % 26]!

def encode (phrase : String) (a : Nat) (b : Nat) : Option String :=
  match inverse a with
  | none => none
  | some _ => some (chunk (process phrase a b)).asString

def decode (phrase : String) (a : Nat) (b : Nat) : Option String :=
  match inverse a with
  | none => none
  | some inv => some (process phrase inv ((26 - inv) * b)).asString

end AffineCipher
