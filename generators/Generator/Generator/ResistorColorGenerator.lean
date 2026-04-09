import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ResistorColorGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest
"

def genTestCase (_exercise : String) (case : TreeMap.Raw String Json) : String :=
  let _ := case.get! "input"
  let expected := case.get! "expected"
  let _ := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  match funName with
  | "colors" =>
    let result := expected.getArr?.map (·.map (·.compress |> toLiteral |> (s!"c!{·}"))) |> getOk
    let theorems := result.toList.mapIdx fun i color =>
      let c := color.dropPrefix "c!" |>.copy
      s!"
theorem h_{c}: {color} = ({i} : Fin 10) := by rfl"
    (String.join theorems) ++ s!"
theorem h_all: c!all = {result} := by rfl"
  | _ => ""

def genEnd (_exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
"

end ResistorColorGenerator
