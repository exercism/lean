import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace BinarySearchTreeGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{concatAsserts}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def identation : String := "      "
def serialize (json : Json) : String :=
  serializeList json (λ x => toLiteral s!"{x}") ", "

partial def recursiveAsserts (obj : Json) (parent : String) : String :=
  if obj.isNull
  then ""
  else
    let left := recursiveAsserts (obj.getObjValD "left") (parent ++ ".left!")
    let right := recursiveAsserts (obj.getObjValD "right") (parent ++ ".right!")
    let data := toLiteral $ s!"{obj.getObjValD "data"}"
    s!"assertEqual {data} {parent ++ ".data!"}
    "
      ++ (if left.isEmpty then "" else s!"{identation}++ {left}")
      ++ (if right.isEmpty then "" else s!"{identation}++ {right}")

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input" |>.getObjValD "treeData"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let assert := match getFunName $ case.get! "property" with
                | "sortedData" =>
                  s!"return assertEqual {serialize expected} tree.sort"
                | _ =>
                  s!"return {recursiveAsserts expected "tree"}"
  s!"
    |>.addTest {description} (do
      let tree := {exercise}.buildTree {serialize input}
      {assert})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end BinarySearchTreeGenerator
