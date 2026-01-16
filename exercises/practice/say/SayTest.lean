import LeanTest
import Say

open LeanTest

def sayTests : TestSuite :=
  (TestSuite.empty "Say")
  |>.addTest "zero" (do
      return assertEqual "zero" (Say.say 0))
  |>.addTest "one" (do
      return assertEqual "one" (Say.say 1))
  |>.addTest "fourteen" (do
      return assertEqual "fourteen" (Say.say 14))
  |>.addTest "twenty" (do
      return assertEqual "twenty" (Say.say 20))
  |>.addTest "twenty-two" (do
      return assertEqual "twenty-two" (Say.say 22))
  |>.addTest "thirty" (do
      return assertEqual "thirty" (Say.say 30))
  |>.addTest "ninety-nine" (do
      return assertEqual "ninety-nine" (Say.say 99))
  |>.addTest "one hundred" (do
      return assertEqual "one hundred" (Say.say 100))
  |>.addTest "one hundred twenty-three" (do
      return assertEqual "one hundred twenty-three" (Say.say 123))
  |>.addTest "two hundred" (do
      return assertEqual "two hundred" (Say.say 200))
  |>.addTest "nine hundred ninety-nine" (do
      return assertEqual "nine hundred ninety-nine" (Say.say 999))
  |>.addTest "one thousand" (do
      return assertEqual "one thousand" (Say.say 1000))
  |>.addTest "one thousand two hundred thirty-four" (do
      return assertEqual "one thousand two hundred thirty-four" (Say.say 1234))
  |>.addTest "one million" (do
      return assertEqual "one million" (Say.say 1000000))
  |>.addTest "one million two thousand three hundred forty-five" (do
      return assertEqual "one million two thousand three hundred forty-five" (Say.say 1002345))
  |>.addTest "one billion" (do
      return assertEqual "one billion" (Say.say 1000000000))
  |>.addTest "a big number" (do
      return assertEqual "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three" (Say.say 987654321123))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [sayTests]
