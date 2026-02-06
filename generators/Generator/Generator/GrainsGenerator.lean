import Lean.Data.Json
import Std

open Lean
open Std

namespace GrainsGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def intLiteral (n : Int) : String :=
  if n < 0 then s!"({n})"
  else s!"{n}"

def genTestCase (exercise : String) (case : TreeMap.Raw String Json) : String :=
  let description := case.get! "description"
              |> (·.compress)
  let expected := case.get! "expected"
  match (case.get! "input").getObjVal? "square" with
  | .error _ =>
      s!"
      |>.addTest {description} (do
          return assertEqual {expected} {exercise}.totalGrains)"
  | .ok square =>
      let sq := square |> (·.getInt?) |> Except.toOption |> Option.get!
      match expected |> (·.getObjVal? "error") with
      | .ok _ =>
          s!"
          |>.addTest {description} (do
              return assertEqual none ({exercise}.grains {intLiteral sq}))"
      | .error _ =>
          s!"
          |>.addTest {description} (do
              return assertEqual (some {expected}) ({exercise}.grains {intLiteral sq}))"

def genEnd (exercise : String) : String :=
  s!"

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [{exercise.decapitalize}Tests]\n"

end GrainsGenerator
