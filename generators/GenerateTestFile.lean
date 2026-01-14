import Std
import Lean
import Generator

open Lean
open Std

structure OrderedMap where
  order : Array String
  map : TreeMap.Raw String Json

structure Case where
  parent : Array String
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

def processCases (array : Array Json) : Except String OrderedMap := Id.run do
  let mut fullArray := #[]
  let mut fullMap := TreeMap.Raw.empty
  let mut stack : List Case := array.foldr (fun json acc =>
    { parent := #[], case := json } :: acc
  ) []
  while !stack.isEmpty do
    let { parent, case } : Case := stack.head!
    stack := stack.tail
    match case.getObjVal? "cases" with
    | .error _ =>
      match case.getObjVal? "reimplements" with
      | .error _ =>
        match case.getObjVal? "uuid" with
        | .error _ => return .error s!"no uuid for case: {case}"
        | .ok uuid =>
          let key := uuid.compress
          match case.getObjVal? "description" with
          | .error _ => return .error s!"no description for case: {case}"
          | .ok descriptionJson =>
            let description := getOk descriptionJson.getStr?
            let fullDescription := parent.push description |> Array.toList
            let caseWithParentDescription := case.setObjVal! "description" (" : ".intercalate fullDescription)
            fullArray := fullArray.push key
            fullMap := fullMap.insert key caseWithParentDescription
      | .ok other =>
        let key := other.compress
        fullMap := fullMap.insert key case
    | .ok cases =>
      match case.getObjVal? "description" with
      | .error _ => return .error s!"no description for case: {case}"
      | .ok descriptionJson =>
        let description := getOk descriptionJson.getStr?
        let childList := getOk cases.getArr?
                      |> Array.foldr (fun child acc =>
                        { parent := parent.push description, case := child } :: acc
                      ) []
        stack := childList ++ stack
  return .ok { order := fullArray, map := fullMap }

def getCases (map : TreeMap.Raw String Json) : Except String OrderedMap :=
  match map.get? "cases" with
  | none => .error "no cases in canonical data."
  | some json =>
    let array := getOk json.getArr?
    processCases array

def pascalCase  (input : String) : String :=
  input.splitOn "-" |> List.map String.capitalize |> String.join

def startTest (genTestCase : String -> TreeMap.Raw String Json -> String) (pascalExercise : String) (cases : OrderedMap) : String :=
  cases.order.foldl (fun acc uuid =>
    let case := cases.map.get! uuid
    match case.getObj? with
    | .error _ => acc
    | .ok caseMap => acc ++ genTestCase pascalExercise caseMap
  ) ""

def getExtraTests (pascalExercise : String) : String :=
  match Generator.extraCases.get? pascalExercise with
  | none => ""
  | some xs => String.join xs

def genTestFileContent (pascalExercise : String) (cases : OrderedMap) : String :=
  let (genIntro, genTestCase, genEnd) := Generator.dispatch.get! pascalExercise
  let intro := genIntro pascalExercise
  let tests := startTest genTestCase pascalExercise cases
  let extraTests := getExtraTests pascalExercise
  let allTests := tests ++ extraTests
  let ending := genEnd pascalExercise
  intro ++ allTests ++ ending

def main (args : List String) : IO Unit := do
  let exercise := args.head!
  let canonicalData <- readCanonicalData exercise
  match canonicalData with
  | .error _ => throw <| IO.userError "couldn't fetch canonical data."
  | .ok data =>
    let maybeMap := getOk data.getObj?
    match getCases maybeMap with
    | .error msg => throw <| IO.userError msg
    | .ok cases =>
      let pascalExercise := pascalCase exercise
      let testContent := genTestFileContent pascalExercise cases
      IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
