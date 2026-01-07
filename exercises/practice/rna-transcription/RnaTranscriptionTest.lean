import LeanTest
import RnaTranscription

open LeanTest

def rnaTranscriptionTests : TestSuite :=
  (TestSuite.empty "RnaTranscription")
  |>.addTest "Empty RNA sequence" (do
      return assertEqual "" (RnaTranscription.toRna ""))
  |>.addTest "RNA complement of cytosine is guanine" (do
      return assertEqual "G" (RnaTranscription.toRna "C"))
  |>.addTest "RNA complement of guanine is cytosine" (do
      return assertEqual "C" (RnaTranscription.toRna "G"))
  |>.addTest "RNA complement of thymine is adenine" (do
      return assertEqual "A" (RnaTranscription.toRna "T"))
  |>.addTest "RNA complement of adenine is uracil" (do
      return assertEqual "U" (RnaTranscription.toRna "A"))
  |>.addTest "RNA complement" (do
      return assertEqual "UGCACCAGAAUU" (RnaTranscription.toRna "ACGTGGTCTTAA"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [rnaTranscriptionTests]
