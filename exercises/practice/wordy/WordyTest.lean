import LeanTest
import Wordy

open LeanTest

def wordyTests : TestSuite :=
  (TestSuite.empty "Wordy")
  |>.addTest "just a number" (do
      return assertEqual (some 5) (Wordy.answer "What is 5?"))
  |>.addTest "just a zero" (do
      return assertEqual (some 0) (Wordy.answer "What is 0?"))
  |>.addTest "just a negative number" (do
      return assertEqual (some (-123)) (Wordy.answer "What is -123?"))
  |>.addTest "addition" (do
      return assertEqual (some 2) (Wordy.answer "What is 1 plus 1?"))
  |>.addTest "addition with a left hand zero" (do
      return assertEqual (some 2) (Wordy.answer "What is 0 plus 2?"))
  |>.addTest "addition with a right hand zero" (do
      return assertEqual (some 3) (Wordy.answer "What is 3 plus 0?"))
  |>.addTest "more addition" (do
      return assertEqual (some 55) (Wordy.answer "What is 53 plus 2?"))
  |>.addTest "addition with negative numbers" (do
      return assertEqual (some (-11)) (Wordy.answer "What is -1 plus -10?"))
  |>.addTest "large addition" (do
      return assertEqual (some 45801) (Wordy.answer "What is 123 plus 45678?"))
  |>.addTest "subtraction" (do
      return assertEqual (some 16) (Wordy.answer "What is 4 minus -12?"))
  |>.addTest "multiplication" (do
      return assertEqual (some (-75)) (Wordy.answer "What is -3 multiplied by 25?"))
  |>.addTest "division" (do
      return assertEqual (some (-11)) (Wordy.answer "What is 33 divided by -3?"))
  |>.addTest "multiple additions" (do
      return assertEqual (some 3) (Wordy.answer "What is 1 plus 1 plus 1?"))
  |>.addTest "addition and subtraction" (do
      return assertEqual (some 8) (Wordy.answer "What is 1 plus 5 minus -2?"))
  |>.addTest "multiple subtraction" (do
      return assertEqual (some 3) (Wordy.answer "What is 20 minus 4 minus 13?"))
  |>.addTest "subtraction then addition" (do
      return assertEqual (some 14) (Wordy.answer "What is 17 minus 6 plus 3?"))
  |>.addTest "multiple multiplication" (do
      return assertEqual (some (-12)) (Wordy.answer "What is 2 multiplied by -2 multiplied by 3?"))
  |>.addTest "addition and multiplication" (do
      return assertEqual (some (-8)) (Wordy.answer "What is -3 plus 7 multiplied by -2?"))
  |>.addTest "multiple division" (do
      return assertEqual (some 2) (Wordy.answer "What is -12 divided by 2 divided by -3?"))
  |>.addTest "unknown operation" (do
      return assertEqual none (Wordy.answer "What is 52 cubed?"))
  |>.addTest "Non math question" (do
      return assertEqual none (Wordy.answer "Who is the President of the United States?"))
  |>.addTest "reject problem missing an operand" (do
      return assertEqual none (Wordy.answer "What is 1 plus?"))
  |>.addTest "reject problem with no operands or operators" (do
      return assertEqual none (Wordy.answer "What is?"))
  |>.addTest "reject two operations in a row" (do
      return assertEqual none (Wordy.answer "What is 1 plus plus 2?"))
  |>.addTest "reject two numbers in a row" (do
      return assertEqual none (Wordy.answer "What is 1 plus 2 1?"))
  |>.addTest "reject postfix notation" (do
      return assertEqual none (Wordy.answer "What is 1 2 plus?"))
  |>.addTest "reject prefix notation" (do
      return assertEqual none (Wordy.answer "What is plus 1 2?"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [wordyTests]
