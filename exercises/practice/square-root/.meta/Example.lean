namespace SquareRoot

def squareRoot (radicand : Nat) : Nat := Id.run do
  for guess in [0:radicand] do
    if guess * guess >= radicand then return guess
  return radicand

end SquareRoot
