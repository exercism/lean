import LeanTest
import ComplexNumbers

open LeanTest

def complexNumbersTests : TestSuite :=
  (TestSuite.empty "ComplexNumbers")
  |>.addTest "Real part -> Real part of a purely real number" (do
      return assertEqual 1 (ComplexNumbers.real ⟨1, 0⟩))
  |>.addTest "Real part -> Real part of a purely imaginary number" (do
      return assertEqual 0 (ComplexNumbers.real ⟨0, 1⟩))
  |>.addTest "Real part -> Real part of a number with real and imaginary part" (do
      return assertEqual 1 (ComplexNumbers.real ⟨1, 2⟩))
  |>.addTest "Imaginary part -> Imaginary part of a purely real number" (do
      return assertEqual 0 (ComplexNumbers.imaginary ⟨1, 0⟩))
  |>.addTest "Imaginary part -> Imaginary part of a purely imaginary number" (do
      return assertEqual 1 (ComplexNumbers.imaginary ⟨0, 1⟩))
  |>.addTest "Imaginary part -> Imaginary part of a number with real and imaginary part" (do
      return assertEqual 2 (ComplexNumbers.imaginary ⟨1, 2⟩))
  |>.addTest "Imaginary unit" (do
      return assertEqual ⟨-1, 0⟩ (ComplexNumbers.mul ⟨0, 1⟩ ⟨0, 1⟩))
  |>.addTest "Arithmetic -> Addition -> Add purely real numbers" (do
      return assertEqual ⟨3, 0⟩ (ComplexNumbers.add ⟨1, 0⟩ ⟨2, 0⟩))
  |>.addTest "Arithmetic -> Addition -> Add purely imaginary numbers" (do
      return assertEqual ⟨0, 3⟩ (ComplexNumbers.add ⟨0, 1⟩ ⟨0, 2⟩))
  |>.addTest "Arithmetic -> Addition -> Add numbers with real and imaginary part" (do
      return assertEqual ⟨4, 6⟩ (ComplexNumbers.add ⟨1, 2⟩ ⟨3, 4⟩))
  |>.addTest "Arithmetic -> Subtraction -> Subtract purely real numbers" (do
      return assertEqual ⟨-1, 0⟩ (ComplexNumbers.sub ⟨1, 0⟩ ⟨2, 0⟩))
  |>.addTest "Arithmetic -> Subtraction -> Subtract purely imaginary numbers" (do
      return assertEqual ⟨0, -1⟩ (ComplexNumbers.sub ⟨0, 1⟩ ⟨0, 2⟩))
  |>.addTest "Arithmetic -> Subtraction -> Subtract numbers with real and imaginary part" (do
      return assertEqual ⟨-2, -2⟩ (ComplexNumbers.sub ⟨1, 2⟩ ⟨3, 4⟩))
  |>.addTest "Arithmetic -> Multiplication -> Multiply purely real numbers" (do
      return assertEqual ⟨2, 0⟩ (ComplexNumbers.mul ⟨1, 0⟩ ⟨2, 0⟩))
  |>.addTest "Arithmetic -> Multiplication -> Multiply purely imaginary numbers" (do
      return assertEqual ⟨-2, 0⟩ (ComplexNumbers.mul ⟨0, 1⟩ ⟨0, 2⟩))
  |>.addTest "Arithmetic -> Multiplication -> Multiply numbers with real and imaginary part" (do
      return assertEqual ⟨-5, 10⟩ (ComplexNumbers.mul ⟨1, 2⟩ ⟨3, 4⟩))
  |>.addTest "Arithmetic -> Division -> Divide purely real numbers" (do
      return assertEqual ⟨0.5, 0⟩ (ComplexNumbers.div ⟨1, 0⟩ ⟨2, 0⟩))
  |>.addTest "Arithmetic -> Division -> Divide purely imaginary numbers" (do
      return assertEqual ⟨0.5, 0⟩ (ComplexNumbers.div ⟨0, 1⟩ ⟨0, 2⟩))
  |>.addTest "Arithmetic -> Division -> Divide numbers with real and imaginary part" (do
      return assertEqual ⟨0.44, 0.08⟩ (ComplexNumbers.div ⟨1, 2⟩ ⟨3, 4⟩))
  |>.addTest "Absolute value -> Absolute value of a positive purely real number" (do
      return assertEqual 5 (ComplexNumbers.abs ⟨5, 0⟩))
  |>.addTest "Absolute value -> Absolute value of a negative purely real number" (do
      return assertEqual 5 (ComplexNumbers.abs ⟨-5, 0⟩))
  |>.addTest "Absolute value -> Absolute value of a purely imaginary number with positive imaginary part" (do
      return assertEqual 5 (ComplexNumbers.abs ⟨0, 5⟩))
  |>.addTest "Absolute value -> Absolute value of a purely imaginary number with negative imaginary part" (do
      return assertEqual 5 (ComplexNumbers.abs ⟨0, -5⟩))
  |>.addTest "Absolute value -> Absolute value of a number with real and imaginary part" (do
      return assertEqual 5 (ComplexNumbers.abs ⟨3, 4⟩))
  |>.addTest "Complex conjugate -> Conjugate a purely real number" (do
      return assertEqual ⟨5, 0⟩ (ComplexNumbers.conjugate ⟨5, 0⟩))
  |>.addTest "Complex conjugate -> Conjugate a purely imaginary number" (do
      return assertEqual ⟨0, -5⟩ (ComplexNumbers.conjugate ⟨0, 5⟩))
  |>.addTest "Complex conjugate -> Conjugate a number with real and imaginary part" (do
      return assertEqual ⟨1, -1⟩ (ComplexNumbers.conjugate ⟨1, 1⟩))
  |>.addTest "Complex exponential function -> Euler's identity/formula" (do
      return assertEqual ⟨-1, 0⟩ (ComplexNumbers.exp ⟨0, 3.14159265359⟩))
  |>.addTest "Complex exponential function -> Exponential of 0" (do
      return assertEqual ⟨1, 0⟩ (ComplexNumbers.exp ⟨0, 0⟩))
  |>.addTest "Complex exponential function -> Exponential of a purely real number" (do
      return assertEqual ⟨2.71828182845, 0⟩ (ComplexNumbers.exp ⟨1, 0⟩))
  |>.addTest "Complex exponential function -> Exponential of a number with real and imaginary part" (do
      return assertEqual ⟨-2, 0⟩ (ComplexNumbers.exp ⟨(Float.log 2), 3.14159265359⟩))
  |>.addTest "Complex exponential function -> Exponential resulting in a number with real and imaginary part" (do
      return assertEqual ⟨1, 1⟩ (ComplexNumbers.exp ⟨(Float.log 2)/2, 3.14159265359/4⟩))
  |>.addTest "Operations between real numbers and complex numbers -> Add real number to complex number" (do
      return assertEqual ⟨6, 2⟩ (ComplexNumbers.add ⟨1, 2⟩ 5))
  |>.addTest "Operations between real numbers and complex numbers -> Add complex number to real number" (do
      return assertEqual ⟨6, 2⟩ (ComplexNumbers.add 5 ⟨1, 2⟩))
  |>.addTest "Operations between real numbers and complex numbers -> Subtract real number from complex number" (do
      return assertEqual ⟨1, 7⟩ (ComplexNumbers.sub ⟨5, 7⟩ 4))
  |>.addTest "Operations between real numbers and complex numbers -> Subtract complex number from real number" (do
      return assertEqual ⟨-1, -7⟩ (ComplexNumbers.sub 4 ⟨5, 7⟩))
  |>.addTest "Operations between real numbers and complex numbers -> Multiply complex number by real number" (do
      return assertEqual ⟨10, 25⟩ (ComplexNumbers.mul ⟨2, 5⟩ 5))
  |>.addTest "Operations between real numbers and complex numbers -> Multiply real number by complex number" (do
      return assertEqual ⟨10, 25⟩ (ComplexNumbers.mul 5 ⟨2, 5⟩))
  |>.addTest "Operations between real numbers and complex numbers -> Divide complex number by real number" (do
      return assertEqual ⟨1, 10⟩ (ComplexNumbers.div ⟨10, 100⟩ 10))
  |>.addTest "Operations between real numbers and complex numbers -> Divide real number by complex number" (do
      return assertEqual ⟨2.5, -2.5⟩ (ComplexNumbers.div 5 ⟨1, 1⟩))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [complexNumbersTests]
