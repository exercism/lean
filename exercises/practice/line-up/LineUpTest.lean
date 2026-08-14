import LeanTest
import LineUp

open LeanTest

def lineUpTests : TestSuite :=
  (TestSuite.empty "LineUp")
  |>.addTest "format smallest non-exceptional ordinal numeral 4" (do
      return assertEqual "Gianna, you are the 4th customer we serve today. Thank you!"
          (LineUp.format "Gianna" 4))
  |>.addTest "format greatest single digit non-exceptional ordinal numeral 9" (do
      return assertEqual "Maarten, you are the 9th customer we serve today. Thank you!"
          (LineUp.format "Maarten" 9))
  |>.addTest "format non-exceptional ordinal numeral 5" (do
      return assertEqual "Petronila, you are the 5th customer we serve today. Thank you!"
          (LineUp.format "Petronila" 5))
  |>.addTest "format non-exceptional ordinal numeral 6" (do
      return assertEqual "Attakullakulla, you are the 6th customer we serve today. Thank you!"
          (LineUp.format "Attakullakulla" 6))
  |>.addTest "format non-exceptional ordinal numeral 7" (do
      return assertEqual "Kate, you are the 7th customer we serve today. Thank you!"
          (LineUp.format "Kate" 7))
  |>.addTest "format non-exceptional ordinal numeral 8" (do
      return assertEqual "Maximiliano, you are the 8th customer we serve today. Thank you!"
          (LineUp.format "Maximiliano" 8))
  |>.addTest "format exceptional ordinal numeral 1" (do
      return assertEqual "Mary, you are the 1st customer we serve today. Thank you!"
          (LineUp.format "Mary" 1))
  |>.addTest "format exceptional ordinal numeral 2" (do
      return assertEqual "Haruto, you are the 2nd customer we serve today. Thank you!"
          (LineUp.format "Haruto" 2))
  |>.addTest "format exceptional ordinal numeral 3" (do
      return assertEqual "Henriette, you are the 3rd customer we serve today. Thank you!"
          (LineUp.format "Henriette" 3))
  |>.addTest "format smallest two digit non-exceptional ordinal numeral 10" (do
      return assertEqual "Alvarez, you are the 10th customer we serve today. Thank you!"
          (LineUp.format "Alvarez" 10))
  |>.addTest "format non-exceptional ordinal numeral 11" (do
      return assertEqual "Jacqueline, you are the 11th customer we serve today. Thank you!"
          (LineUp.format "Jacqueline" 11))
  |>.addTest "format non-exceptional ordinal numeral 12" (do
      return assertEqual "Juan, you are the 12th customer we serve today. Thank you!"
          (LineUp.format "Juan" 12))
  |>.addTest "format non-exceptional ordinal numeral 13" (do
      return assertEqual "Patricia, you are the 13th customer we serve today. Thank you!"
          (LineUp.format "Patricia" 13))
  |>.addTest "format exceptional ordinal numeral 21" (do
      return assertEqual "Washi, you are the 21st customer we serve today. Thank you!"
          (LineUp.format "Washi" 21))
  |>.addTest "format exceptional ordinal numeral 22 ending in nd even though it is a multiple of 11" (do
      return assertEqual "Ingrid, you are the 22nd customer we serve today. Thank you!"
          (LineUp.format "Ingrid" 22))
  |>.addTest "format exceptional ordinal numeral 33 ending in rd even though it is a multiple of 11" (do
      return assertEqual "Mario, you are the 33rd customer we serve today. Thank you!"
          (LineUp.format "Mario" 33))
  |>.addTest "format exceptional ordinal numeral 52 ending in nd even though it is a multiple of 13" (do
      return assertEqual "Quentin, you are the 52nd customer we serve today. Thank you!"
          (LineUp.format "Quentin" 52))
  |>.addTest "format exceptional ordinal numeral 62" (do
      return assertEqual "Nayra, you are the 62nd customer we serve today. Thank you!"
          (LineUp.format "Nayra" 62))
  |>.addTest "format non-exceptional ordinal numeral 72 ending in nd even though it is a multiple of 12" (do
      return assertEqual "Ugo, you are the 72nd customer we serve today. Thank you!"
          (LineUp.format "Ugo" 72))
  |>.addTest "format exceptional ordinal numeral 91 ending in st even though it is a multiple of 13" (do
      return assertEqual "Boris, you are the 91st customer we serve today. Thank you!"
          (LineUp.format "Boris" 91))
  |>.addTest "format exceptional ordinal numeral 100" (do
      return assertEqual "John, you are the 100th customer we serve today. Thank you!"
          (LineUp.format "John" 100))
  |>.addTest "format exceptional ordinal numeral 101" (do
      return assertEqual "Zeinab, you are the 101st customer we serve today. Thank you!"
          (LineUp.format "Zeinab" 101))
  |>.addTest "format non-exceptional ordinal numeral 112" (do
      return assertEqual "Knud, you are the 112th customer we serve today. Thank you!"
          (LineUp.format "Knud" 112))
  |>.addTest "format exceptional ordinal numeral 123" (do
      return assertEqual "Yma, you are the 123rd customer we serve today. Thank you!"
          (LineUp.format "Yma" 123))
  |>.addTest "format large number 972 ending in nd even though it is a multiple of 12" (do
      return assertEqual "Elias, you are the 972nd customer we serve today. Thank you!"
          (LineUp.format "Elias" 972))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [lineUpTests]
