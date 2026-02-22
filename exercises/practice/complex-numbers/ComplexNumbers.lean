namespace ComplexNumbers

structure ComplexNumber where
  real : Float
  imag : Float
  deriving Repr

/- define how a complex number should be constructed out of a literal number -/
instance {n : Nat} : OfNat ComplexNumber n where
  ofNat :=
    sorry --remove this line and implement the function

def real (z : ComplexNumber) : Float :=
  sorry --remove this line and implement the function

def imaginary (z : ComplexNumber) : Float :=
  sorry --remove this line and implement the function

def mul (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry --remove this line and implement the function

def div (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry --remove this line and implement the function

def sub (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry --remove this line and implement the function

def add (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry --remove this line and implement the function

def abs (z : ComplexNumber) : Float :=
  sorry --remove this line and implement the function

def conjugate (z : ComplexNumber) : ComplexNumber :=
  sorry --remove this line and implement the function

def exp (z : ComplexNumber) : ComplexNumber :=
  sorry --remove this line and implement the function

end ComplexNumbers
