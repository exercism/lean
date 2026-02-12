import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace BankAccountGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}
import Std

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def toList (json : Json) : List Json :=
  getOk json.getArr? |>.toList

def spawnThread (op : String) : String := s!"let task ← IO.asTask <| do
            mutex.lock
            mutex.unlock
            {op}
          tasks := tasks.push task"

partial def recurseOps : Bool → List Json → List String
  | _, [] => []
  | f, obj :: objs =>
    let op := obj.getObjValD "operation" |>.compress |> toLiteral
    match op with
    | "open" =>
      s!"account.{op}" :: recurseOps f objs
    | "balance" =>
      let balance :=
        if f
        then s!"let balance ← account.{op}"
        else s!"let _ ← account.{op}"
      balance :: recurseOps f objs
    | "concurrent" =>
      let extraOps := obj.getObjValD "operations"
      let addOps := recurseOps f (toList extraOps)
                    |>.map (λ op => spawnThread op)
                    |>.map (λ op => op.replace "\n" "\n  ")
      let delim := s!"\n{indent}      "
      let template := s!"account.deposit 100_000
          let mutex ← Std.BaseMutex.new
          mutex.lock
          let mut tasks := #[]
          for _ in [:100_000] do
            {String.intercalate delim addOps}
          IO.sleep 100
          mutex.unlock
          for task in tasks do
            match task.get with
            | .ok ()     => pure ()
            | .error msg => throw msg
          account.withdraw 100_000"
      template
      :: recurseOps f objs
    | _ =>
      match obj.getObjVal? "amount" with
      | .error _ =>
        s!"account.{op}" :: recurseOps f objs
      | .ok val  =>
        s!"account.{op} {val}" :: recurseOps f objs

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let operations := case.get! "input"
                      |>.getObjValD "operations"
                      |> toList
  let description := case.get! "description"
              |> (·.compress)
  let expected := case.get! "expected"
  match expected.getObjVal? "error" with
  | .ok msg =>
    let ops := recurseOps false operations
    s!"
    |>.addTest {description} (do
        let account ← {exercise}.Account.create
        try
          {String.intercalate s!"\n{indent}    " ops}
          return (AssertionResult.failure \"Expected error: {toLiteral msg.compress} but operation succeeded.\")
        catch msg =>
          return assertEqual {msg} msg.toString)"
  | .error _ =>
    let ops := recurseOps true operations
    s!"
    |>.addTest {description} (do
        let account ← {exercise}.Account.create
        try
          {String.intercalate s!"\n{indent}    " ops}
          return assertEqual {expected} balance
        catch msg =>
          return (AssertionResult.failure s!\"Expected operation to succeed, but it threw: \{msg}.\"))"

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end BankAccountGenerator
