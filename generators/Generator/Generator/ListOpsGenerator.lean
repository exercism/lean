import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ListOpsGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def functionToLean (property : String) (funStr : String) : String :=
  match property, funStr with
  | "filter", "\"(x) -> x modulo 2 == 1\"" => "(fun x => x % 2 == 1)"
  | "map", "\"(x) -> x + 1\"" => "(· + 1)"
  | "foldl", "\"(acc, el) -> el * acc\"" => "(fun acc el => el * acc)"
  | "foldl", "\"(acc, el) -> el + acc\"" => "(fun acc el => el + acc)"
  | "foldl", "\"(x, y) -> x / y\"" => "(· / ·)"
  | "foldr", "\"(acc, el) -> el * acc\"" => "(fun el acc => el * acc)"
  | "foldr", "\"(acc, el) -> el + acc\"" => "(fun el acc => el + acc)"
  | "foldr", "\"(x, y) -> x / y\"" => "(· / ·)"
  | _, _ => funStr

def serializeIntList (json : Json) : String :=
  match json.getArr? with
  | .error _ => s!"{json}"
  | .ok arr =>
    if arr.isEmpty then "([] : List Int)"
    else
      let items := arr.map (fun j => s!"{j}") |>.toList
      "[" ++ String.intercalate ", " items ++ "]"

def serializeNestedList (json : Json) : String :=
  match json.getArr? with
  | .error _ => s!"{json}"
  | .ok arr =>
    if arr.isEmpty then "([] : List (List Int))"
    else
      let items := arr.map (fun j => serializeIntList j) |>.toList
      "[" ++ String.intercalate ", " items ++ "]"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let description := case.get! "description" |> (·.compress)
  let property := getFunName (case.get! "property")
  let input := case.get! "input"
  match property with
  | "append" =>
    let list1 := input.getObjValD "list1"
    let list2 := input.getObjValD "list2"
    let expected := case.get! "expected"
    let call := s!"(ListOps.append {serializeIntList list1} {serializeIntList list2})"
    s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
  | "concat" =>
    let lists := input.getObjValD "lists"
    let expected := case.get! "expected"
    let call := s!"(ListOps.concat {serializeNestedList lists})"
    s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
  | "filter" =>
    let list := input.getObjValD "list"
    let funJson := input.getObjValD "function"
    let expected := case.get! "expected"
    let leanFun := functionToLean property funJson.compress
    let call := s!"(ListOps.filter {leanFun} {serializeIntList list})"
    s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
  | "length" =>
    let list := input.getObjValD "list"
    let expected := case.get! "expected"
    let call := s!"(ListOps.length {serializeIntList list})"
    s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"
  | "map" =>
    let list := input.getObjValD "list"
    let funJson := input.getObjValD "function"
    let expected := case.get! "expected"
    let leanFun := functionToLean property funJson.compress
    let call := s!"(ListOps.map {leanFun} {serializeIntList list})"
    s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
  | "foldl" =>
    let list := input.getObjValD "list"
    let initial := case.get! "input" |> (·.getObjValD "initial")
    let funJson := input.getObjValD "function"
    let expected := case.get! "expected"
    let leanFun := functionToLean property funJson.compress
    let call := s!"(ListOps.foldl {leanFun} {initial} {serializeIntList list})"
    s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"
  | "foldr" =>
    let list := input.getObjValD "list"
    let initial := case.get! "input" |> (·.getObjValD "initial")
    let funJson := input.getObjValD "function"
    let expected := case.get! "expected"
    let leanFun := functionToLean property funJson.compress
    let call := s!"(ListOps.foldr {leanFun} {initial} {serializeIntList list})"
    s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"
  | "reverse" =>
    let list := input.getObjValD "list"
    let expected := case.get! "expected"
    -- Check if it's a list of lists
    match list.getArr? with
    | .error _ =>
      let call := s!"(ListOps.reverse {serializeIntList list})"
      s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
    | .ok arr =>
      if arr.isEmpty then
        let call := s!"(ListOps.reverse {serializeIntList list})"
        s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
      else
        match arr[0]!.getArr? with
        | .ok _ =>
          let call := s!"(ListOps.reverse {serializeNestedList list})"
          s!"
  |>.addTest {description} (do
      return assertEqual {serializeNestedList expected} {call})"
        | .error _ =>
          let call := s!"(ListOps.reverse {serializeIntList list})"
          s!"
  |>.addTest {description} (do
      return assertEqual {serializeIntList expected} {call})"
  | _ => ""

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ListOpsGenerator
