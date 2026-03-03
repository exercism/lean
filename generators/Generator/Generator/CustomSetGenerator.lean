import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace CustomSetGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def operatorsBool : Std.HashMap String (Std.HashMap Bool String) := .ofList [
  ("contains", .ofList [(true, "∈"), (false, "∉")]),
  ("subset", .ofList [(true, "⊆"), (false, "⊈")]),
]

def operatorsSet : Std.HashMap String String := .ofList [
  ("intersection", "∩"),
  ("union", "∪"),
  ("difference", "\\")
]

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  match funName with
  | "empty" =>
    let equal := match getOk expected.getBool? with
    | true => "Equal"
    | false => "NotEqual"
    s!"
    |>.addTest {description} (do
        return assert{equal} ∅ <| {exercise}.Set.ofList {insertAllInputs input})"
  | "contains" =>
    let set := input.getObjValD "set"
    let elem := input.getObjValD "element"
    let operator := operatorsBool[funName]![getOk expected.getBool?]!
    s!"
    |>.addTest {description} (do
        return assert <| decide <| {elem} {operator} {exercise}.Set.ofList {set})"
  | "disjoint" =>
    let set1 := input.getObjValD "set1"
    let set2 := input.getObjValD "set2"
    let result := s!"{getOk expected.getBool?}".capitalize
    s!"
    |>.addTest {description} (do
        return assert{result} <| ({exercise}.Set.ofList {set1}).disjoint <| {exercise}.Set.ofList {set2})"
  | "equal" =>
    let set1 := input.getObjValD "set1"
    let set2 := input.getObjValD "set2"
    match getOk expected.getBool? with
    | true =>
      s!"
    |>.addTest {description} (do
        return assert <| {exercise}.Set.ofList {set1} == {exercise}.Set.ofList {set2})"
    | false =>
      s!"
    |>.addTest {description} (do
        return assert <| {exercise}.Set.ofList {set1} != {exercise}.Set.ofList {set2})"
  | "add" =>
    let set := input.getObjValD "set"
    let elem := input.getObjValD "element"
    let result := s!"({exercise}.Set.ofList {expected})"
    s!"
    |>.addTest {description} (do
        return assertEqual {result} <| ({exercise}.Set.ofList {set}).add {elem})"
  | "subset" =>
    let set1 := input.getObjValD "set1"
    let set2 := input.getObjValD "set2"
    let operator := operatorsBool[funName]![getOk expected.getBool?]!
    s!"
    |>.addTest {description} (do
        return assert <| decide <| {exercise}.Set.ofList {set1} {operator} {exercise}.Set.ofList {set2})"
  | "intersection"
  | "difference"
  | "union" =>
    let set1 := input.getObjValD "set1"
    let set2 := input.getObjValD "set2"
    let operator := operatorsSet[funName]!
    let result := s!"({exercise}.Set.ofList {expected})"
    s!"
    |>.addTest {description} (do
        return assertEqual {result} <| {exercise}.Set.ofList {set1} {operator} {exercise}.Set.ofList {set2})"
  | _ => ""

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end CustomSetGenerator
