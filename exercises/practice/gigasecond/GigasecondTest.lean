import LeanTest
import Std
import Lean
import Gigasecond

open LeanTest
open Lean
open Std.Time

def gigasecondTests : TestSuite :=
  (TestSuite.empty "Gigasecond")
  |>.addTest "date only specification of time" (do
      return assertEqual (PlainDateTime.mk (PlainDate.mk 2043 1 1 (by decide)) (PlainTime.mk 1 46 40 0)) (Gigasecond.add (PlainDateTime.mk (PlainDate.mk 2011 4 25 (by decide)) (PlainTime.mk 0 0 0 0))))
  |>.addTest "second test for date only specification of time" (do
      return assertEqual (PlainDateTime.mk (PlainDate.mk 2009 2 19 (by decide)) (PlainTime.mk 1 46 40 0)) (Gigasecond.add (PlainDateTime.mk (PlainDate.mk 1977 6 13 (by decide)) (PlainTime.mk 0 0 0 0))))
  |>.addTest "third test for date only specification of time" (do
      return assertEqual (PlainDateTime.mk (PlainDate.mk 1991 3 27 (by decide)) (PlainTime.mk 1 46 40 0)) (Gigasecond.add (PlainDateTime.mk (PlainDate.mk 1959 7 19 (by decide)) (PlainTime.mk 0 0 0 0))))
  |>.addTest "full time specified" (do
      return assertEqual (PlainDateTime.mk (PlainDate.mk 2046 10 2 (by decide)) (PlainTime.mk 23 46 40 0)) (Gigasecond.add (PlainDateTime.mk (PlainDate.mk 2015 1 24 (by decide)) (PlainTime.mk 22 0 0 0))))
  |>.addTest "full time with day roll-over" (do
      return assertEqual (PlainDateTime.mk (PlainDate.mk 2046 10 3 (by decide)) (PlainTime.mk 1 46 39 0)) (Gigasecond.add (PlainDateTime.mk (PlainDate.mk 2015 1 24 (by decide)) (PlainTime.mk 23 59 59 0))))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [gigasecondTests]
