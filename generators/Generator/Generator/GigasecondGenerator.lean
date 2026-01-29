import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace GigasecondGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import Std
import Lean
import {exercise}

open LeanTest
open Lean
open Std.Time

/--
`adjusteddatetime(\"YYYY-MM-DD\")` or `adjusteddatetime(\"YYYY-MM-DDTHH:mm:ss\")`

Accepts either:
1. a full ISO-8601 datetime, or
2. a date only, which is interpreted as midnight (`00:00:00`).

The literal is checked at compile time.

This macro makes use of the already defined `datetime` macro, inside Std.Time.
-/

syntax \"adjusteddatetime\" \"(\" str \")\" : term

macro_rules
  | `(adjusteddatetime($s:str)) => do
      let raw := s.getString

      let full :=
        if raw.contains 'T'
        then raw
        else raw ++ \"T00:00:00\"

      let lit := Syntax.mkStrLit full
      `(datetime($lit))

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} adjusteddatetime({insertAllInputs input}))"
  s!"
  |>.addTest {description} (do
      return assertEqual datetime({expected}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end GigasecondGenerator
