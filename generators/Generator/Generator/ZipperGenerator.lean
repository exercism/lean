import Lean.Data.Json
import Std
import Helper

open Lean
open Std
open Helper

namespace ZipperGenerator

def genIntro (exercise : String) : String := s!"import LeanTest
import {exercise}

open LeanTest
open {exercise}

{concatAsserts}

def initialTree : BinTree :=
  .node 1
    (.node 2
      .nil
      (.node 3 .nil .nil))
    (.node 4 .nil .nil)

def {exercise.decapitalize}Tests : TestSuite :=
  (TestSuite.empty \"{exercise}\")"

def genTestCase (_exercise : String) (_case : TreeMap.Raw String Json) : String :=
  "" -- Zipper tests are handwritten due to complex operation chaining

def genEnd (exercise : String) : String :=
  s!"

def main : IO UInt32 := do
  runTestSuitesWithExitCode [{exercise.decapitalize}Tests]
"

end ZipperGenerator
