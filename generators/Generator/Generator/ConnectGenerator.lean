import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace ConnectGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def extractChar (str : String) : Char :=
  if str == "" then ' '
  else str.front

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let board := s!"#{insertAllInputs input}".replace "," ",\n                                               "
  let expected : Char := case.get! "expected" |> (·.getStr?) |> getOk |> extractChar
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {board})"
  s!"
  |>.addTest {description} (do
      return assertEqual '{expected}' {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ConnectGenerator
