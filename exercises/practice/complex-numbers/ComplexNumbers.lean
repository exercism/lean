namespace ComplexNumbers

structure ComplexNumber where
  real : Float
  imag : Float
  deriving Repr

/- define equality between two complex numbers -/
instance : BEq ComplexNumber where
  beq x y := sorry

/- define how a complex number should be constructed out of a literal number -/
instance {n : Nat} : OfNat ComplexNumber n where
  ofNat := sorry

def real (z : ComplexNumber) : Float :=
  sorry

def imaginary (z : ComplexNumber) : Float :=
  sorry

def mul (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry

def div (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry

def sub (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry

def add (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  sorry

def abs (z : ComplexNumber) : Float :=
  sorry

def conjugate (z : ComplexNumber) : ComplexNumber :=
  sorry

def exp (z : ComplexNumber) : ComplexNumber :=
  sorry

end ComplexNumbers
