import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ResistorColorDuoGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest
"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
              |>.getObjValD "colors"
              |>.getArr? |> getOk
              |>.map (·.compress |> toLiteral |> (s!"c*{·}"))
              |>.toList
              |> String.intercalate ", "
              |> (s!"*[[{·}]]")
  let expected := case.get! "expected"
  let _ := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let _ := s!"({exercise}.{funName} {insertAllInputs input})"
  s!"
/--
  info: {expected}
-/
#guard_msgs(info, drop all) in
#eval {input}
"

def genEnd (_exercise : String) : String :=
  s!"
def main : IO UInt32 := do
  runTestSuitesWithExitCode []
"

end ResistorColorDuoGenerator
