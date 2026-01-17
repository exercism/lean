namespace CryptoSquare

def countAlphanum (plaintext : String) : Nat := Id.run do
  let mut count := 0
  for c in plaintext.toList do
    if Char.isAlphanum c then
      count := count + 1
  return count

def squareRoot (radicand : Nat) : Nat := Id.run do
  for guess in [0:radicand] do
    if guess * guess >= radicand then return guess
  return radicand

def ciphertext (plaintext : String) : String :=
  let length := countAlphanum plaintext
  if length == 0 then ""
  else Id.run do
    let columns := squareRoot length
    let rows := (length + columns - 1) / columns
    let mut chars := Array.replicate ((rows * columns) + columns - 1) ' '
    let mut count := 0
    for c in (String.toLower plaintext).toList do
      if Char.isAlphanum c then
        let index := (count % columns) * (rows + 1) + (count / columns)
        chars := chars.set! index c
        count := count + 1
    return chars.toList.asString

end CryptoSquare
