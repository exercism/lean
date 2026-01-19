namespace ProteinTranslation

inductive Protein where
  | Methionine : Protein
  | Phenylalanine : Protein
  | Leucine : Protein
  | Serine : Protein
  | Tyrosine : Protein
  | Cysteine : Protein
  | Tryptophan : Protein
  deriving BEq, Repr

def proteins (strand : String) : Except String (Array Protein) :=
  sorry

end ProteinTranslation
