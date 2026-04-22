import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace AssembleGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (_exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let args := input.getObjValD "args"
    |>.getArr?
    |> getOk
    |>.toList
    |>.map (fun x => s!"{x}")
    |> String.intercalate ", "
  let code := input.getObjValD "code"
    |>.getArr?
    |> getOk
    |>.toList
    |>.map (fun x => toLiteral s!"{x}")
    |>.map (fun ln =>
      if ln.contains ":" then "        " ++ ln
      else "          " ++ ln
    )
    |> String.intercalate "\n"
  let expected := case.get! "expected" |>.getObjValD "rax"
  let description := case.get! "description"
              |> (·.compress)
  let call := s!"(program({args}))"
  s!"
  |>.addTest {description} (do
      let program := assemble!(
{code}
      )
      return assertEqual ({expected}) {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end AssembleGenerator
