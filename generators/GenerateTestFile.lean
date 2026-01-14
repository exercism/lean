import Std
import Lean
import Generator

open Lean
open Std

structure OrderedMap where
  order : Array String
  map : TreeMap.Raw String Json

def empty : OrderedMap := { order := #[], map := .empty }

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> Option.get!

def strip (string : String) (char : Char) : String :=
  String.dropWhile string (·==char) |> (String.dropRightWhile · (·==char))

def stripWhiteSpace (string : String) : String :=
  String.dropWhile string (·.isWhitespace) |> (String.dropRightWhile . (·.isWhitespace))

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
  try
    let json <- IO.FS.readFile path
    return Json.parse json
  catch _ =>
    return .error "No canonical data."

def processCases (tests : TreeMap String String) (array : Array Json) : Except String OrderedMap := Id.run do
  let mut fullArray := #[]
  let mut fullMap := TreeMap.Raw.empty
  let mut stack := array.toList
  while !stack.isEmpty do
    let case := stack.head!
    stack := stack.tail
    match case.getObjVal? "cases" with
    | .error _ =>
      match case.getObjVal? "uuid" with
      | .error _ => return .error s!"No uuid for case: {case}."
      | .ok uuid =>
        let key := getOk uuid.getStr?
        match tests.get? key with
        | none => continue /- include false -/
        | some description =>
          fullArray := fullArray.push key
          fullMap := fullMap.insert key (case.setObjVal! "description" description)
    | .ok cases =>
      let childList := getOk cases.getArr? |> Array.toList
      stack := childList ++ stack
  return .ok { order := fullArray, map := fullMap }

def getCases (map : TreeMap.Raw String Json) (tests : TreeMap String String) : Except String OrderedMap :=
  match map.get? "cases" with
  | none => .error "No cases in canonical data."
  | some json =>
    let array := getOk json.getArr?
    processCases tests array

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

def genTestFileContent (pascalExercise : String) (cases : OrderedMap) : Except String String :=
  match Generator.dispatch.get? pascalExercise with
  | none => .error "No key was found for the exercise in Generator.dispatch. Add it in ./Generator/Generator.lean."
  | some (genIntro, genTestCase, genEnd) =>
    let intro := genIntro pascalExercise
    let tests := startTest genTestCase pascalExercise cases
    let extraTests := getExtraTests pascalExercise
    let ending := genEnd pascalExercise
    .ok (intro ++ tests ++ extraTests ++ ending)

def getToml (exercise : String) : IO (Except String String) := do
  let path := s!"../exercises/practice/{exercise}/.meta/tests.toml"
  try
    let toml <- IO.FS.readFile path
    return .ok toml
  catch _ =>
    return .error "No toml file."

def getTestsToInclude (toml : String) : IO (TreeMap String String) := do
  let cases := toml.splitOn "\n\n"
            |> List.map (·.splitOn "\n" |> List.map stripWhiteSpace)
  let includes := cases.filter (fun xs =>
    let hasInclude := xs.find? (stripWhiteSpace . |> (·.startsWith "include"))
    match hasInclude with
    | none => true
    | some string =>
      let words := string.splitOn " " |> List.map stripWhiteSpace |> String.join
      words != "include=false"
  )
  return includes.foldr (fun xs acc =>
    match xs with
    | uuid :: descriptionLine :: _ =>
      let formattedUUID := uuid.stripPrefix "[" |> (·.stripSuffix "]")
      let description := stripWhiteSpace descriptionLine
                        |> (·.stripPrefix "description")
                        |> (·.dropWhile (·.isWhitespace))
                        |> (·.stripPrefix "=")
                        |> (·.dropWhile (·.isWhitespace))
                        |> (strip . '"')
      acc.insert formattedUUID description
    | _ => acc
  ) Std.TreeMap.empty

def main (args : List String) : IO Unit := do
  match args with
  | [] => throw <| IO.userError "No exercise name found. Usage is: lake exe generator <exercise-in-kebab-case>"
  | exercise :: _ =>
    let pascalExercise := pascalCase exercise
    let maybeToml <- getToml exercise
    match maybeToml with
    | .error _ => match genTestFileContent pascalExercise empty with
                  | .error msg => throw <| IO.userError msg
                  | .ok testContent => IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
    | .ok toml =>
      let tests <- getTestsToInclude toml
      let canonicalData <- readCanonicalData exercise
      let data := match canonicalData with
                  | .error _ => Json.null
                  | .ok data => data
      match data.getObj? with
      | .error _ => match genTestFileContent pascalExercise empty with
                    | .error msg => throw <| IO.userError msg
                    | .ok testContent => IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
      | .ok maybeMap =>
        match getCases maybeMap tests with
        | .error msg => throw <| IO.userError msg
        | .ok cases => match genTestFileContent pascalExercise cases with
                      | .error msg => throw <| IO.userError msg
                      | .ok testContent => IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
