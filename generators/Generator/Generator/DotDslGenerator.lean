import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace DotDslGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import Extra
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def getAttrs (obj : Json) : Array String :=
  if obj.isNull then #[]
  else
    obj.getObj?
    |> getOk
    |>.toArray
    |>.map (fun (pair : String × Json) =>
      let lit := toLiteral s!"{pair.2}"
      s!"⟨\"{pair.1}\", \"{lit}\"⟩")

def space : String := "          "

def genTestCase (_exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
              |>.getObjValD "text"
              |>.getArr? |> getOk
              |>.toList
              |>.map (fun j => s!"        {j}")
              |>.map (fun s => s.replace "--" "-")
              |>.map (fun s => s.replace "\"" "")
              |>.map (fun s => s.replace "\\" "\"")
  let mid := input.drop 1
              |>.dropLast
              |>.map fun s =>
                let trimmed := s.trimAscii
                if trimmed.endsWith ";"
                then s
                else s.push ';'
  let graph := (input.take 1 ++ mid ++ [input.getLast!])
              |> String.intercalate s!"\n"
              |>.trimAscii.copy

  let expected := case.get! "expected"
  let description := case.get! "description"
            |> (·.compress)
  match expected.getObjVal? "error" with
  | .ok _ => ""
  | .error _ =>
    let nodes := expected.getObjValD "nodes"
                |>.getObj? |> getOk
                |>.toList
                |>.flatMap (fun (name, attrs) => [
                    s!"{space}\{",
                    s!"{space}  name := \"{name}\",",
                    s!"{space}  attrs := {getAttrs attrs}",
                    s!"{space}},"
                  ]
                )
                |> String.intercalate s!"\n"
                |>.trimAscii
                |>.dropSuffix ","
    let edges := expected.getObjValD "edges"
                |>.getObj? |> getOk
                |>.toList
                |>.flatMap (fun (nodes, attrs) =>
                  let nodes' := nodes.replace "{" ""
                              |>.replace "}" ""
                              |>.splitOn " "
                  let attrs' := getAttrs attrs
                  match nodes' with
                  | [a, b] => [
                    s!"{space}\{",
                    s!"{space}  node₁ := ⟨\"{a}\", #[]⟩,",
                    s!"{space}  node₂ := ⟨\"{b}\", #[]⟩,",
                    s!"{space}  attrs := {attrs'}",
                    s!"{space}},"
                  ]
                  | _ => []
                )
                |> String.intercalate s!"\n"
                |>.trimAscii
                |>.dropSuffix ","
    let attrs := expected.getObjValD "attrs"
                |> getAttrs
                |>.map (fun str => s!"{space}  {str},\n")
                |>.toList
                |> String.join
                |>.dropSuffix ",\n"
                |>.copy
                |> (fun str => if str.isEmpty then "#[]" else "#[\n" ++ str ++ s!"\n{space}]")
    let call := s!"{graph}"
    s!"
    |>.addTest {description} (do
        let tree : Extra.Tree := \{
          nodes := #[{nodes}],
          edges := #[{edges}],
          attrs := {attrs}
        }
        return assertEqual tree {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end DotDslGenerator
