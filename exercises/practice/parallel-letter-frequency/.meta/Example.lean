import Std

namespace ParallelLetterFrequency

def countText (text : String) : Std.TreeMap Char Nat :=
  text.foldl (fun acc ch =>
    if ch.isAlpha
    then acc.alter ch.toLower (fun
          | none => some 1
          | some v => some (v + 1)
        )
    else acc
  ) {}

def calculateFrequencies (texts : List String) : IO (Std.TreeMap Char Nat) :=
  let tasks := texts.map (fun text => Task.spawn (fun () => countText text))
  return Task.get (Task.mapList (·.foldl (·.foldl (fun acc k v1 =>
      acc.alter k (fun
        | none => some v1
        | some v2 => some (v1 + v2)
      )
    ) · )
  {} ) tasks)

end ParallelLetterFrequency
