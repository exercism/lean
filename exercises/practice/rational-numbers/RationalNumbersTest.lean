import LeanTest
import RationalNumbers

open LeanTest

theorem check : ∀ (r : RationalNumbers.RationalNumber), r.den > 0 ∧ Int.gcd r.num r.den = 1 := by
  exact RationalNumbers.RationalNumber.h

def rationalNumbersTests : TestSuite :=
  (TestSuite.empty "RationalNumbers")
    |>.addTest "Arithmetic -> Addition -> Add two positive rational numbers" (do
        return assertEqual ⟨7, 6, by decide⟩ (RationalNumbers.add ⟨1, 2, by decide⟩ ⟨2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Addition -> Add a positive rational number and a negative rational number" (do
        return assertEqual ⟨-1, 6, by decide⟩ (RationalNumbers.add ⟨1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Addition -> Add two negative rational numbers" (do
        return assertEqual ⟨-7, 6, by decide⟩ (RationalNumbers.add ⟨-1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Addition -> Add a rational number to its additive inverse" (do
        return assertEqual ⟨0, 1, by decide⟩ (RationalNumbers.add ⟨1, 2, by decide⟩ ⟨-1, 2, by decide⟩))
    |>.addTest "Arithmetic -> Subtraction -> Subtract two positive rational numbers" (do
        return assertEqual ⟨-1, 6, by decide⟩ (RationalNumbers.sub ⟨1, 2, by decide⟩ ⟨2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Subtraction -> Subtract a positive rational number and a negative rational number" (do
        return assertEqual ⟨7, 6, by decide⟩ (RationalNumbers.sub ⟨1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Subtraction -> Subtract two negative rational numbers" (do
        return assertEqual ⟨1, 6, by decide⟩ (RationalNumbers.sub ⟨-1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Subtraction -> Subtract a rational number from itself" (do
        return assertEqual ⟨0, 1, by decide⟩ (RationalNumbers.sub ⟨1, 2, by decide⟩ ⟨1, 2, by decide⟩))
    |>.addTest "Arithmetic -> Multiplication -> Multiply two positive rational numbers" (do
        return assertEqual ⟨1, 3, by decide⟩ (RationalNumbers.mul ⟨1, 2, by decide⟩ ⟨2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Multiplication -> Multiply a negative rational number by a positive rational number" (do
        return assertEqual ⟨-1, 3, by decide⟩ (RationalNumbers.mul ⟨-1, 2, by decide⟩ ⟨2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Multiplication -> Multiply two negative rational numbers" (do
        return assertEqual ⟨1, 3, by decide⟩ (RationalNumbers.mul ⟨-1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Multiplication -> Multiply a rational number by its reciprocal" (do
        return assertEqual ⟨1, 1, by decide⟩ (RationalNumbers.mul ⟨1, 2, by decide⟩ ⟨2, 1, by decide⟩))
    |>.addTest "Arithmetic -> Multiplication -> Multiply a rational number by 1" (do
        return assertEqual ⟨1, 2, by decide⟩ (RationalNumbers.mul ⟨1, 2, by decide⟩ ⟨1, 1, by decide⟩))
    |>.addTest "Arithmetic -> Multiplication -> Multiply a rational number by 0" (do
        return assertEqual ⟨0, 1, by decide⟩ (RationalNumbers.mul ⟨1, 2, by decide⟩ ⟨0, 1, by decide⟩))
    |>.addTest "Arithmetic -> Division -> Divide two positive rational numbers" (do
        return assertEqual ⟨3, 4, by decide⟩ (RationalNumbers.div ⟨1, 2, by decide⟩ ⟨2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Division -> Divide a positive rational number by a negative rational number" (do
        return assertEqual ⟨-3, 4, by decide⟩ (RationalNumbers.div ⟨1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Division -> Divide two negative rational numbers" (do
        return assertEqual ⟨3, 4, by decide⟩ (RationalNumbers.div ⟨-1, 2, by decide⟩ ⟨-2, 3, by decide⟩))
    |>.addTest "Arithmetic -> Division -> Divide a rational number by 1" (do
        return assertEqual ⟨1, 2, by decide⟩ (RationalNumbers.div ⟨1, 2, by decide⟩ ⟨1, 1, by decide⟩))
    |>.addTest "Absolute value -> Absolute value of a positive rational number" (do
        return assertEqual ⟨1, 2, by decide⟩ (RationalNumbers.abs ⟨1, 2, by decide⟩))
    |>.addTest "Absolute value -> Absolute value of a negative rational number" (do
        return assertEqual ⟨1, 2, by decide⟩ (RationalNumbers.abs ⟨-1, 2, by decide⟩))
    |>.addTest "Absolute value -> Absolute value of zero" (do
        return assertEqual ⟨0, 1, by decide⟩ (RationalNumbers.abs ⟨0, 1, by decide⟩))
    |>.addTest "Exponentiation of a rational number -> Raise a positive rational number to a positive integer power" (do
        return assertEqual ⟨1, 8, by decide⟩ (RationalNumbers.exprational ⟨1, 2, by decide⟩ 3))
    |>.addTest "Exponentiation of a rational number -> Raise a negative rational number to a positive integer power" (do
        return assertEqual ⟨-1, 8, by decide⟩ (RationalNumbers.exprational ⟨-1, 2, by decide⟩ 3))
    |>.addTest "Exponentiation of a rational number -> Raise a positive rational number to a negative integer power" (do
        return assertEqual ⟨25, 9, by decide⟩ (RationalNumbers.exprational ⟨3, 5, by decide⟩ (-2)))
    |>.addTest "Exponentiation of a rational number -> Raise a negative rational number to an even negative integer power" (do
        return assertEqual ⟨25, 9, by decide⟩ (RationalNumbers.exprational ⟨-3, 5, by decide⟩ (-2)))
    |>.addTest "Exponentiation of a rational number -> Raise a negative rational number to an odd negative integer power" (do
        return assertEqual ⟨-125, 27, by decide⟩ (RationalNumbers.exprational ⟨-3, 5, by decide⟩ (-3)))
    |>.addTest "Exponentiation of a rational number -> Raise zero to an integer power" (do
        return assertEqual ⟨0, 1, by decide⟩ (RationalNumbers.exprational ⟨0, 1, by decide⟩ 5))
    |>.addTest "Exponentiation of a rational number -> Raise one to an integer power" (do
        return assertEqual ⟨1, 1, by decide⟩ (RationalNumbers.exprational ⟨1, 1, by decide⟩ 4))
    |>.addTest "Exponentiation of a rational number -> Raise a positive rational number to the power of zero" (do
        return assertEqual ⟨1, 1, by decide⟩ (RationalNumbers.exprational ⟨1, 2, by decide⟩ 0))
    |>.addTest "Exponentiation of a rational number -> Raise a negative rational number to the power of zero" (do
        return assertEqual ⟨1, 1, by decide⟩ (RationalNumbers.exprational ⟨-1, 2, by decide⟩ 0))
    |>.addTest "Exponentiation of a real number to a rational number -> Raise a real number to a positive rational number" (do
        return assertInRange (RationalNumbers.expreal 8 ⟨4, 3, by decide⟩) 15.999000 16.001000)
    |>.addTest "Exponentiation of a real number to a rational number -> Raise a real number to a negative rational number" (do
        return assertInRange (RationalNumbers.expreal 9 ⟨-1, 2, by decide⟩) 0.332333 0.334333)
    |>.addTest "Exponentiation of a real number to a rational number -> Raise a real number to a zero rational number" (do
        return assertInRange (RationalNumbers.expreal 2 ⟨0, 1, by decide⟩) 0.999000 1.001000)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [rationalNumbersTests]
