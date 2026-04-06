import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace NucleotideCountGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

{concatAsserts}

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let expected := case.get! "expected"
  let A := expected.getObjVal? "A" |> getOk
  let C := expected.getObjVal? "C" |> getOk
  let G := expected.getObjVal? "G" |> getOk
  let T := expected.getObjVal? "T" |> getOk
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")
  let call := s!"{exercise}.{funName} {insertAllInputs input}"
  match expected.getObjVal? "error" with
  | .ok _ =>
    s!"
  |>.addTest {description} (do
      return assertNone ({call}))"
  | .error _ =>
    s!"
  |>.addTest {description} (do
      match {call} with
      | none => return (.failure \"expected some but got none\")
      | some count =>
        return assertEqual {A} count[{exercise}.Nucleotide.A]
            ++ assertEqual {C} count[{exercise}.Nucleotide.C]
            ++ assertEqual {G} count[{exercise}.Nucleotide.G]
            ++ assertEqual {T} count[{exercise}.Nucleotide.T])"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end NucleotideCountGenerator
