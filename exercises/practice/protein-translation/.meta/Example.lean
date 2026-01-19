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

def codonToProtein : String -> Option Protein
  | "AUG" => some .Methionine
  | "UUU" => some .Phenylalanine
  | "UUC" => some .Phenylalanine
  | "UUA" => some .Leucine
  | "UUG" => some .Leucine
  | "UCU" => some .Serine
  | "UCC" => some .Serine
  | "UCA" => some .Serine
  | "UCG" => some .Serine
  | "UAU" => some .Tyrosine
  | "UAC" => some .Tyrosine
  | "UGU" => some .Cysteine
  | "UGC" => some .Cysteine
  | "UGG" => some .Tryptophan
  | _     => none

def proteins (strand : String) : Except String (Array Protein) :=
  let rec helper := fun sequence acc =>
    match sequence with
    | [] => some acc
    | _ :: [] => none
    | _ :: _ :: [] => none
    | c1 :: c2 :: c3 :: cs =>
      let codon := [c1, c2, c3].asString
      match codon with
      | "UAA" => some acc
      | "UAG" => some acc
      | "UGA" => some acc
      | _     =>
        let maybeProtein := codonToProtein codon
        match maybeProtein with
        | some protein => helper cs (protein :: acc)
        | none => none
  let result := helper strand.toList []
  match result with
  | none => .error "Invalid codon"
  | some list => .ok (list.foldr (fun x acc => acc.push x) #[])

end ProteinTranslation
