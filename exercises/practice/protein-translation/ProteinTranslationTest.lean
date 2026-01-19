import LeanTest
import ProteinTranslation

open LeanTest

instance {α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false

def proteinTranslationTests : TestSuite :=
  (TestSuite.empty "ProteinTranslation")
  |>.addTest "Empty RNA sequence results in no proteins" (do
      return assertEqual (.ok #[]) (ProteinTranslation.proteins ""))
  |>.addTest "Methionine RNA sequence" (do
      return assertEqual (.ok #[.Methionine]) (ProteinTranslation.proteins "AUG"))
  |>.addTest "Phenylalanine RNA sequence 1" (do
      return assertEqual (.ok #[.Phenylalanine]) (ProteinTranslation.proteins "UUU"))
  |>.addTest "Phenylalanine RNA sequence 2" (do
      return assertEqual (.ok #[.Phenylalanine]) (ProteinTranslation.proteins "UUC"))
  |>.addTest "Leucine RNA sequence 1" (do
      return assertEqual (.ok #[.Leucine]) (ProteinTranslation.proteins "UUA"))
  |>.addTest "Leucine RNA sequence 2" (do
      return assertEqual (.ok #[.Leucine]) (ProteinTranslation.proteins "UUG"))
  |>.addTest "Serine RNA sequence 1" (do
      return assertEqual (.ok #[.Serine]) (ProteinTranslation.proteins "UCU"))
  |>.addTest "Serine RNA sequence 2" (do
      return assertEqual (.ok #[.Serine]) (ProteinTranslation.proteins "UCC"))
  |>.addTest "Serine RNA sequence 3" (do
      return assertEqual (.ok #[.Serine]) (ProteinTranslation.proteins "UCA"))
  |>.addTest "Serine RNA sequence 4" (do
      return assertEqual (.ok #[.Serine]) (ProteinTranslation.proteins "UCG"))
  |>.addTest "Tyrosine RNA sequence 1" (do
      return assertEqual (.ok #[.Tyrosine]) (ProteinTranslation.proteins "UAU"))
  |>.addTest "Tyrosine RNA sequence 2" (do
      return assertEqual (.ok #[.Tyrosine]) (ProteinTranslation.proteins "UAC"))
  |>.addTest "Cysteine RNA sequence 1" (do
      return assertEqual (.ok #[.Cysteine]) (ProteinTranslation.proteins "UGU"))
  |>.addTest "Cysteine RNA sequence 2" (do
      return assertEqual (.ok #[.Cysteine]) (ProteinTranslation.proteins "UGC"))
  |>.addTest "Tryptophan RNA sequence" (do
      return assertEqual (.ok #[.Tryptophan]) (ProteinTranslation.proteins "UGG"))
  |>.addTest "STOP codon RNA sequence 1" (do
      return assertEqual (.ok #[]) (ProteinTranslation.proteins "UAA"))
  |>.addTest "STOP codon RNA sequence 2" (do
      return assertEqual (.ok #[]) (ProteinTranslation.proteins "UAG"))
  |>.addTest "STOP codon RNA sequence 3" (do
      return assertEqual (.ok #[]) (ProteinTranslation.proteins "UGA"))
  |>.addTest "Sequence of two protein codons translates into proteins" (do
      return assertEqual (.ok #[.Phenylalanine, .Phenylalanine]) (ProteinTranslation.proteins "UUUUUU"))
  |>.addTest "Sequence of two different protein codons translates into proteins" (do
      return assertEqual (.ok #[.Leucine, .Leucine]) (ProteinTranslation.proteins "UUAUUG"))
  |>.addTest "Translate RNA strand into correct protein list" (do
      return assertEqual (.ok #[.Methionine, .Phenylalanine, .Tryptophan]) (ProteinTranslation.proteins "AUGUUUUGG"))
  |>.addTest "Translation stops if STOP codon at beginning of sequence" (do
      return assertEqual (.ok #[]) (ProteinTranslation.proteins "UAGUGG"))
  |>.addTest "Translation stops if STOP codon at end of two-codon sequence" (do
      return assertEqual (.ok #[.Tryptophan]) (ProteinTranslation.proteins "UGGUAG"))
  |>.addTest "Translation stops if STOP codon at end of three-codon sequence" (do
      return assertEqual (.ok #[.Methionine, .Phenylalanine]) (ProteinTranslation.proteins "AUGUUUUAA"))
  |>.addTest "Translation stops if STOP codon in middle of three-codon sequence" (do
      return assertEqual (.ok #[.Tryptophan]) (ProteinTranslation.proteins "UGGUAGUGG"))
  |>.addTest "Translation stops if STOP codon in middle of six-codon sequence" (do
      return assertEqual (.ok #[.Tryptophan, .Cysteine, .Tyrosine]) (ProteinTranslation.proteins "UGGUGUUAUUAAUGGUUU"))
  |>.addTest "Sequence of two non-STOP codons does not translate to a STOP codon" (do
      return assertEqual (.ok #[.Methionine, .Methionine]) (ProteinTranslation.proteins "AUGAUG"))
  |>.addTest "Unknown amino acids, not part of a codon, can't translate" (do
      return assertEqual (.error "Invalid codon") (ProteinTranslation.proteins "XYZ"))
  |>.addTest "Incomplete RNA sequence can't translate" (do
      return assertEqual (.error "Invalid codon") (ProteinTranslation.proteins "AUGU"))
  |>.addTest "Incomplete RNA sequence can translate if valid until a STOP codon" (do
      return assertEqual (.ok #[.Phenylalanine, .Phenylalanine]) (ProteinTranslation.proteins "UUCUUCUAAUGGU"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [proteinTranslationTests]
