import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ResistorColorTrioGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest
"

def genTestCase (_exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
              |>.getObjValD "colors"
              |>.getArr? |> getOk
              |>.map (·.compress |> toLiteral |> (s!"c*{·}"))
              |>.toList
              |> String.intercalate ", "
              |> (s!"*[[{·}]]")
  let expected := case.get! "expected"
  let value := expected.getObjValD "value"
  let unit := match expected.getObjValD "unit" |>.compress |> toLiteral with
    | "ohms" => " Ω"
    | "kiloohms" => " kΩ"
    | "megaohms" => " MΩ"
    | "gigaohms" => " GΩ"
    | _ => ""
  s!"
/--
  info: {value}{unit}
-/
#guard_msgs(info, drop all) in
#eval {input}
"

def genEnd (_exercise : String) : String :=
  s!"
def main : IO UInt32 := do
  runTestSuitesWithExitCode []
"

end ResistorColorTrioGenerator
