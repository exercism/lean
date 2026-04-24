import Std
import Lean.Data.Json
import Generator

open Lean
open Std

/-!
# GenerateTestFile

This script implements utilities for generating test files for exercises in the track.

## Running the generator

Run the generator from the root folder using the following command:

```lean
bin/run-generator [Options] <exercise-slug> [Extra-Parameters]
```

The following options are available:

* `-s` or `--stub`       - Generates a stub test generator in `./generators/Generator/Generator/`
* `-a` or `--add`        - Adds a practice exercise to `./exercises/practice` and generates a test file if a test generator exists.
                           The author and the difficulty of the new exercise may be passed as extra parameters.
* `-g` or `--generate`   - Generates a test file in `./exercises/practice/<exercise-slug>/`
* `-r` or `--regenerate` - Regenerates all test files with a test generator, syncing all docs and test data.
                           This option does not take any parameters.

`<exercise-slug>` is a required parameter for all options except `--regenerate`.
The slug must be in kebab-case, for example: `two-fer`.

## Test generators

Generating test files requires a test generator in `./generators/Generator/Generator/`.

This test generator must be imported in `./generators/Generator/Generator.lean` and must define the following three functions:

1. `introGenerator    : String → String`
2. `testCaseGenerator : String → Std.TreeMap.Raw String Lean.Json → String`
3. `endBodyGenerator  : String → String`

These functions must also be added to the `dispatch` table in `./generators/Generator/Generator.lean`, using the exercise name in `PascalCase` as the key.
For example:

```lean
def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ...
    ("TwoFer", (TwoFerGenerator.genIntro, TwoFerGenerator.genTestCase, TwoFerGenerator.genEnd))
    ...
  ]
```

Running the generator with `-s` or `--stub` automatically creates a stub test generator in the correct folder.
It also adds an import for it in `./generators/Generator/Generator.lean` and an entry for its functions in the `dispatch` table.

## Importing files

The test generator may `import Helper` in order to use helper functions defined in `./generators/Generator/Helper.lean`.

Note that all generator files are built by Lean each time this script runs.
Please keep dependencies to the minimum necessary.

In particular, *do not* import the entire `Lean` package.

## Adding test cases

Practice exercises get their test cases from `https://github.com/exercism/problem-specifications/`.

Additional test cases may be defined by the author in JSON format in an `extra.json` file in `exercises/practice/<exercise-slug>/.meta` folder.

The `testCaseGenerator` function is called for each case from `problem-specifications` and for any extra cases.
-/

structure OrderedMap where
  order : Array String
  map : TreeMap.Raw String Json

def OrderedMap.empty : OrderedMap := { order := #[], map := .empty }

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> Option.get!

def strip (string : String) (char : Char) : String :=
  string.dropWhile (·==char) |>.dropEndWhile (·==char) |>.copy

def pascalCase  (input : String) : String :=
  input.splitOn "-" |> List.map String.capitalize |> String.join

def setDirectory : IO Unit := do
  IO.Process.setCurrentDir ".."

def fetchConfiglet : IO Unit := do
  let _ ← IO.Process.run {
    cmd := "bin/fetch-configlet"
  }

def addPracticeExercise (exercise : String) (as : List String) : IO Unit := do
  let args := match as with
  | [] => #[exercise]
  | a :: [] => #["-a", a, exercise]
  | a :: d :: _ => #["-a", a, "-d", d, exercise]
  let child ← IO.Process.spawn {
    cmd := "bin/add-practice-exercise",
    args := args
    stdin  := .inherit
    stdout := .inherit
    stderr := .inherit
  }
  let _ <- child.wait

def getPath (exercise : String) : IO String := do
  try
    let info ← IO.Process.run {
      cmd := "bin/configlet",
      args := #["info", "-o", "-v", "d"]
    }
    let dirPrefix := "Using cached 'problem-specifications' dir: "
    let directory := info.splitOn "\n" |>
      List.filter (·.startsWith dirPrefix) |>
      List.map (·.dropPrefix dirPrefix) |>
      List.head!
    return s!"{directory}/exercises/{exercise}"
  catch _ =>
    fetchConfiglet
    let info ← IO.Process.run {
      cmd := "bin/configlet",
      args := #["info", "-o", "-v", "d"]
    }
    let dirPrefix := "Using cached 'problem-specifications' dir: "
    let directory := info.splitOn "\n" |>
      List.filter (·.startsWith dirPrefix) |>
      List.map (·.dropPrefix dirPrefix) |>
      List.head!
    return s!"{directory}/exercises/{exercise}"


def getToml (exercise : String) : IO (Except String String) := do
  let path := s!"exercises/practice/{exercise}/.meta/tests.toml"
  try
    let toml <- IO.FS.readFile path
    return .ok toml
  catch _ =>
    return .error "No toml file"

def readCanonicalData (exercise : String) : IO (Except String Json) := do
  let path <- getPath exercise
  try
    let json <- IO.FS.readFile (path ++ "/canonical-data.json")
    return Json.parse json
  catch _ =>
    return .error "No canonical data"

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
  | none => .error "No cases in canonical data"
  | some json =>
    let array := getOk json.getArr?
    processCanonicalCases tests array

def checkExtraCases (exercise : String) : IO (Except String String) := do
  try
    let json <- IO.FS.readFile (s!"exercises/practice/{exercise}/.meta/extra.json")
    return .ok json
  catch _ =>
    return .error "No extra cases found."

def readExtraCases (exercise : String) : IO (Except String Json) := do
  match ← checkExtraCases exercise with
  | .error msg => return .error msg
  | .ok extra  =>
    match Json.parse extra with
    | .error _ => return .error "Found extra cases, but they couldn't be parsed. Is it valid JSON?"
    | .ok parsed => return .ok parsed

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
    .ok (testContent.trimAscii.copy ++ "\n")

def getIncludes (toml : String) : TreeMap String String :=
  let cases := toml.splitOn "\n\n"
            |> List.map (·.splitOn "\n" |> List.map (·.trimAscii.copy))
  let includes := cases.filter (fun xs =>
    let hasInclude := xs.find? (·.trimAscii.startsWith "include")
    match hasInclude with
    | none => true
    | some string =>
      let words := string.splitOn " " |> List.map (·.trimAscii.copy) |> String.join
      words != "include=false"
  )
  includes.foldr (fun xs acc =>
    match xs with
    | uuid :: descriptionLine :: _ =>
      let formattedUUID := uuid.dropPrefix "[" |>.dropSuffix "]" |>.copy
      let description := descriptionLine.trimAscii
                        |>.dropPrefix "description"
                        |>.trimAsciiStart
                        |>.dropPrefix "="
                        |>.trimAsciiStart
                        |>.copy
                        |> (strip · '"')
      acc.insert formattedUUID description
    | _ => acc
  ) Std.TreeMap.empty

def showUsage : IO Unit :=
  let usageMsg := s!"Usage is:
    bin/run-generator [Options] <exercise-slug> [Extra-Parameters]

    Options:
      -s / --stub :
        Generates a stub test generator for the exercise in `./generators/Generator/Generator/`

      -a / --add :
        Adds a practice exercise to `./exercises/practice` and then generates a test file if a test generator exists.
        The author and the difficulty of the new exercise may be passed as extra parameters.

      -g / --generate :
        Generates a test file for the exercise in `./exercises/practice/<exercise-slug>/`

      -r / --regenerate :
        Regenerates all test files with a test generator, syncing all docs and test data.
        This option does not take any parameters."
  IO.println usageMsg

def generateTestFile (exercise : String) : IO Unit := do
  let pascalExercise := pascalCase exercise
  IO.println s!"\nGenerating for {pascalExercise}"
  let maybeToml ← getToml exercise
  let mut extra := #[]
  match ← readExtraCases exercise with
  | .error msg  =>
    IO.eprintln s!"{msg} Checking canonical data."
  | .ok extraCases =>
    IO.println s!"Found extra cases."
    extra := getOk extraCases.getArr?
  match maybeToml with
  | .error msg =>
    if extra.isEmpty
    then
      IO.eprintln s!"{msg} and no extra cases found."
      match genTestFileContent pascalExercise OrderedMap.empty #[] with
      | .error msg =>
        IO.eprintln msg
      | .ok testContent =>
        IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
        IO.println s!"Added intro and ending."
    else
      IO.eprintln s!"{msg}. Trying to add extra cases."
      match genTestFileContent pascalExercise OrderedMap.empty extra with
      | .error msg =>
        IO.eprintln msg
      | .ok testContent =>
        IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
        IO.println "Extra cases successfully added."
  | .ok toml =>
    let tests := getIncludes toml
    match ← readCanonicalData exercise with
    | .error msg =>
      if extra.isEmpty
      then
        IO.eprintln s!"{msg} and no extra cases found."
        match genTestFileContent pascalExercise OrderedMap.empty #[] with
        | .error msg =>
          IO.eprintln msg
        | .ok testContent =>
          IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
          IO.println s!"Added intro and ending."
      else
        IO.eprintln s!"{msg}. Trying to add extra cases."
        match genTestFileContent pascalExercise OrderedMap.empty extra with
        | .error msg =>
          IO.eprintln msg
        | .ok testContent =>
          IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
          IO.println "Extra cases successfully added."
    | .ok canonicalData =>
      match canonicalData.getObj? with
      | .error _ =>
        if extra.isEmpty
        then
          IO.eprintln "Canonical data could not be parsed and no extra cases found."
          match genTestFileContent pascalExercise OrderedMap.empty #[] with
          | .error msg =>
            IO.eprintln msg
          | .ok testContent =>
            IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
            IO.println s!"Added intro and ending."
        else
          IO.eprintln s!"Canonical data could not be parsed. Trying to add extra cases."
          match genTestFileContent pascalExercise OrderedMap.empty extra with
          | .error msg =>
            IO.eprintln msg
          | .ok testContent =>
            IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
            IO.println "Extra cases successfully added."
      | .ok maybeMap =>
        match getCanonicalCases maybeMap tests with
        | .error msg =>
          if extra.isEmpty
          then
            IO.eprintln s!"{msg} and no extra cases found."
            match genTestFileContent pascalExercise OrderedMap.empty #[] with
            | .error msg =>
              IO.eprintln msg
            | .ok testContent =>
              IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
              IO.println s!"Added intro and ending."
          else
            IO.eprintln s!"Parsing canonical data returned error: {msg}. Trying to add extra cases."
            match genTestFileContent pascalExercise OrderedMap.empty extra with
            | .error msg =>
              IO.eprintln msg
            | .ok testContent =>
              IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
              IO.println "Extra cases successfully added."
        | .ok cases =>
          match genTestFileContent pascalExercise cases extra with
          | .error msg =>
            IO.eprintln msg
          | .ok testContent =>
            IO.FS.writeFile s!"exercises/practice/{exercise}/{pascalExercise}Test.lean" testContent
            let extraMsg := if extra.isEmpty then "" else " Extra cases successfully added."
            IO.println s!"Canonical data successfully added.{extraMsg}"

def addImport (pascalExercise : String) : IO Unit := do
  let path := s!"generators/Generator/Generator.lean"
  try
    let crtContent <- IO.FS.readFile path
    let lines := crtContent.splitOn "Std.HashMap.ofList [\n"
    let addKey := s!"    (\"{pascalExercise}\", ({pascalExercise}Generator.genIntro, {pascalExercise}Generator.genTestCase, {pascalExercise}Generator.genEnd)),\n"
    let importGenerator := s!"import Generator.{pascalExercise}Generator\n"
    let newContent := importGenerator ++ lines.head! ++ "Std.HashMap.ofList [\n" ++ addKey ++ String.join (lines.drop 1)
    IO.FS.writeFile path newContent
  catch _ =>
    return

def kebabCase (pascal : String) : String :=
  pascal.foldl (fun (acc, start) ch =>
    if start then
      (acc.push ch.toLower, false)
    else if ch.isUpper then
      (acc ++ s!"-{ch.toLower}", false)
    else (acc.push ch, false)
  ) ("", true) |>.fst

def addTemplates (pascal kebab : String) : IO Unit := do
  let paths ← System.FilePath.walkDir "templates"
  for path in paths do
    if ← path.isDir then continue
    let strPath := path.toString
    let newPath := strPath.replace "templates" s!"exercises/practice/{kebab}"
    try
      let content ← (do
        if strPath.trimAsciiEnd.endsWith "lakefile.toml" then
          IO.FS.readFile path
            >>= (return ·.replace "%{pascal_slug}" pascal)
            >>= (return ·.replace "%{kebab_slug}" kebab)
        else
          IO.FS.readFile path)
      IO.FS.writeFile newPath content
    catch _ =>
      IO.eprintln s!"Failed to add templates to {pascal}."

def regenerateTestFiles : IO Unit := do
  let _ ← IO.Process.run {
    cmd := "bin/configlet"
    args := #["sync", "-u", "--yes", "--docs", "--filepaths", "--metadata", "--tests", "include"]
  }
  for (pascal, _) in Generator.dispatch do
    let kebab := kebabCase pascal
    try
      generateTestFile kebab
      addTemplates pascal kebab
    catch msg =>
      IO.eprintln s!"Regeneration for {pascal} failed. Error logged was: {msg}"

def generateStub (exercise : String) : IO Unit := do
  let pascalExercise := pascalCase exercise
  let content :=
s!"import Lean.Data.Json
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
  let path := s!"generators/Generator/Generator/{pascalExercise}Generator.lean"
  IO.FS.writeFile path (content.trimAscii.copy ++ "\n")
  match Generator.dispatch.get? pascalExercise with
  | none => addImport pascalExercise
  | some _ => return

def main (args : List String) : IO Unit := do
  setDirectory
  match args with
  | "-a" :: exercise :: as
  | "--add" :: exercise :: as =>
    addPracticeExercise exercise as
    IO.println "\nExercise successfully added."
    generateTestFile exercise.trimAscii.copy
    IO.println "\nTest cases successfully generated."
  | "-g" :: exercise :: _
  | "--generate" :: exercise :: _ =>
    generateTestFile exercise.trimAscii.copy
    IO.println "\nTest cases successfully generated."
  | "-s" :: exercise :: _
  | "--stub" :: exercise :: _ =>
    generateStub exercise.trimAscii.copy
  | "-r" :: _
  | "--regenerate" :: _ =>
    fetchConfiglet
    regenerateTestFiles
    IO.println "\nTest cases successfully regenerated."
  | _ =>
    showUsage
