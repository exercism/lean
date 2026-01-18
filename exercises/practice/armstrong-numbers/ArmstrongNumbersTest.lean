import LeanTest
import ArmstrongNumbers

open LeanTest

def armstrongNumbersTests : TestSuite :=
  (TestSuite.empty "ArmstrongNumbers")
  |>.addTest "Zero is an Armstrong number" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 0))
  |>.addTest "Single-digit numbers are Armstrong numbers" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 5))
  |>.addTest "There are no two-digit Armstrong numbers" (do
      return assertEqual false (ArmstrongNumbers.isArmstrongNumber 10))
  |>.addTest "Three-digit number that is an Armstrong number" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 153))
  |>.addTest "Three-digit number that is not an Armstrong number" (do
      return assertEqual false (ArmstrongNumbers.isArmstrongNumber 100))
  |>.addTest "Four-digit number that is an Armstrong number" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 9474))
  |>.addTest "Four-digit number that is not an Armstrong number" (do
      return assertEqual false (ArmstrongNumbers.isArmstrongNumber 9475))
  |>.addTest "Seven-digit number that is an Armstrong number" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 9926315))
  |>.addTest "Seven-digit number that is not an Armstrong number" (do
      return assertEqual false (ArmstrongNumbers.isArmstrongNumber 9926314))
  |>.addTest "Armstrong number containing seven zeroes" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 186709961001538790100634132976990))
  |>.addTest "The largest and last Armstrong number" (do
      return assertEqual true (ArmstrongNumbers.isArmstrongNumber 115132219018763992565095597973971522401))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [armstrongNumbersTests]
