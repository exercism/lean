import LeanTest
import MatchingBrackets

open LeanTest

def matchingBracketsTests : TestSuite :=
  (TestSuite.empty "MatchingBrackets")
  |>.addTest "paired square brackets" (do
      return assertTrue (MatchingBrackets.isPaired "[]"))
  |>.addTest "empty string" (do
      return assertTrue (MatchingBrackets.isPaired ""))
  |>.addTest "unpaired brackets" (do
      return assertFalse (MatchingBrackets.isPaired "[["))
  |>.addTest "wrong ordered brackets" (do
      return assertFalse (MatchingBrackets.isPaired "}{"))
  |>.addTest "wrong closing bracket" (do
      return assertFalse (MatchingBrackets.isPaired "{]"))
  |>.addTest "paired with whitespace" (do
      return assertTrue (MatchingBrackets.isPaired "{ }"))
  |>.addTest "partially paired brackets" (do
      return assertFalse (MatchingBrackets.isPaired "{[])"))
  |>.addTest "simple nested brackets" (do
      return assertTrue (MatchingBrackets.isPaired "{[]}"))
  |>.addTest "several paired brackets" (do
      return assertTrue (MatchingBrackets.isPaired "{}[]"))
  |>.addTest "paired and nested brackets" (do
      return assertTrue (MatchingBrackets.isPaired "([{}({}[])])"))
  |>.addTest "unopened closing brackets" (do
      return assertFalse (MatchingBrackets.isPaired "{[)][]}"))
  |>.addTest "unpaired and nested brackets" (do
      return assertFalse (MatchingBrackets.isPaired "([{])"))
  |>.addTest "paired and wrong nested brackets" (do
      return assertFalse (MatchingBrackets.isPaired "[({]})"))
  |>.addTest "paired and wrong nested brackets but innermost are correct" (do
      return assertFalse (MatchingBrackets.isPaired "[({}])"))
  |>.addTest "paired and incomplete brackets" (do
      return assertFalse (MatchingBrackets.isPaired "{}["))
  |>.addTest "too many closing brackets" (do
      return assertFalse (MatchingBrackets.isPaired "[]]"))
  |>.addTest "early unexpected brackets" (do
      return assertFalse (MatchingBrackets.isPaired ")()"))
  |>.addTest "early mismatched brackets" (do
      return assertFalse (MatchingBrackets.isPaired "{)()"))
  |>.addTest "math expression" (do
      return assertTrue (MatchingBrackets.isPaired "(((185 + 223.85) * 15) - 543)/2"))
  |>.addTest "complex latex expression" (do
      return assertTrue (MatchingBrackets.isPaired "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [matchingBracketsTests]
