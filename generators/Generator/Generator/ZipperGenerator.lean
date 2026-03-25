import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ZipperGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest
open {exercise}

{concatAsserts}

def initialTree : BinTree Int :=
  .node 1
    (.node 2
      .nil
      (.node 3 .nil .nil))
    (.node 4 .nil .nil)

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

partial def serializeTree (json : Json) : String :=
  if json.isNull then ".nil"
  else
    let v := s!"{json.getObjValD "value"}"
    let l := serializeTree (json.getObjValD "left")
    let r := serializeTree (json.getObjValD "right")
    if l == ".nil" && r == ".nil" then
      s!"(.node {v} .nil .nil)"
    else
      s!"(.node {v} {l} {r})"

def serializeOp (op : Json) : String × Option String :=
  let name := op.getObjValD "operation" |>.compress |> toLiteral
  let leanName := match name with
    | "to_tree" => "toTree"
    | "set_value" => "setValue"
    | "set_left" => "setLeft"
    | "set_right" => "setRight"
    | other => other
  match op.getObjVal? "item" with
  | .ok item =>
    if item.isNull then
      (leanName, some ".nil")
    else match item.getInt? with
      | .ok n => (leanName, some (intLiteral n))
      | .error _ => (leanName, some (serializeTree item))
  | .error _ => (leanName, none)

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let property := getFunName (case.get! "property")
  let operations := input.getObjValD "operations" |>.getArr? |> getOk
  match property with
  | "expectedValue" =>
    let expectedType := expected.getObjValD "type" |>.compress |> toLiteral
    let expectedValue := expected.getObjValD "value"
    let ops := operations.map serializeOp |>.toList
    match expectedType with
    | "tree" =>
      let tree := serializeTree expectedValue
      let opChain := ops.map fun (name, arg) =>
        match arg with
        | some a => s!"{indent}|> Option.map ({exercise}.{name} {a})"
        | none =>
          if name == "toTree" then s!"{indent}|> Option.map {exercise}.toTree"
          else s!"{indent}|> Option.bind {exercise}.{name}"
      -- First op applied directly to zipper
      let firstOp := ops.head!
      let restOps := ops.tail!
      let firstLine := match firstOp with
        | (name, some a) =>
          if name == "toTree" then s!"let result := (fromTree initialTree).toTree"
          else s!"let result := ({exercise}.{name} {a} (fromTree initialTree))"
        | (name, none) =>
          if name == "toTree" then s!"let result := (fromTree initialTree).toTree"
          else s!"let result := (fromTree initialTree).{name}"
      if restOps.isEmpty then
        s!"
    |>.addTest {description} (do
      {firstLine}
      return assertEqual {tree} result)"
      else
        let chainLines := restOps.map fun (name, arg) =>
          match arg with
          | some a => s!"        |> Option.map ({exercise}.{name} {a})"
          | none =>
            if name == "toTree" then s!"        |> Option.map {exercise}.toTree"
            else s!"        |> Option.bind {exercise}.{name}"
        let chain := String.intercalate "\n" chainLines
        if expectedType == "tree" then
          s!"
    |>.addTest {description} (do
      let result := (fromTree initialTree).{(ops.head!).1}
{chain}
      match result with
      | none => return .failure \"Expected a tree but got none\"
      | some t => return assertEqual {tree} t)"
        else ""
    | "int" =>
      let v := intLiteral (getOk expectedValue.getInt?)
      let chainOps := ops.map fun (name, arg) =>
        match arg with
        | some a => s!"        |> Option.map ({exercise}.{name} {a})"
        | none =>
          if name == "value" then s!"        |> Option.bind {exercise}.{name}"
          else s!"        |> Option.bind {exercise}.{name}"
      let chain := String.intercalate "\n" chainOps
      s!"
    |>.addTest {description} (do
      let result := some (fromTree initialTree)
{chain}
      return assertEqual (some {v}) result)"
    | "zipper" =>
      if expectedValue.isNull then
        let chainOps := ops.map fun (name, _arg) =>
          s!"        |> Option.bind {exercise}.{name}"
        let chain := String.intercalate "\n" chainOps
        s!"
    |>.addTest {description} (do
      let result := some (fromTree initialTree)
{chain}
      return assertEqual none result)"
      else ""
    | _ => ""
  | "sameResultFromOperations" =>
    let ops1 := operations.map serializeOp |>.toList
    let expectedOps := expected.getObjValD "operations" |>.getArr? |> getOk
    let ops2 := expectedOps.map serializeOp |>.toList
    let chain1 := ops1.map fun (name, _arg) =>
      s!"        |> Option.bind {exercise}.{name}"
    let chain2 := ops2.map fun (name, _arg) =>
      s!"        |> Option.bind {exercise}.{name}"
    s!"
    |>.addTest {description} (do
      let path1 := some (fromTree initialTree)
{String.intercalate "\n" chain1}
      let path2 := some (fromTree initialTree)
{String.intercalate "\n" chain2}
      match path1, path2 with
      | some z1, some z2 => return assertEqual z1.toTree z2.toTree
      | none, _ => return .failure \"path1 returned none\"
      | _, none => return .failure \"path2 returned none\")"
  | _ => ""

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ZipperGenerator
