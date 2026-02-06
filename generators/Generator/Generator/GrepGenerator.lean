import Lean.Data.Json
import Std

open Lean
open Std

namespace GrepGenerator

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> (·.get!)

def toLiteral (string : String) : String :=
  string.dropWhile (·=='"') |> (·.dropRightWhile (·=='"'))

def getFunName (property : Json) : String :=
  toLiteral property.compress

def getResult (expected : Json) : String :=
  let array := getOk expected.getArr?
  array.foldr (fun x acc => s!"{x.compress.replace "\"" ""}\\n{acc}") ""

def argsList (json : Json) : List String :=
  getOk json.getArr? |> (·.foldr (fun x acc => s!"{x}" :: acc) [])

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let pattern := s!"{input.getObjValD "pattern"}"
  let flags := input.getObjValD "flags"
  let files := input.getObjValD "files"
  let args := List.filter (·!="\"\"") (pattern :: argsList flags ++ argsList files)
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {args})"
  match expected.getObjVal? "error" with
  | .ok error =>
    s!"
    |>.addTest {description} (do
        let (actual, _) <- IO.FS.withIsolatedStreams {call}
        let expected := \"{error |> (·.getStr? |> (getOk ·))}\\n\"
        return assertEqual expected actual)"
  | .error _  =>
    s!"
    |>.addTest {description} (do
        let (actual, _) <- IO.FS.withIsolatedStreams {call}
        let expected := \"{getResult expected}\"
        return assertEqual expected actual)"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end GrepGenerator
