import Lean
import Std

open Lean
open Std

namespace PythagoreanTripletGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input" |> (·.getObjVal? "n") |> Except.toOption |> Option.get!
  let result := case.get! "expected" |> (·.getArr?) |> Except.toOption |> Option.get! |> Array.toList
  let description := case.get! "description" |> (·.compress)
  let funName := case.get! "property" |> (·.compress) |> String.toList |> (·.filter (·!='"')) |> List.asString
  s!"
  |>.addTest {description} (do
      return assertEqual {result} ({exercise}.{funName} {input}))"

def genEnd (exercise : String) : String :=
  s!"

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
  "

end PythagoreanTripletGenerator
