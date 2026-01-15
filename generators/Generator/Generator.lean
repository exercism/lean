-- This module serves as the root of the `Generator` library.
-- Import modules here that should be built as part of the library.
import Generator.PythagoreanTripletGenerator
import Generator.GrainsGenerator
import Generator.LeapGenerator
import Generator.ForthGenerator
import Generator.TriangleGenerator
import Generator.Anagram

import Std
import Lean

namespace Generator

abbrev introGenerator := String -> String
abbrev testCaseGenerator := String -> Std.TreeMap.Raw String Lean.Json -> String
abbrev endBodyGenerator := String -> String
abbrev extraCasesList := List String

def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ("PythagoreanTriplet", (PythagoreanTripletGenerator.genIntro, PythagoreanTripletGenerator.genTestCase, PythagoreanTripletGenerator.genEnd)),
    ("Grains", (GrainsGenerator.genIntro, GrainsGenerator.genTestCase, GrainsGenerator.genEnd)),
    ("Leap", (LeapGenerator.genIntro, LeapGenerator.genTestCase, LeapGenerator.genEnd)),
    ("Forth", (ForthGenerator.genIntro, ForthGenerator.genTestCase, ForthGenerator.genEnd)),
    ("Triangle", (TriangleGenerator.genIntro, TriangleGenerator.genTestCase, TriangleGenerator.genEnd)),
    ("Anagram", (AnagramGenerator.genIntro, AnagramGenerator.genTestCase, AnagramGenerator.genEnd))
  ]

def extraCases : Std.HashMap String extraCasesList :=
  Std.HashMap.ofList [
    ("Anagram", AnagramGenerator.extraCases),
    ("PythagoreanTriplet", PythagoreanTripletGenerator.extraCases)
  ]

end Generator
