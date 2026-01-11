import LeanTest
import ReverseString

open LeanTest

def reverseStringTests : TestSuite :=
  (TestSuite.empty "ReverseString")
  |>.addTest "an empty string" (do
      return assertEqual "" (ReverseString.reverse ""))
  |>.addTest "a word" (do
      return assertEqual "tobor" (ReverseString.reverse "robot"))
  |>.addTest "a capitalized word" (do
      return assertEqual "nemaR" (ReverseString.reverse "Ramen"))
  |>.addTest "a sentence with punctuation" (do
      return assertEqual "!yrgnuh m'I" (ReverseString.reverse "I'm hungry!"))
  |>.addTest "a palindrome" (do
      return assertEqual "racecar" (ReverseString.reverse "racecar"))
  |>.addTest "an even-sized word" (do
      return assertEqual "reward" (ReverseString.reverse "drawer"))
  |>.addTest "wide characters" (do
      return assertEqual "猫子" (ReverseString.reverse "子猫"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [reverseStringTests]
