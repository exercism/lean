namespace LargestSeriesProduct

def slidingWindows (span : Nat) : Nat -> List Char -> List (List Char)
  | 0, _ => []
  | .succ n, xs => xs.take span :: slidingWindows span n (xs.drop 1)

def largestProduct (span : Nat) (digits : String) : Option Nat :=
  if span > digits.length then none
  else
    let numChunks := digits.length - span + 1
    let productDigits := fun (ds : List Char) =>
      ds.mapM (·.toString.toNat?) |>
      Option.map (·.foldl (· * ·) 1)
    slidingWindows span numChunks digits.toList |>
    List.mapM productDigits |>
    (·.bind List.max?)

end LargestSeriesProduct
