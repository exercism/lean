namespace Rectangles

def vertical (top : Nat) (bottom : Nat) (lines : Array (List Char)) : Bool :=
  let upper := lines[top]!.head!
  let lower := lines[bottom]!.head!
  if (upper != '+') || (lower != '+') then false
  else Id.run do
    for row in [(top + 1):bottom] do
      let current := lines[row]!.head!
      if (current != '+') && (current != '|') then return false
    return true

-- consider all possible right columns
def sweep (acc : Nat) (top : Nat) (bottom : Nat) (columns : Nat) (lines : Array (List Char)) : Nat :=
  match columns with
  | 0 => acc
  | .succ columns2 =>
      let upper := lines[top]!.head!
      let lower := lines[bottom]!.head!
      if ((upper != '+') && (upper != '-')) || ((lower != '+') && (lower != '-')) then acc
      else
          let tails := lines.map (·.tail!)
          let acc2 :=
              if vertical top bottom lines then acc + 1
              else acc
          sweep acc2 top bottom columns2 tails

-- consider all possible left columns
def scan (acc : Nat) (top : Nat) (bottom : Nat) (columns : Nat) (lines : Array (List Char)) : Nat :=
  match columns with
  | 0 => acc
  | .succ columns2 =>
      let tails := lines.map (·.tail!)
      let acc2 :=
          if vertical top bottom lines
          then sweep acc top bottom columns2 tails
          else acc
      scan acc2 top bottom columns2 tails

def rectangles (strings : Array String) : Nat :=
  let lines := strings.map (·.toList)
  if (lines.size == 0) || (lines[0]!.length == 0) then 0
  else Id.run do
    let columns := lines[0]!.length
    let mut acc : Nat := 0
    -- consider all possible top and bottom rows
    for top in [0:lines.size] do
      for bottom in [(top + 1):lines.size] do
        acc := scan acc top bottom columns lines
    return acc

end Rectangles
