import LeanTest
import Std
import Lean
import Gigasecond

open LeanTest
open Lean
open Std.Time

/--
`adjusteddatetime("YYYY-MM-DD")` or `adjusteddatetime("YYYY-MM-DDTHH:mm:ss")`

Accepts either:
1. a full ISO-8601 datetime, or
2. a date only, which is interpreted as midnight (`00:00:00`).

The literal is checked at compile time.

This macro makes use of the already defined `datetime` macro, inside `Std.Time`.
-/

syntax "adjusteddatetime" "(" str ")" : term

macro_rules
  | `(adjusteddatetime($s:str)) => do
      let raw := s.getString

      let full :=
        if raw.contains 'T'
        then raw
        else raw ++ "T00:00:00"

      let lit := Syntax.mkStrLit full
      `(datetime($lit))

def gigasecondTests : TestSuite :=
  (TestSuite.empty "Gigasecond")
  |>.addTest "date only specification of time" (do
      return assertEqual datetime("2043-01-01T01:46:40") (Gigasecond.add adjusteddatetime("2011-04-25")))
  |>.addTest "second test for date only specification of time" (do
      return assertEqual datetime("2009-02-19T01:46:40") (Gigasecond.add adjusteddatetime("1977-06-13")))
  |>.addTest "third test for date only specification of time" (do
      return assertEqual datetime("1991-03-27T01:46:40") (Gigasecond.add adjusteddatetime("1959-07-19")))
  |>.addTest "full time specified" (do
      return assertEqual datetime("2046-10-02T23:46:40") (Gigasecond.add adjusteddatetime("2015-01-24T22:00:00")))
  |>.addTest "full time with day roll-over" (do
      return assertEqual datetime("2046-10-03T01:46:39") (Gigasecond.add adjusteddatetime("2015-01-24T23:59:59")))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [gigasecondTests]
