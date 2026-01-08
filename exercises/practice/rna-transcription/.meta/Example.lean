namespace RnaTranscription

def complement (nucleotide : Char) : Char :=
  match nucleotide with
  | 'G' => 'C'
  | 'C' => 'G'
  | 'T' => 'A'
  | 'A' => 'U'
  | _ => nucleotide

def toRna (dna : String) : String :=
  String.map complement dna

end RnaTranscription
