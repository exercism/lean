namespace Alphametics

private structure Letter where
  ch : Char
  leading : Nat
  rank : Nat
  weight : Array Int

private def wordSigns (tokens : List String) : List (String × Int) := Id.run do
  let mut sign : Int := -1
  let mut result : List (String × Int) := []
  for tok in tokens do
    if tok == "==" then
      sign := 1
    else if tok != "+" then
      result := (tok, sign) :: result
  return result

private def uniqueLetters (puzzle : String) : List Char :=
  puzzle.toList.filter Char.isAlpha
    |>.foldl (fun acc c => if acc.contains c then acc else c :: acc) []

private def makeLetter (words : List (String × Int)) (numCols : Nat) (ch : Char) : Letter := Id.run do
  let mut weight : Array Int := Array.replicate numCols 0
  let mut leading : Nat := 0
  for (word, sign) in words do
    let chars := word.toList.toArray
    let len := chars.size
    if len > 1 && chars[0]! == ch then
      leading := 1
    for i in [:len] do
      if chars[len - 1 - i]! == ch then
        weight := weight.set! i (weight[i]! + sign)
  let rank :=
    (List.range numCols).find? (fun col => weight[col]! != 0)
      |>.getD (numCols - 1)
  return { ch, leading, rank, weight }

private def columnSum (letters : List Letter) (mapping : List (Char × Nat)) (col : Nat) : Int :=
  letters.foldl (fun acc l =>
    acc + l.weight[col]! * (Int.ofNat (mapping.lookup l.ch |>.getD 0))) 0

-- Depth-first search. `remaining` holds letters not yet assigned,
-- sorted by rank ascending; `col` is the current column (0 = rightmost).
-- When the next letter's rank exceeds `col`, validate the column sum
-- (accounting for `carry`) and advance to the next column.
private partial def search (numCols : Nat) (allLetters : List Letter)
    (col : Nat) (carry : Int) (remaining : List Letter) (claimed : Nat)
    (mapping : List (Char × Nat)) : Option (List (Char × Nat)) :=
  let columnComplete : Bool :=
    match remaining with
    | [] => true
    | entry :: _ => entry.rank > col
  if columnComplete then
    let colSum := carry + columnSum allLetters mapping col
    if colSum % 10 != 0 then
      none
    else if col + 1 < numCols then
      search numCols allLetters (col + 1) (colSum / 10) remaining claimed mapping
    else if colSum == 0 then
      some (mapping.mergeSort (fun a b => a.1 ≤ b.1))
    else
      none
  else
    match remaining with
    | [] => none
    | entry :: rest =>
      ((List.range 10).filter (· ≥ entry.leading)).findSome? (fun digit =>
        if claimed &&& (1 <<< digit) == 0 then
          search numCols allLetters col carry rest
            (claimed ||| (1 <<< digit)) ((entry.ch, digit) :: mapping)
        else
          none)

def solve (puzzle : String) : Option (List (Char × Nat)) :=
  let words := wordSigns ((puzzle.splitOn " ").filter (· != ""))
  let numCols := (words.map (fun (w, _) => w.length)).foldl max 0
  let uniq := uniqueLetters puzzle
  let allLetters := (uniq.map (makeLetter words numCols)).mergeSort (fun a b => a.rank ≤ b.rank)
  search numCols allLetters 0 0 allLetters 0 []

end Alphametics
