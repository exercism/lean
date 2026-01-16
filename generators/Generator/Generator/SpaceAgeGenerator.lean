import Lean
import Std

open Lean
open Std

namespace SpaceAgeGenerator

instance {α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false

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

def toExcept (expected : Json) : Except String String :=
  match expected.getObjVal? "error" with
  | .error _ => .ok s!"{expected}"
  | .ok msg  => .error msg.compress

def exceptToString {α β} [ToString α] [ToString β] (except : Except α β) : String :=
  match except with
  | .ok value => s!"(.ok {value})"
  | .error msg => s!"(.error {msg})"

def insertAllInputs (input : Json) : String :=
  let map := getOk input.getObj?
  map.values.map (fun val => s!"{val}") |> (String.intercalate " " .)

def intLiteral (n : Int) : String :=
  if n < 0 then s!"({n})"
  else s!"{n}"

def toFloat (value : Json) : Float :=
  value.getNum? |> (getOk .) |> (·.toFloat)

def toLiteral (string : String) : String :=
  string.dropWhile (·=='"') |> (·.dropRightWhile (·=='"'))

def getFunName (property : Json) : String :=
  toLiteral property.compress

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let planet := input.getObjValD "planet" |> (·.compress) |> (toLiteral ·)
  let seconds := input.getObjValD "seconds"
  let expected := case.get! "expected" |> (toFloat .)
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {exercise}.Planet.{planet} {seconds})"
  s!"
  |>.addTest {description} (do
      return assertInRange {call} {expected - 0.01} {expected + 0.01})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end SpaceAgeGenerator
