namespace HighScores

def latestList (scores : List Nat) : Nat :=
  scores.getLast!

def latestArray (scores : Array Nat) : Nat :=
  scores.back!

def personalBestList (scores : List Nat) : Nat :=
  scores.max? |>.get!

def personalBestArray (scores : Array Nat) : Nat :=
  scores.getMax? (· ≤ ·) |>.get!

def personalTopThreeList (scores : List Nat) : List Nat :=
  scores.mergeSort (· ≥ ·) |>.take 3

def personalTopThreeArray (scores : Array Nat) : Array Nat := Id.run do
  let mut best : Array Nat := #[]
  for s in scores do
    if best.size < 3 then
      best := (best.push s).insertionSort (· ≥ ·)
    else if s > best[2]! then
      best := (best.set! 2 s).insertionSort (· ≥ ·)
  return best

end HighScores
