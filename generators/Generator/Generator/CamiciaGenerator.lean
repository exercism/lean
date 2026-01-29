import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace CamiciaGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def listOfCards (player : Json) : String :=
  player.getArr? |> getOk
    |>.map (λ j => toLiteral s!".C{j}")
    |>.toList |> λ x => "[" ++ String.intercalate ", " x ++ "]"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let playerA := listOfCards (input.getObjValD "playerA")
  let playerB := listOfCards (input.getObjValD "playerB")
  let expected := case.get! "expected"
  let status := toLiteral s!".{expected.getObjValD "status"}"
  let cards := expected.getObjValD "cards"
  let tricks := expected.getObjValD "tricks"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {playerA} {playerB})"
  s!"
  |>.addTest {description} (do
      return assertEqual ⟨{status}, {cards}, {tricks}⟩ {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end CamiciaGenerator
