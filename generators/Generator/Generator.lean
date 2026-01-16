import Generator.SpaceAgeGenerator
import Generator.PrimeFactorsGenerator
import Generator.AllYourBaseGenerator
import Generator.SayGenerator
import Generator.BinarySearchGenerator
import Generator.PythagoreanTripletGenerator
import Generator.RomanNumeralsGenerator
import Generator.GrainsGenerator
import Generator.LeapGenerator
import Generator.ForthGenerator
import Generator.TriangleGenerator
import Generator.AnagramGenerator

import Std
import Lean

namespace Generator

abbrev introGenerator := String -> String
abbrev testCaseGenerator := String -> Std.TreeMap.Raw String Lean.Json -> String
abbrev endBodyGenerator := String -> String
abbrev extraCasesList := List String

def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ("SpaceAge", (SpaceAgeGenerator.genIntro, SpaceAgeGenerator.genTestCase, SpaceAgeGenerator.genEnd)),
    ("PrimeFactors", (PrimeFactorsGenerator.genIntro, PrimeFactorsGenerator.genTestCase, PrimeFactorsGenerator.genEnd)),
    ("AllYourBase", (AllYourBaseGenerator.genIntro, AllYourBaseGenerator.genTestCase, AllYourBaseGenerator.genEnd)),
    ("Say", (SayGenerator.genIntro, SayGenerator.genTestCase, SayGenerator.genEnd)),
    ("BinarySearch", (BinarySearchGenerator.genIntro, BinarySearchGenerator.genTestCase, BinarySearchGenerator.genEnd)),
    ("PythagoreanTriplet", (PythagoreanTripletGenerator.genIntro, PythagoreanTripletGenerator.genTestCase, PythagoreanTripletGenerator.genEnd)),
    ("RomanNumerals", (RomanNumeralsGenerator.genIntro, RomanNumeralsGenerator.genTestCase, RomanNumeralsGenerator.genEnd)),
    ("Grains", (GrainsGenerator.genIntro, GrainsGenerator.genTestCase, GrainsGenerator.genEnd)),
    ("Leap", (LeapGenerator.genIntro, LeapGenerator.genTestCase, LeapGenerator.genEnd)),
    ("Forth", (ForthGenerator.genIntro, ForthGenerator.genTestCase, ForthGenerator.genEnd)),
    ("Triangle", (TriangleGenerator.genIntro, TriangleGenerator.genTestCase, TriangleGenerator.genEnd)),
    ("Anagram", (AnagramGenerator.genIntro, AnagramGenerator.genTestCase, AnagramGenerator.genEnd))
  ]

end Generator
