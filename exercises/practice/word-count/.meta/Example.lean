import Std

namespace WordCount

def countWords (sentence : String) : Std.HashMap String Nat := Id.run do
  let validChar := fun x => x.isAlphanum || x == '\''
  let mut map : Std.HashMap String Nat := .emptyWithCapacity
  let mut crtSentence : String := sentence |> flip .dropWhile (!·.isAlphanum)
  while !crtSentence.isEmpty do
    let word := crtSentence.takeWhile validChar |> flip .dropRightWhile (. == '\'')
    map := map.alter word.toLower (fun maybe =>
      match maybe with
      | none => some 1
      | some x => some (x + 1)
    )
    crtSentence := crtSentence.stripPrefix word |> flip .dropWhile (!·.isAlphanum)
  return map

end WordCount
