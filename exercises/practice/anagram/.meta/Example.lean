namespace Anagram

def charMap : String -> Vector Nat 26 :=
  String.foldl (fun map char =>
    let idx := char.toNat - 'A'.toNat
    map.set! idx (map[idx]! + 1)
  ) (Vector.replicate 26 0)

def findAnagrams (subject : String) : List String -> List String :=
  let upperSubject := subject.toUpper
  let subjectCharMap := charMap upperSubject
  List.filter (fun candidate =>
    let upperCandidate := candidate.toUpper
    let candidateCharMap := charMap upperCandidate
    upperCandidate != upperSubject && candidateCharMap == subjectCharMap
  )

end Anagram
