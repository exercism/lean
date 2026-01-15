import Lean
import Std

open Lean
open Std

namespace RomanNumeralsGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def intLiteral (n : Int) : String :=
  if n < 0 then s!"({n})"
  else s!"{n}"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let description := case.get! "description"
              |> (·.compress)
  let number := case.get! "input" |> (·.getObjVal? "number") |> Except.toOption |> Option.get!
  let expected := case.get! "expected"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} ({exercise}.roman {number}))"

def genEnd (exercise : String) : String :=
  s!"

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
  "

end RomanNumeralsGenerator
