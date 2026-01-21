import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace GameOfLifeGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := getKeyValues (case.get! "input")
            |> (·.map (fun (_, v) => v.replace "," ", " |> (·.replace "0" "false") |> (·.replace "1" "true")))
            |> (String.intercalate " " ·)
            |> (·.replace "[" "#[")
  let expected := toLiteral (case.get! "expected" |> (·.compress))
               |> (·.replace "," ", " |> (·.replace "0" "false") |> (·.replace "1" "true"))
               |> (·.replace "[" "#[")
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {input})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end GameOfLifeGenerator
