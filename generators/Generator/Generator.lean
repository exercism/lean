import Generator.TransposeGenerator
import Generator.GameOfLifeGenerator
import Generator.WordyGenerator
import Generator.ParallelLetterFrequencyGenerator
import Generator.ComplexNumbersGenerator
import Generator.AllergiesGenerator
import Generator.ProteinTranslationGenerator
import Generator.PerfectNumbersGenerator
import Generator.GrepGenerator
import Generator.RectanglesGenerator
import Generator.SeriesGenerator
import Generator.SpaceAgeGenerator
import Generator.PrimeFactorsGenerator
import Generator.AllYourBaseGenerator
import Generator.SayGenerator
import Generator.AcronymGenerator
import Generator.BinarySearchGenerator
import Generator.CryptoSquareGenerator
import Generator.PythagoreanTripletGenerator
import Generator.PhoneNumberGenerator
import Generator.RomanNumeralsGenerator
import Generator.ArmstrongNumbersGenerator
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

def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ("Transpose", (TransposeGenerator.genIntro, TransposeGenerator.genTestCase, TransposeGenerator.genEnd)),
    ("GameOfLife", (GameOfLifeGenerator.genIntro, GameOfLifeGenerator.genTestCase, GameOfLifeGenerator.genEnd)),
    ("Wordy", (WordyGenerator.genIntro, WordyGenerator.genTestCase, WordyGenerator.genEnd)),
    ("ParallelLetterFrequency", (ParallelLetterFrequencyGenerator.genIntro, ParallelLetterFrequencyGenerator.genTestCase, ParallelLetterFrequencyGenerator.genEnd)),
    ("ComplexNumbers", (ComplexNumbersGenerator.genIntro, ComplexNumbersGenerator.genTestCase, ComplexNumbersGenerator.genEnd)),
    ("Allergies", (AllergiesGenerator.genIntro, AllergiesGenerator.genTestCase, AllergiesGenerator.genEnd)),
    ("ProteinTranslation", (ProteinTranslationGenerator.genIntro, ProteinTranslationGenerator.genTestCase, ProteinTranslationGenerator.genEnd)),
    ("PerfectNumbers", (PerfectNumbersGenerator.genIntro, PerfectNumbersGenerator.genTestCase, PerfectNumbersGenerator.genEnd)),
    ("Grep", (GrepGenerator.genIntro, GrepGenerator.genTestCase, GrepGenerator.genEnd)),
    ("Rectangles", (RectanglesGenerator.genIntro, RectanglesGenerator.genTestCase, RectanglesGenerator.genEnd)),
    ("Series", (SeriesGenerator.genIntro, SeriesGenerator.genTestCase, SeriesGenerator.genEnd)),
    ("SpaceAge", (SpaceAgeGenerator.genIntro, SpaceAgeGenerator.genTestCase, SpaceAgeGenerator.genEnd)),
    ("PrimeFactors", (PrimeFactorsGenerator.genIntro, PrimeFactorsGenerator.genTestCase, PrimeFactorsGenerator.genEnd)),
    ("AllYourBase", (AllYourBaseGenerator.genIntro, AllYourBaseGenerator.genTestCase, AllYourBaseGenerator.genEnd)),
    ("Say", (SayGenerator.genIntro, SayGenerator.genTestCase, SayGenerator.genEnd)),
    ("Acronym", (AcronymGenerator.genIntro, AcronymGenerator.genTestCase, AcronymGenerator.genEnd)),
    ("BinarySearch", (BinarySearchGenerator.genIntro, BinarySearchGenerator.genTestCase, BinarySearchGenerator.genEnd)),
    ("CryptoSquare", (CryptoSquareGenerator.genIntro, CryptoSquareGenerator.genTestCase, CryptoSquareGenerator.genEnd)),
    ("PythagoreanTriplet", (PythagoreanTripletGenerator.genIntro, PythagoreanTripletGenerator.genTestCase, PythagoreanTripletGenerator.genEnd)),
    ("PhoneNumber", (PhoneNumberGenerator.genIntro, PhoneNumberGenerator.genTestCase, PhoneNumberGenerator.genEnd)),
    ("RomanNumerals", (RomanNumeralsGenerator.genIntro, RomanNumeralsGenerator.genTestCase, RomanNumeralsGenerator.genEnd)),
    ("ArmstrongNumbers", (ArmstrongNumbersGenerator.genIntro, ArmstrongNumbersGenerator.genTestCase, ArmstrongNumbersGenerator.genEnd)),
    ("Grains", (GrainsGenerator.genIntro, GrainsGenerator.genTestCase, GrainsGenerator.genEnd)),
    ("Leap", (LeapGenerator.genIntro, LeapGenerator.genTestCase, LeapGenerator.genEnd)),
    ("Forth", (ForthGenerator.genIntro, ForthGenerator.genTestCase, ForthGenerator.genEnd)),
    ("Triangle", (TriangleGenerator.genIntro, TriangleGenerator.genTestCase, TriangleGenerator.genEnd)),
    ("Anagram", (AnagramGenerator.genIntro, AnagramGenerator.genTestCase, AnagramGenerator.genEnd))
  ]

end Generator
