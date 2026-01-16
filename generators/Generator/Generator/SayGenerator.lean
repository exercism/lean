import Lean
import Std

open Lean
open Std

namespace SayGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def getOk {α β} (except : Except α β) [Inhabited β] : β := except.toOption |> (·.get!)

def errorToOption (expected : Json) : Option String :=
  match expected.getObjVal? "error" with
  | .error _ => some s!"{expected}"
  | .ok _    => none

def insertAllInputs (input : Json) : String :=
  let map := getOk input.getObj?
  map.values.map (fun val => s!"{val}") |> (String.intercalate " " .)

def intLiteral (n : Int) : String :=
  if n < 0 then s!"({n})"
  else s!"{n}"

def getFunName (property : Json) : String :=
  property.compress.dropWhile (·=='"') |> (·.dropRightWhile (·=='"'))

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {insertAllInputs input})"
  s!"
  |>.addTest {description} (do
      return assertEqual {expected} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end SayGenerator
