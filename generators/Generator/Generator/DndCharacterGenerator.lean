import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace DndCharacterGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{concatAsserts}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  match funName with
  | "modifier" =>
    let score := input.getObjValD "score"
    let call := s!"({exercise}.{funName} {score})"
    s!"
    |>.addTest {description} (do
        return assertEqual {intLiteral (expected.getInt? |> getOk)} {call})"
  | "ability" =>
    s!"
    |>.addTest {description} (do
        let expectedFreqs : Array Nat := #[
          100, 400, 1000, 2100, 3800,
          6200, 9100, 12200, 14800, 16700,
          17200, 16000, 13100, 9400, 5400, 2100
        ]
        let mut actualFreqs := Array.replicate 16 0
        let mut assert := AssertionResult.success
        let mut generator := mkStdGen 1812433253
        for _ in [:129600] do
          let (ability, newGen) := {exercise}.{funName} generator
          generator := newGen
          assert := assert ++ assertInRange ability 3 18
          actualFreqs := actualFreqs.modify (ability - 3) (· + 1)
        let mut sumFreqs := 0.0
        for i in [:expectedFreqs.size] do
          let expected := expectedFreqs[i]!
          let squared := (actualFreqs[i]! - expected) ^ 2
          sumFreqs := sumFreqs + (squared.toFloat / expected.toFloat)
        let result := (sumFreqs * 1000).toUInt32.toNat
        assert := assert ++ assertInRange result 0 44263
        return assert)"
  | _ => Id.run do
    let characters := #[
      "wulfgar",
      "artemisEntreri",
      "drizztDoUrden",
      "elminster",
      "cattieBrie",
      "regis"
    ]
    let abilities := #[
      "strength",
      "dexterity",
      "constitution",
      "intelligence",
      "wisdom",
      "charisma"
    ]

    let template (name : String) (last : Bool) := Id.run do
      let mut char :=
        if !last
        then s!"let ({name}, newGen) := {exercise}.Character.new generator
      generator := newGen"
        else s!"let ({name}, _) := {exercise}.Character.new generator"
      for ability in abilities do
        char := char ++ s!"\n      assert := assert ++ assertInRange {name}.{ability} 3 18"
      return char ++ s!"\n      assert := assert ++ assertEqual (10 + {exercise}.modifier {name}.constitution) {name}.hitpoints"

    let mut acc := #[]
    for i in [:6] do
      let character := characters[i]!
      acc := acc.push (template character (i == 5))
    let string := String.intercalate "\n      " acc.toList
    return s!"
    |>.addTest {description} (do
      let mut assert := AssertionResult.success
      let mut generator := mkStdGen 1812433253
      {string}
      return assert)"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end DndCharacterGenerator
