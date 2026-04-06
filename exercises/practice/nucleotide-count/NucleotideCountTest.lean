import LeanTest
import NucleotideCount

open LeanTest

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def nucleotideCountTests : TestSuite :=
  (TestSuite.empty "NucleotideCount")
  |>.addTest "empty strand" (do
      match NucleotideCount.nucleotideCounts "" with
      | none => return (.failure "expected some but got none")
      | some count =>
        return assertEqual 0 count[NucleotideCount.Nucleotide.A]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.C]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.G]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.T])
  |>.addTest "can count one nucleotide in single-character input" (do
      match NucleotideCount.nucleotideCounts "G" with
      | none => return (.failure "expected some but got none")
      | some count =>
        return assertEqual 0 count[NucleotideCount.Nucleotide.A]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.C]
            ++ assertEqual 1 count[NucleotideCount.Nucleotide.G]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.T])
  |>.addTest "strand with repeated nucleotide" (do
      match NucleotideCount.nucleotideCounts "GGGGGGG" with
      | none => return (.failure "expected some but got none")
      | some count =>
        return assertEqual 0 count[NucleotideCount.Nucleotide.A]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.C]
            ++ assertEqual 7 count[NucleotideCount.Nucleotide.G]
            ++ assertEqual 0 count[NucleotideCount.Nucleotide.T])
  |>.addTest "strand with multiple nucleotides" (do
      match NucleotideCount.nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC" with
      | none => return (.failure "expected some but got none")
      | some count =>
        return assertEqual 20 count[NucleotideCount.Nucleotide.A]
            ++ assertEqual 12 count[NucleotideCount.Nucleotide.C]
            ++ assertEqual 17 count[NucleotideCount.Nucleotide.G]
            ++ assertEqual 21 count[NucleotideCount.Nucleotide.T])
  |>.addTest "strand with invalid nucleotides" (do
      return assertNone (NucleotideCount.nucleotideCounts "AGXXACT"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [nucleotideCountTests]
