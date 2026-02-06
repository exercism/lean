import Lean.Data.Json
import Std

open Lean
open Std

namespace LeapGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let description := case.get! "description"
              |> (·.compress)
  let year := case.get! "input" |> (·.getObjVal? "year") |> Except.toOption |> Option.get!
  let expected := case.get! "expected"
  let funName := case.get! "property"
              |> (·.compress)
              |> String.toList
              |> (·.filter (·!='"'))
              |> List.asString
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} ({exercise}.{funName} {year}))"

def genEnd (exercise : String) : String :=
  s!"

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [{exercise.decapitalize}Tests]\n"

end LeapGenerator
