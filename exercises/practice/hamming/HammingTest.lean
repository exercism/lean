import LeanTest
import Hamming

open LeanTest

def hammingTests : TestSuite :=
  (TestSuite.empty "Hamming")
  |>.addTest "empty strands" (do
      return assertEqual (some 0) (Hamming.distance "" ""))
  |>.addTest "single letter identical strands" (do
      return assertEqual (some 0) (Hamming.distance "A" "A"))
  |>.addTest "single letter different strands" (do
      return assertEqual (some 1) (Hamming.distance "G" "T"))
  |>.addTest "long identical strands" (do
      return assertEqual (some 0) (Hamming.distance "GGACTGAAATCTG" "GGACTGAAATCTG"))
  |>.addTest "long different strands" (do
      return assertEqual (some 9) (Hamming.distance "GGACGGATTCTG" "AGGACGGATTCT"))
  |>.addTest "disallow first strand longer" (do
      return assertEqual none (Hamming.distance "AATG" "AAA"))
  |>.addTest "disallow second strand longer" (do
      return assertEqual none (Hamming.distance "ATA" "AGTG"))
  |>.addTest "disallow empty first strand" (do
      return assertEqual none (Hamming.distance "" "G"))
  |>.addTest "disallow empty second strand" (do
      return assertEqual none (Hamming.distance "G" ""))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [hammingTests]
