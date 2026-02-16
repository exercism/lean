import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace SgfParsingGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{exceptEquality}

instance : BEq (Std.TreeMap String (Array String)) where
  beq a b := a.toList == b.toList

deriving instance BEq for SgfParsing.SgfTree

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def extractProperties (json : Json) : Array (String × Array String) :=
  getOk (json.getObjValD "properties").getObj?
    |> Std.TreeMap.Raw.map (λ _ (v : Json) => getOk v.getArr?)
    |> Std.TreeMap.Raw.map (λ _ (a : Array Json) => a.map (λ (x : Json) => s!"{x}"))
    |> Std.TreeMap.Raw.toArray
    |> Array.map (λ (k, v) => (s!"\"{k}\"", v))

partial def getResult (json : Json) : String :=
  let propertiesMap := extractProperties json
  let properties := if propertiesMap.isEmpty then "{}"
                    else s!"{propertiesMap}" |> (".ofArray " ++ ·)
  let children := getOk (json.getObjValD "children").getArr?
  if children.isEmpty then
    s!"⟨{properties}, #[]⟩"
  else
    let right := String.intercalate ", " (children.toList.map (getResult ·))
    s!"⟨{properties}, #[{right}]⟩"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"({exercise}.{funName} {insertAllInputs input})"
  let result := match expected.getObjVal? "error" with
                | .ok error => s!"(.error {error})"
                | .error _  => s!"(.ok {getResult expected})"
  s!"
  |>.addTest {description} (do
      return assertEqual {result} {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end SgfParsingGenerator
