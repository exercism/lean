namespace DifferenceOfSquares

def square (number : Nat) : Nat :=
  number * number

def sum (number : Nat) : Nat :=
  number * (number + 1) / 2

def squareOfSum (number : Nat) : Nat :=
  square (sum number)

def sumOfSquares (number : Nat) : Nat :=
  number * (number + 1) * (2 * number + 1) / 6

def differenceOfSquares (number : Nat) : Nat :=
  (squareOfSum number) - (sumOfSquares number)

end DifferenceOfSquares
