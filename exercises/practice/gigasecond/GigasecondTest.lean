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
      return assertEqual datetime("2043-01-01T01:46:40") (Gigasecond.add datetime("2011-04-25T00:00:00")))
  |>.addTest "second test for date only specification of time" (do
      return assertEqual datetime("2009-02-19T01:46:40") (Gigasecond.add datetime("1977-06-13T00:00:00")))
  |>.addTest "third test for date only specification of time" (do
      return assertEqual datetime("1991-03-27T01:46:40") (Gigasecond.add datetime("1959-07-19T00:00:00")))
  |>.addTest "full time specified" (do
      return assertEqual datetime("2046-10-02T23:46:40") (Gigasecond.add datetime("2015-01-24T22:00:00")))
  |>.addTest "full time with day roll-over" (do
      return assertEqual datetime("2046-10-03T01:46:39") (Gigasecond.add datetime("2015-01-24T23:59:59")))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [gigasecondTests]
