import Generator.DndCharacterGenerator
import Generator.BankAccountGenerator
import Generator.LinkedListGenerator
import Generator.BinarySearchTreeGenerator
import Generator.BookStoreGenerator
import Generator.DominoesGenerator
import Generator.HighScoresGenerator
import Generator.IsogramGenerator
import Generator.PangramGenerator
import Generator.ScrabbleScoreGenerator
import Generator.SquareRootGenerator
import Generator.SumOfMultiplesGenerator
import Generator.SublistGenerator
import Generator.RelativeDistanceGenerator
import Generator.HouseGenerator
import Generator.TwelveDaysGenerator
import Generator.TwoBucketGenerator
import Generator.SecretHandshakeGenerator
import Generator.RationalNumbersGenerator
import Generator.GigasecondGenerator
import Generator.CamiciaGenerator
import Generator.ChangeGenerator
import Generator.YachtGenerator
import Generator.PalindromeProductsGenerator
import Generator.EliudsEggsGenerator
import Generator.EtlGenerator
import Generator.ClockGenerator
import Generator.CollatzConjectureGenerator
import Generator.DiamondGenerator
import Generator.RaindropsGenerator
import Generator.RnaTranscriptionGenerator
import Generator.RunLengthEncodingGenerator
import Generator.TransposeGenerator
import Generator.GameOfLifeGenerator
import Generator.WordyGenerator
import Generator.ParallelLetterFrequencyGenerator
import Generator.ComplexNumbersGenerator
import Generator.AllergiesGenerator
import Generator.AtbashCipherGenerator
import Generator.RotationalCipherGenerator
import Generator.ProteinTranslationGenerator
import Generator.PerfectNumbersGenerator
import Generator.GrepGenerator
import Generator.RailFenceCipherGenerator
import Generator.RectanglesGenerator
import Generator.SeriesGenerator
import Generator.SpaceAgeGenerator
import Generator.PrimeFactorsGenerator
import Generator.AllYourBaseGenerator
import Generator.IsbnVerifierGenerator
import Generator.LuhnGenerator
import Generator.SayGenerator
import Generator.AcronymGenerator
import Generator.BinarySearchGenerator
import Generator.ConnectGenerator
import Generator.CryptoSquareGenerator
import Generator.PythagoreanTripletGenerator
import Generator.PhoneNumberGenerator
import Generator.RomanNumeralsGenerator
import Generator.SatelliteGenerator
import Generator.ArmstrongNumbersGenerator
import Generator.GrainsGenerator
import Generator.LeapGenerator
import Generator.FlattenArrayGenerator
import Generator.ForthGenerator
import Generator.TriangleGenerator
import Generator.AnagramGenerator
import Generator.BobGenerator
import Generator.MatchingBracketsGenerator
import Generator.ReverseStringGenerator

import Std
import Lean.Data.Json

namespace Generator

abbrev introGenerator := String -> String
abbrev testCaseGenerator := String -> Std.TreeMap.Raw String Lean.Json -> String
abbrev endBodyGenerator := String -> String

def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ("DndCharacter", (DndCharacterGenerator.genIntro, DndCharacterGenerator.genTestCase, DndCharacterGenerator.genEnd)),
    ("BankAccount", (BankAccountGenerator.genIntro, BankAccountGenerator.genTestCase, BankAccountGenerator.genEnd)),
    ("LinkedList", (LinkedListGenerator.genIntro, LinkedListGenerator.genTestCase, LinkedListGenerator.genEnd)),
    ("BinarySearchTree", (BinarySearchTreeGenerator.genIntro, BinarySearchTreeGenerator.genTestCase, BinarySearchTreeGenerator.genEnd)),
    ("BookStore", (BookStoreGenerator.genIntro, BookStoreGenerator.genTestCase, BookStoreGenerator.genEnd)),
    ("Dominoes", (DominoesGenerator.genIntro, DominoesGenerator.genTestCase, DominoesGenerator.genEnd)),
    ("HighScores", (HighScoresGenerator.genIntro, HighScoresGenerator.genTestCase, HighScoresGenerator.genEnd)),
    ("Isogram", (IsogramGenerator.genIntro, IsogramGenerator.genTestCase, IsogramGenerator.genEnd)),
    ("Pangram", (PangramGenerator.genIntro, PangramGenerator.genTestCase, PangramGenerator.genEnd)),
    ("ScrabbleScore", (ScrabbleScoreGenerator.genIntro, ScrabbleScoreGenerator.genTestCase, ScrabbleScoreGenerator.genEnd)),
    ("SquareRoot", (SquareRootGenerator.genIntro, SquareRootGenerator.genTestCase, SquareRootGenerator.genEnd)),
    ("SumOfMultiples", (SumOfMultiplesGenerator.genIntro, SumOfMultiplesGenerator.genTestCase, SumOfMultiplesGenerator.genEnd)),
    ("Sublist", (SublistGenerator.genIntro, SublistGenerator.genTestCase, SublistGenerator.genEnd)),
    ("RelativeDistance", (RelativeDistanceGenerator.genIntro, RelativeDistanceGenerator.genTestCase, RelativeDistanceGenerator.genEnd)),
    ("House", (HouseGenerator.genIntro, HouseGenerator.genTestCase, HouseGenerator.genEnd)),
    ("TwelveDays", (TwelveDaysGenerator.genIntro, TwelveDaysGenerator.genTestCase, TwelveDaysGenerator.genEnd)),
    ("TwoBucket", (TwoBucketGenerator.genIntro, TwoBucketGenerator.genTestCase, TwoBucketGenerator.genEnd)),
    ("SecretHandshake", (SecretHandshakeGenerator.genIntro, SecretHandshakeGenerator.genTestCase, SecretHandshakeGenerator.genEnd)),
    ("RationalNumbers", (RationalNumbersGenerator.genIntro, RationalNumbersGenerator.genTestCase, RationalNumbersGenerator.genEnd)),
    ("Gigasecond", (GigasecondGenerator.genIntro, GigasecondGenerator.genTestCase, GigasecondGenerator.genEnd)),
    ("Camicia", (CamiciaGenerator.genIntro, CamiciaGenerator.genTestCase, CamiciaGenerator.genEnd)),
    ("Change", (ChangeGenerator.genIntro, ChangeGenerator.genTestCase, ChangeGenerator.genEnd)),
    ("Yacht", (YachtGenerator.genIntro, YachtGenerator.genTestCase, YachtGenerator.genEnd)),
    ("PalindromeProducts", (PalindromeProductsGenerator.genIntro, PalindromeProductsGenerator.genTestCase, PalindromeProductsGenerator.genEnd)),
    ("EliudsEggs", (EliudsEggsGenerator.genIntro, EliudsEggsGenerator.genTestCase, EliudsEggsGenerator.genEnd)),
    ("Etl", (EtlGenerator.genIntro, EtlGenerator.genTestCase, EtlGenerator.genEnd)),
    ("Clock", (ClockGenerator.genIntro, ClockGenerator.genTestCase, ClockGenerator.genEnd)),
    ("CollatzConjecture", (CollatzConjectureGenerator.genIntro, CollatzConjectureGenerator.genTestCase, CollatzConjectureGenerator.genEnd)),
    ("Diamond", (DiamondGenerator.genIntro, DiamondGenerator.genTestCase, DiamondGenerator.genEnd)),
    ("Raindrops", (RaindropsGenerator.genIntro, RaindropsGenerator.genTestCase, RaindropsGenerator.genEnd)),
    ("RnaTranscription", (RnaTranscriptionGenerator.genIntro, RnaTranscriptionGenerator.genTestCase, RnaTranscriptionGenerator.genEnd)),
    ("RunLengthEncoding", (RunLengthEncodingGenerator.genIntro, RunLengthEncodingGenerator.genTestCase, RunLengthEncodingGenerator.genEnd)),
    ("Transpose", (TransposeGenerator.genIntro, TransposeGenerator.genTestCase, TransposeGenerator.genEnd)),
    ("GameOfLife", (GameOfLifeGenerator.genIntro, GameOfLifeGenerator.genTestCase, GameOfLifeGenerator.genEnd)),
    ("Wordy", (WordyGenerator.genIntro, WordyGenerator.genTestCase, WordyGenerator.genEnd)),
    ("ParallelLetterFrequency", (ParallelLetterFrequencyGenerator.genIntro, ParallelLetterFrequencyGenerator.genTestCase, ParallelLetterFrequencyGenerator.genEnd)),
    ("ComplexNumbers", (ComplexNumbersGenerator.genIntro, ComplexNumbersGenerator.genTestCase, ComplexNumbersGenerator.genEnd)),
    ("Allergies", (AllergiesGenerator.genIntro, AllergiesGenerator.genTestCase, AllergiesGenerator.genEnd)),
    ("AtbashCipher", (AtbashCipherGenerator.genIntro, AtbashCipherGenerator.genTestCase, AtbashCipherGenerator.genEnd)),
    ("RotationalCipher", (RotationalCipherGenerator.genIntro, RotationalCipherGenerator.genTestCase, RotationalCipherGenerator.genEnd)),
    ("ProteinTranslation", (ProteinTranslationGenerator.genIntro, ProteinTranslationGenerator.genTestCase, ProteinTranslationGenerator.genEnd)),
    ("PerfectNumbers", (PerfectNumbersGenerator.genIntro, PerfectNumbersGenerator.genTestCase, PerfectNumbersGenerator.genEnd)),
    ("Grep", (GrepGenerator.genIntro, GrepGenerator.genTestCase, GrepGenerator.genEnd)),
    ("RailFenceCipher", (RailFenceCipherGenerator.genIntro, RailFenceCipherGenerator.genTestCase, RailFenceCipherGenerator.genEnd)),
    ("Rectangles", (RectanglesGenerator.genIntro, RectanglesGenerator.genTestCase, RectanglesGenerator.genEnd)),
    ("Series", (SeriesGenerator.genIntro, SeriesGenerator.genTestCase, SeriesGenerator.genEnd)),
    ("SpaceAge", (SpaceAgeGenerator.genIntro, SpaceAgeGenerator.genTestCase, SpaceAgeGenerator.genEnd)),
    ("PrimeFactors", (PrimeFactorsGenerator.genIntro, PrimeFactorsGenerator.genTestCase, PrimeFactorsGenerator.genEnd)),
    ("AllYourBase", (AllYourBaseGenerator.genIntro, AllYourBaseGenerator.genTestCase, AllYourBaseGenerator.genEnd)),
    ("IsbnVerifier", (IsbnVerifierGenerator.genIntro, IsbnVerifierGenerator.genTestCase, IsbnVerifierGenerator.genEnd)),
    ("Luhn", (LuhnGenerator.genIntro, LuhnGenerator.genTestCase, LuhnGenerator.genEnd)),
    ("Say", (SayGenerator.genIntro, SayGenerator.genTestCase, SayGenerator.genEnd)),
    ("Acronym", (AcronymGenerator.genIntro, AcronymGenerator.genTestCase, AcronymGenerator.genEnd)),
    ("BinarySearch", (BinarySearchGenerator.genIntro, BinarySearchGenerator.genTestCase, BinarySearchGenerator.genEnd)),
    ("Connect", (ConnectGenerator.genIntro, ConnectGenerator.genTestCase, ConnectGenerator.genEnd)),
    ("CryptoSquare", (CryptoSquareGenerator.genIntro, CryptoSquareGenerator.genTestCase, CryptoSquareGenerator.genEnd)),
    ("PythagoreanTriplet", (PythagoreanTripletGenerator.genIntro, PythagoreanTripletGenerator.genTestCase, PythagoreanTripletGenerator.genEnd)),
    ("PhoneNumber", (PhoneNumberGenerator.genIntro, PhoneNumberGenerator.genTestCase, PhoneNumberGenerator.genEnd)),
    ("RomanNumerals", (RomanNumeralsGenerator.genIntro, RomanNumeralsGenerator.genTestCase, RomanNumeralsGenerator.genEnd)),
    ("Satellite", (SatelliteGenerator.genIntro, SatelliteGenerator.genTestCase, SatelliteGenerator.genEnd)),
    ("ArmstrongNumbers", (ArmstrongNumbersGenerator.genIntro, ArmstrongNumbersGenerator.genTestCase, ArmstrongNumbersGenerator.genEnd)),
    ("Grains", (GrainsGenerator.genIntro, GrainsGenerator.genTestCase, GrainsGenerator.genEnd)),
    ("Leap", (LeapGenerator.genIntro, LeapGenerator.genTestCase, LeapGenerator.genEnd)),
    ("FlattenArray", (FlattenArrayGenerator.genIntro, FlattenArrayGenerator.genTestCase, FlattenArrayGenerator.genEnd)),
    ("Forth", (ForthGenerator.genIntro, ForthGenerator.genTestCase, ForthGenerator.genEnd)),
    ("Triangle", (TriangleGenerator.genIntro, TriangleGenerator.genTestCase, TriangleGenerator.genEnd)),
    ("Anagram", (AnagramGenerator.genIntro, AnagramGenerator.genTestCase, AnagramGenerator.genEnd)),
    ("Bob", (BobGenerator.genIntro, BobGenerator.genTestCase, BobGenerator.genEnd)),
    ("MatchingBrackets", (MatchingBracketsGenerator.genIntro, MatchingBracketsGenerator.genTestCase, MatchingBracketsGenerator.genEnd)),
    ("ReverseString", (ReverseStringGenerator.genIntro, ReverseStringGenerator.genTestCase, ReverseStringGenerator.genEnd))
  ]

end Generator
