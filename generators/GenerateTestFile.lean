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

def pascalCase  (input : String) : String :=
  input.splitOn "-" |> List.map String.capitalize |> String.join

def getPath (exercise : String) : IO String := do
  let info <- IO.Process.run {
    cmd := "../bin/configlet"
    args := #["info", "-o", "-v", "d", "-t", ".."]
  }
  let dirPrefix := "Using cached 'problem-specifications' dir: "
  let directory := info.splitOn "\n" |>
    List.filter (·.startsWith dirPrefix) |>
    List.map (·.stripPrefix dirPrefix) |>
    List.head!
  return s!"{directory}/exercises/{exercise}"

def getToml (exercise : String) : IO (Except String String) := do
  let path := s!"../exercises/practice/{exercise}/.meta/tests.toml"
  try
    let toml <- IO.FS.readFile path
    return .ok toml
  catch _ =>
    return .error "No toml file."

def readCanonicalData (exercise : String) : IO (Except String Json) := do
  let path <- getPath exercise
  try
    let json <- IO.FS.readFile (path ++ "/canonical-data.json")
    return Json.parse json
  catch _ =>
    return .error "No canonical data."

def processCanonicalCases (tests : TreeMap String String) (array : Array Json) : Except String OrderedMap := Id.run do
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

def getCanonicalCases (canonical : TreeMap.Raw String Json) (tests : TreeMap String String) : Except String OrderedMap :=
  match canonical.get? "cases" with
  | none => .error "No cases in canonical data."
  | some json =>
    let array := getOk json.getArr?
    processCanonicalCases tests array

def readExtraCases (exercise : String) : IO (Except String Json) := do
  try
    let json <- IO.FS.readFile (s!"../exercises/practice/{exercise}/.meta/extra.json")
    return Json.parse json
  catch _ =>
    return .error "No extra cases found."

def getExtraCases (extra : Except String Json) : TreeMap.Raw String Json :=
  match extra with
  | .error _ => {}
  | .ok json =>
    match json.getObj? with
    | .error _ => {}
    | .ok mapExtra => mapExtra

def getCanonicalTests (genTestCase : String -> TreeMap.Raw String Json -> String) (pascalExercise : String) (cases : OrderedMap) : String :=
  cases.order.foldl (fun acc uuid =>
    let case := cases.map.get! uuid
    match case.getObj? with
    | .error _ => acc
    | .ok caseMap => acc ++ genTestCase pascalExercise caseMap
  ) ""

def getExtraTests (genTestCase : String -> TreeMap.Raw String Json -> String) (pascalExercise : String) (extra : Array Json) : String :=
  extra.foldl (fun acc case =>
    match case.getObj? with
    | .error _ => acc
    | .ok caseMap => acc ++ genTestCase pascalExercise caseMap
  ) ""

def genTestFileContent (pascalExercise : String) (cases : OrderedMap) (extra : Array Json) : Except String String :=
  match Generator.dispatch.get? pascalExercise with
  | none => .error "No key was found for the exercise in Generator.dispatch. Add it in ./Generator/Generator.lean."
  | some (genIntro, genTestCase, genEnd) =>
    let intro := genIntro pascalExercise
    let canonicalTests := getCanonicalTests genTestCase pascalExercise cases
    let extraTests := getExtraTests genTestCase pascalExercise extra
    let ending := genEnd pascalExercise
    let testContent := intro ++ canonicalTests ++ extraTests ++ ending
    .ok (stripWhiteSpace testContent ++ "\n")

def getIncludes (toml : String) : TreeMap String String :=
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
  includes.foldr (fun xs acc =>
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

def showUsage : IO Unit :=
  let usageMsg := s!"Usage is:
    lake exe generator [Options] <exercise-slug>

    Options:
      -s / --stub :
        Generates a stub Generator for the exercise in ./generators/Generator/Generator/

      -g / --generate :
        Generates a test file for the exercise in ./exercises/practice/<exercise-slug>/"
  IO.println usageMsg

def generateTestFile (exercise : String) : IO Unit := do
  let pascalExercise := pascalCase exercise
  let maybeToml <- getToml exercise
  let extra <- readExtraCases exercise
  match maybeToml with
  | .error _ =>
    match extra with
    | .error msg => throw <| IO.userError msg
    | .ok json =>
      let array := getOk json.getArr?
      match genTestFileContent pascalExercise empty array with
      | .error msg => throw <| IO.userError msg
      | .ok testContent => IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
  | .ok toml =>
    let tests := getIncludes toml
    let canonicalData <- readCanonicalData exercise
    let data := match canonicalData with
                | .error _ => Json.null
                | .ok data => data
    match data.getObj? with
    | .error _ =>
      match extra with
      | .error msg => throw <| IO.userError msg
      | .ok json =>
        let array := getOk json.getArr?
        match genTestFileContent pascalExercise empty array with
        | .error msg => throw <| IO.userError msg
        | .ok testContent => IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
    | .ok maybeMap =>
      match getCanonicalCases maybeMap tests with
      | .error msg => throw <| IO.userError msg
      | .ok cases =>
        match extra with
        | .error _ =>
          match genTestFileContent pascalExercise cases #[] with
          | .error msg => throw <| IO.userError msg
          | .ok testContent =>
            IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
        | .ok json =>
          let array := getOk json.getArr?
          match genTestFileContent pascalExercise cases array with
          | .error msg => throw <| IO.userError msg
          | .ok testContent => IO.FS.writeFile s!"../exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent

def addImport (pascalExercise : String) : IO Unit := do
  let path := s!"./Generator/Generator.lean"
  try
    let crtContent <- IO.FS.readFile path
    let lines := crtContent.splitOn "Std.HashMap.ofList [\n"
    let addKey := s!"    (\"{pascalExercise}\", ({pascalExercise}Generator.genIntro, {pascalExercise}Generator.genTestCase, {pascalExercise}Generator.genEnd)),\n"
    let importGenerator := s!"import Generator.{pascalExercise}Generator\n"
    let newContent := importGenerator ++ lines.head! ++ "Std.HashMap.ofList [\n" ++ addKey ++ String.join (lines.drop 1)
    IO.FS.writeFile path newContent
  catch _ =>
    return

def generateStub (exercise : String) : IO Unit := do
  let pascalExercise := pascalCase exercise
  let content :=
s!"import Lean
import Std
import Helper

open Lean
open Std
open Helper

namespace {pascalExercise}Generator

def genIntro (exercise : String) : String := s!\"import LeanTest
import \{exercise}

open LeanTest

def \{exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \\\"\{exercise}\\\")\"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! \"input\"
  let expected := case.get! \"expected\"
  let description := case.get! \"description\"
              |> (·.compress)
  let funName := getFunName (case.get! \"property\")
  let call := s!\"(\{exercise}.\{funName} \{insertAllInputs input})\"
  s!\"
  |>.addTest \{description} (do
      return assertEqual \{expected} \{call})\"

def genEnd (exercise : String) : String :=
  s!\"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [\{exercise.decapitalize}Tests]
\"

end {pascalExercise}Generator
"
  let path := s!"./Generator/Generator/{pascalExercise}Generator.lean"
  IO.FS.writeFile path (stripWhiteSpace content ++ "\n")
  match Generator.dispatch.get? pascalExercise with
  | none => addImport pascalExercise
  | some _ => return

def main (args : List String) : IO Unit := do
  match args with
  | "-g" :: exercise :: _ =>
    generateTestFile (stripWhiteSpace exercise)
  | "--generate" :: exercise :: _ =>
    generateTestFile (stripWhiteSpace exercise)
  | "-s" :: exercise :: _ =>
    generateStub (stripWhiteSpace exercise)
  | "--stub" :: exercise :: _ =>
    generateStub (stripWhiteSpace exercise)
  | _ =>
    showUsage
