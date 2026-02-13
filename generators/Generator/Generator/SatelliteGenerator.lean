import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace SatelliteGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

partial def serialize (indent : String) (tree : Json) : String :=
  "\n" ++ indent ++ match (tree.getObjVal? "v", tree.getObjVal? "l", tree.getObjVal? "r") with
  | (.ok value, .ok left, .ok right) =>
        let next := indent ++ "  "
        s!"(.branch '{getFunName value}'{serialize next left}{serialize next right}\n{indent})"
  | _ => ".leaf"

def exceptToString {α} [ToString α] (except : Except α Json) : String :=
  match except with
  | .ok tree => s!"(.ok{serialize "        " tree})"
  | .error msg => s!"(.error {msg})"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let preorder := input.getObjValD "preorder"
  let inorder := input.getObjValD "inorder"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {preorder} {inorder})".replace "\"" "'"
  s!"
  |>.addTest {description} (do
      return assertEqual {exceptToString (toExcept expected)}\n        {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end SatelliteGenerator
