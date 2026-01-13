import Std
import Lean
import Generator

open Lean
open Std

structure OrderedMap where
  order : Array Json
  map : TreeMap.Raw String Json

def empty : OrderedMap := { order := #[], map := .empty }

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> Option.get!

def readCanonicalData (exercise : String) : IO (Except String Json) := do
  let info <- IO.Process.run {
    cmd := "../bin/configlet"
    args := #["info", "-o", "-v", "d", "-t", ".."]
  }
  let dirPrefix := "Using cached 'problem-specifications' dir: "
  let directory := info.splitOn "\n" |>
    List.filter (·.startsWith dirPrefix) |>
    List.map (·.stripPrefix dirPrefix) |>
    List.head!
  let path := s!"{directory}/exercises/{exercise}/canonical-data.json"
  let json <- IO.FS.readFile path
  return Json.parse json

def getMap (data : Except String Json) : Except String (TreeMap.Raw String Json) :=
  data.bind (·.getObj?)

def processCases (array : Array Json) : OrderedMap := Id.run do
  let mut fullArray := #[]
  let mut fullMap := TreeMap.Raw.empty
  let mut stack := array.toList
  while !stack.isEmpty do
    let caseJson := stack.head!
    stack := stack.tail
    match caseJson.getObjVal? "cases" with
    | .error _ =>
      fullArray := fullArray.push caseJson
      let uuid := caseJson.getObjVal? "uuid" |> getOk
      match caseJson.getObjVal? "reimplements" with
      | .error _ =>
        fullMap := fullMap.insert uuid.compress caseJson
      | .ok other =>
        fullMap := fullMap.insert other.compress caseJson
    | .ok cases =>
      let childList := getOk cases.getArr? |> Array.toList
      stack := childList ++ stack
  return { order := fullArray, map := fullMap }

def getCases (dataMap : Except String (TreeMap.Raw String Json)) : OrderedMap :=
  let map : TreeMap.Raw String Json := getOk dataMap

  match map.get? "cases" with
  | none => empty
  | some json =>
    let array := getOk json.getArr?
    processCases array

def pascalCase  (input : String) : String :=
  input.splitOn "-" |> List.map String.capitalize |> String.join

def startTest (genTestCase : String -> TreeMap.Raw String Json -> String) (exercise : String) (cases : OrderedMap) : String :=
  cases.order.foldl (fun acc json =>
    let uuid := json.getObjVal? "uuid" |> getOk |> Json.compress
    let case := cases.map.get! uuid
    match case.getObj? with
    | .error _ => acc
    | .ok caseMap => acc ++ genTestCase exercise caseMap
  ) ""

def genTestFileContent (pascalExercise : String) (cases : OrderedMap) : String :=
  let (genIntro, genTestCase, genEnd) := Generator.dispatch.get! pascalExercise
  let intro := genIntro pascalExercise
  let tests := startTest genTestCase pascalExercise cases
  let ending := genEnd pascalExercise
  intro ++ tests ++ ending

def main (args : List String) : IO Unit := do
  let exercise := args.head!
  let canonicalData <- readCanonicalData exercise
  let maybeMap := getMap canonicalData
  let cases := getCases maybeMap
  let pascalExercise := pascalCase exercise
  let testContent := genTestFileContent pascalExercise cases
  IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
