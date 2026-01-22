import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace TransposeGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def joinLines (json : Json) : Except String String :=
  json.getArr?
  >>= (pure ·.toList)
  >>= (fun xs => pure (xs.map (toLiteral s!"{·}")))
  >>= (fun xs => pure (s!"\"{String.intercalate "\\n" xs}\""))

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let joinedInput := input.getObjVal? "lines" >>= joinLines
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {getOk joinedInput})"
  s!"
  |>.addTest {description} (do
      return assertEqual {getOk (joinLines expected)} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end TransposeGenerator
