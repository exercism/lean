import LeanTest
import Isogram

open LeanTest

def isogramTests : TestSuite :=
  (TestSuite.empty "Isogram")
  |>.addTest "empty string" (do
      return assertTrue (Isogram.isIsogram ""))
  |>.addTest "isogram with only lower case characters" (do
      return assertTrue (Isogram.isIsogram "isogram"))
  |>.addTest "word with one duplicated character" (do
      return assertFalse (Isogram.isIsogram "eleven"))
  |>.addTest "word with one duplicated character from the end of the alphabet" (do
      return assertFalse (Isogram.isIsogram "zzyzx"))
  |>.addTest "longest reported english isogram" (do
      return assertTrue (Isogram.isIsogram "subdermatoglyphic"))
  |>.addTest "word with duplicated character in mixed case" (do
      return assertFalse (Isogram.isIsogram "Alphabet"))
  |>.addTest "word with duplicated character in mixed case, lowercase first" (do
      return assertFalse (Isogram.isIsogram "alphAbet"))
  |>.addTest "hypothetical isogrammic word with hyphen" (do
      return assertTrue (Isogram.isIsogram "thumbscrew-japingly"))
  |>.addTest "hypothetical word with duplicated character following hyphen" (do
      return assertFalse (Isogram.isIsogram "thumbscrew-jappingly"))
  |>.addTest "isogram with duplicated hyphen" (do
      return assertTrue (Isogram.isIsogram "six-year-old"))
  |>.addTest "made-up name that is an isogram" (do
      return assertTrue (Isogram.isIsogram "Emily Jung Schwartzkopf"))
  |>.addTest "duplicated character in the middle" (do
      return assertFalse (Isogram.isIsogram "accentor"))
  |>.addTest "same first and last characters" (do
      return assertFalse (Isogram.isIsogram "angola"))
  |>.addTest "word with duplicated character and with two hyphens" (do
      return assertFalse (Isogram.isIsogram "up-to-date"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [isogramTests]
