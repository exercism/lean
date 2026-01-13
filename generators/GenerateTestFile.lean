import Std
import Lean
import Generator

open Lean
open Std

structure OrderedMap where
  order : Array String
  map : TreeMap.Raw String Json

structure Case where
  parent : String
  case : Json
  deriving Inhabited

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
  let mut stack : List Case := array.foldr (fun json acc =>
    { parent := "", case := json } :: acc
  ) []
  while !stack.isEmpty do
    let { parent, case } : Case := stack.head!
    stack := stack.tail
    match case.getObjVal? "cases" with
    | .error _ =>
      match case.getObjVal? "reimplements" with
      | .error _ =>
        let uuid := case.getObjValD "uuid"
        let key := uuid.compress
        let description := case.getObjValD "description" |> Json.getStr? |> getOk
        let caseWithParentDescription := case.setObjVal! "description" (parent ++ description)
        fullArray := fullArray.push key
        fullMap := fullMap.insert key caseWithParentDescription
      | .ok other =>
        let key := other.compress
        fullMap := fullMap.insert key case
    | .ok cases =>
      let description := case.getObjValD "description" |> Json.compress
      let childList := getOk cases.getArr?
                    |> Array.foldr (fun child acc =>
                      { parent := parent ++ " : " ++ description, case := child } :: acc
                    ) []
      stack := childList ++ stack
  return { order := fullArray, map := fullMap }

def getCases (dataMap : Except String (TreeMap.Raw String Json)) : OrderedMap :=
  let map := getOk dataMap
  match map.get? "cases" with
  | none => empty
  | some json =>
    let array := getOk json.getArr?
    processCases array

def pascalCase  (input : String) : String :=
  input.splitOn "-" |> List.map String.capitalize |> String.join

def startTest (genTestCase : String -> TreeMap.Raw String Json -> String) (exercise : String) (cases : OrderedMap) : String :=
  cases.order.foldl (fun acc uuid =>
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
