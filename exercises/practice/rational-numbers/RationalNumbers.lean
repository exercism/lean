namespace RationalNumbers

/--
  Represents a fully reduced rational number.
  It is constructed from a numerator (`num`) and a denominator (`den`), both of type `Int`, and a proof that: `den > 0 ∧ Int.gcd num den = 1`.
-/
structure RationalNumber where
  num : Int
  den : Int
  h : den > 0 ∧ Int.gcd num den = 1
  deriving BEq, Repr

def add (r1 r2 : RationalNumber) : RationalNumber :=
  sorry --remove this line and implement the function

def sub (r1 r2 : RationalNumber) : RationalNumber :=
  sorry --remove this line and implement the function

def mul (r1 r2 : RationalNumber) : RationalNumber :=
  sorry --remove this line and implement the function

def div (r1 r2 : RationalNumber) : RationalNumber :=
  sorry --remove this line and implement the function

def abs (r : RationalNumber) : RationalNumber :=
  sorry --remove this line and implement the function

def exprational (r : RationalNumber) (n : Int) : RationalNumber :=
  sorry --remove this line and implement the function

def expreal (x : Int) (r : RationalNumber) : Float :=
  sorry --remove this line and implement the function

end RationalNumbers
