namespace Anagram

def charMap : String -> Vector Nat 26 :=
  String.foldl (fun map char =>
    let idx := char.toUpper.toNat - 'A'.toNat
    map.set! idx (map[idx]! + 1)
  ) (Vector.replicate 26 0)

def findAnagrams (subject : String) : List String -> List String :=
  let subjectCharMap := charMap subject
  List.filter (fun str =>
    let candidate := str.toUpper
    let candidateCharMap := charMap candidate
    candidate != subject && candidateCharMap == subjectCharMap
  )

end Anagram
