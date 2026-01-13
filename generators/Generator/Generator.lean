-- This module serves as the root of the `Generator` library.
-- Import modules here that should be built as part of the library.
import Generator.PythagoreanTripletGenerator
import Generator.ForthGenerator

import Std
import Lean

namespace Generator

abbrev introGenerator := String -> String
abbrev testCaseGenerator := String -> Std.TreeMap.Raw String Lean.Json -> String
abbrev endBodyGenerator := String -> String

def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ("PythagoreanTriplet", (PythagoreanTripletGenerator.genIntro, PythagoreanTripletGenerator.genTestCase, PythagoreanTripletGenerator.genEnd)),
    ("Forth", (ForthGenerator.genIntro, ForthGenerator.genTestCase, ForthGenerator.genEnd))
  ]

end Generator
