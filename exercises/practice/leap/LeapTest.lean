import LeanTest
import Leap

open LeanTest

def leapTests : TestSuite :=
  (TestSuite.empty "Leap")
  |>.addTest "year not divisible by 4 in common year" (do
      return assertFalse (Leap.leapYear 2015))
  |>.addTest "year divisible by 2, not divisible by 4 in common year" (do
      return assertFalse (Leap.leapYear 1970))
  |>.addTest "year divisible by 4, not divisible by 100 in leap year" (do
      return assertTrue (Leap.leapYear 1996))
  |>.addTest "year divisible by 4 and 5 is still a leap year" (do
      return assertTrue (Leap.leapYear 1960))
  |>.addTest "year divisible by 100, not divisible by 400 in common year" (do
      return assertFalse (Leap.leapYear 2100))
  |>.addTest "year divisible by 100 but not by 3 is still not a leap year" (do
      return assertFalse (Leap.leapYear 1900))
  |>.addTest "year divisible by 400 is leap year" (do
      return assertTrue (Leap.leapYear 2000))
  |>.addTest "year divisible by 400 but not by 125 is still a leap year" (do
      return assertTrue (Leap.leapYear 2400))
  |>.addTest "year divisible by 200, not divisible by 400 in common year" (do
      return assertFalse (Leap.leapYear 1800))

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [leapTests]
