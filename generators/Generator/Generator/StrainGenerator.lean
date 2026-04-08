import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace StrainGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

structure StrainWrapper α where
  list : List α
  deriving BEq, Repr

instance \{α} : {exercise}.Partition α (StrainWrapper α) where
  keep fn wrapper := ⟨{exercise}.Partition.keep fn wrapper.list⟩
  discard fn wrapper := ⟨{exercise}.Partition.discard fn wrapper.list⟩

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let input := case.get! "input"
  let inputList := input.getObjValD "list"
  let type := match inputList |>.getArr? |> getOk |>.toList with
              | [] => "Nat"
              | x :: _ => if x.getNat?.isOk
                          then "Nat"
                          else if x.getStr?.isOk then "String"
                          else if x.getArrVal? 0 >>= (·.getNat?) |>.isOk then "(List Nat)"
                          else "(List String)"
  let inputPred := input.getObjValD "predicate"
                    |>.compress |> toLiteral
                    |>.replace ")" ""
                    |>.replace "fn(x -> true" s!"fun (_ : {type}) => true"
                    |>.replace "fn(x -> false" s!"fun (_ : {type}) => false"
                    |>.replace "fn(x -> contains(x," s!"fun (x : {type}) => x.contains"
                    |>.replace "fn(x -> starts_with(x," s!"fun (x : {type}) => x.startsWith"
                    |>.replace "fn(x ->" s!"fun (x : {type}) =>"

  let expected := case.get! "expected"
  let description := case.get! "description"
              |> (·.compress)
  let funName := getFunName (case.get! "property")

  let call := s!"({exercise}.Partition.{funName} ({inputPred}) input)"
  s!"
  |>.addTest {description} (do
      let input : StrainWrapper {type} := ⟨{serializeList inputList}⟩
      return assertEqual ⟨{serializeList expected}⟩ {call})"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end StrainGenerator
