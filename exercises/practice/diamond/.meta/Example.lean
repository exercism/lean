namespace Diamond

def row (distance : Nat) : Nat -> String
  | 0     => "".pushn ' ' distance ++ "A".pushn ' ' distance --total of 2*distance + 1 for letter
  | n + 1 =>
    let midPad := 2*n + 1 -- mid padding is 1 for 'B', increasing by 2 for each letter after that
    let sidePad := distance - (n + 1) -- each letter reduces side pad by 1
    let letter := Char.ofNat $ 'A'.toNat + n + 1
    let letterStr := String.singleton letter
    "".pushn ' ' sidePad ++ letterStr.pushn ' ' midPad ++ letterStr.pushn ' ' sidePad

def rows (letter : Char) : List String :=
  let distance := letter.toNat - 'A'.toNat
  --all rows have the same size: 2*distance + 1
  if distance = 0
  then ["A"]
  else
    let top := (List.range distance).map (row distance)
    let mid := (String.singleton letter).pushn ' ' (2*distance - 1) |>.push letter
    top ++ mid :: top.reverse

end Diamond
