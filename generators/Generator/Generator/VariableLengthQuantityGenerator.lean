import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace VariableLengthQuantityGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

deriving instance Repr for ByteArray

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def serializeHex (num : Json) : String :=
  let byte := num.getNat? |> getOk
  match Nat.toDigits 16 byte with
  | [a, b] => s!"0x{a}{b}"
  | [a]    => s!"0x0{a}"
  | _      => "0x00"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input" |>.getObjValD "integers"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  match getFunName (case.get! "property") with
  | "encode" =>
    s!"
  |>.addTest {description} (do
      let expected : ByteArray := ByteArray.mk #{serializeList expected serializeHex}
      let input : Array Nat := #{serializeList input}
      let actual : ByteArray := {exercise}.encode input
      return assertEqual expected actual)"
  | "decode" =>
    let result := match expected.getObjVal? "error" with
                  | .error _ => s!"some #{serializeList expected}"
                  | .ok _    => "none"
    let input := input
    s!"
  |>.addTest {description} (do
      let expected : Option (Array Nat) := {result}
      let input : ByteArray := ByteArray.mk #{serializeList input serializeHex}
      let actual : Option (Array Nat) := {exercise}.decode input
      return assertEqual expected actual)"
  | _ => ""

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end VariableLengthQuantityGenerator
