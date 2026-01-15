import LeanTest
import RomanNumerals

open LeanTest

def romanNumeralsTests : TestSuite :=
  (TestSuite.empty "RomanNumerals")
  |>.addTest "1 is I" (do
      return assertEqual "I" (RomanNumerals.roman 1))
  |>.addTest "2 is II" (do
      return assertEqual "II" (RomanNumerals.roman 2))
  |>.addTest "3 is III" (do
      return assertEqual "III" (RomanNumerals.roman 3))
  |>.addTest "4 is IV" (do
      return assertEqual "IV" (RomanNumerals.roman 4))
  |>.addTest "5 is V" (do
      return assertEqual "V" (RomanNumerals.roman 5))
  |>.addTest "6 is VI" (do
      return assertEqual "VI" (RomanNumerals.roman 6))
  |>.addTest "9 is IX" (do
      return assertEqual "IX" (RomanNumerals.roman 9))
  |>.addTest "16 is XVI" (do
      return assertEqual "XVI" (RomanNumerals.roman 16))
  |>.addTest "27 is XXVII" (do
      return assertEqual "XXVII" (RomanNumerals.roman 27))
  |>.addTest "48 is XLVIII" (do
      return assertEqual "XLVIII" (RomanNumerals.roman 48))
  |>.addTest "49 is XLIX" (do
      return assertEqual "XLIX" (RomanNumerals.roman 49))
  |>.addTest "59 is LIX" (do
      return assertEqual "LIX" (RomanNumerals.roman 59))
  |>.addTest "66 is LXVI" (do
      return assertEqual "LXVI" (RomanNumerals.roman 66))
  |>.addTest "93 is XCIII" (do
      return assertEqual "XCIII" (RomanNumerals.roman 93))
  |>.addTest "141 is CXLI" (do
      return assertEqual "CXLI" (RomanNumerals.roman 141))
  |>.addTest "163 is CLXIII" (do
      return assertEqual "CLXIII" (RomanNumerals.roman 163))
  |>.addTest "166 is CLXVI" (do
      return assertEqual "CLXVI" (RomanNumerals.roman 166))
  |>.addTest "402 is CDII" (do
      return assertEqual "CDII" (RomanNumerals.roman 402))
  |>.addTest "575 is DLXXV" (do
      return assertEqual "DLXXV" (RomanNumerals.roman 575))
  |>.addTest "666 is DCLXVI" (do
      return assertEqual "DCLXVI" (RomanNumerals.roman 666))
  |>.addTest "911 is CMXI" (do
      return assertEqual "CMXI" (RomanNumerals.roman 911))
  |>.addTest "1024 is MXXIV" (do
      return assertEqual "MXXIV" (RomanNumerals.roman 1024))
  |>.addTest "1666 is MDCLXVI" (do
      return assertEqual "MDCLXVI" (RomanNumerals.roman 1666))
  |>.addTest "3000 is MMM" (do
      return assertEqual "MMM" (RomanNumerals.roman 3000))
  |>.addTest "3001 is MMMI" (do
      return assertEqual "MMMI" (RomanNumerals.roman 3001))
  |>.addTest "3888 is MMMDCCCLXXXVIII" (do
      return assertEqual "MMMDCCCLXXXVIII" (RomanNumerals.roman 3888))
  |>.addTest "3999 is MMMCMXCIX" (do
      return assertEqual "MMMCMXCIX" (RomanNumerals.roman 3999))

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [romanNumeralsTests]
