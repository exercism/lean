import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ReverseListGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest

theorem check: @Spec.custom_reverse = @List.reverse := by
  exact {exercise}.custom_reverse_eq_spec_reverse"

def genTestCase (_exercise : String) (_case : TreeMap.Raw String Json) : String := ""

def genEnd (_exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
"

end ReverseListGenerator
