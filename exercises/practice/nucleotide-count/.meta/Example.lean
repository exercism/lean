namespace NucleotideCount

inductive Nucleotide where
  | A | C | G | T

structure Counts where
  counts : Vector Nat 4
  deriving Repr

instance : GetElem Counts Nucleotide Nat (fun _ _ => True) where
  getElem
    | { counts }, .A, _ => counts[0]
    | { counts }, .C, _ => counts[1]
    | { counts }, .G, _ => counts[2]
    | { counts }, .T, _ => counts[3]

def nucleotideCounts (strand : String) : Option Counts :=
  strand.toSlice.chars.foldM (init := { counts := Vector.replicate 4 0 }) fun
    | { counts }, 'A' => some { counts := counts.set 0 (counts[0] + 1) }
    | { counts }, 'C' => some { counts := counts.set 1 (counts[1] + 1) }
    | { counts }, 'G' => some { counts := counts.set 2 (counts[2] + 1) }
    | { counts }, 'T' => some { counts := counts.set 3 (counts[3] + 1) }
    | _, _ => none

end NucleotideCount
