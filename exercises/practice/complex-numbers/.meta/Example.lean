namespace ComplexNumbers

structure ComplexNumber where
  real : Float
  imag : Float
  deriving Repr

/- define equality between two complex numbers -/
instance : BEq ComplexNumber where
  beq x y := Float.abs (x.real - y.real) <= 0.001 &&
             Float.abs (x.imag - y.imag) <= 0.001

/- define how a complex number should be constructed out of a literal number -/
instance {n : Nat} : OfNat ComplexNumber n where
  ofNat := { real := n.toFloat, imag := 0.0 }

def real (z : ComplexNumber) : Float :=
  z.real

def imaginary (z : ComplexNumber) : Float :=
  z.imag

def mul (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  { real := z1.real * z2.real - z1.imag * z2.imag,
    imag := z1.imag * z2.real + z1.real * z2.imag }

def div (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  let square := z2.real ^ 2 + z2.imag ^ 2
  { real := (z1.real * z2.real + z1.imag * z2.imag) / square,
    imag := (z1.imag * z2.real - z1.real * z2.imag) / square }

def sub (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  { real := z1.real - z2.real, imag := z1.imag - z2.imag }

def add (z1 : ComplexNumber) (z2 : ComplexNumber) : ComplexNumber :=
  { real := z1.real + z2.real, imag := z1.imag + z2.imag }

def abs (z : ComplexNumber) : Float :=
  Float.sqrt (z.real ^ 2 + z.imag ^ 2)

def conjugate (z : ComplexNumber) : ComplexNumber :=
  { z with imag := -z.imag }

def exp (z : ComplexNumber) : ComplexNumber :=
  let expReal := Float.exp z.real
  { real := expReal * Float.cos z.imag,
    imag := expReal * Float.sin z.imag }

end ComplexNumbers
