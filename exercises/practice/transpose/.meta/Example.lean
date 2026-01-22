namespace Transpose

def transpose (lines : String) : String :=
  let matrix := lines.splitOn "\n" |> (·.map (·.toList))
  let rec helper : List (List Char) -> List (List Char)
    | [] => []
    | x :: xs =>
      let tail := helper xs
      let xLen := x.length                                     -- cache value because length in List is O(n)
      let tailLen := tail.length                               -- cache value because length in List is O(n)
      let len := max xLen tailLen                              -- length of transposed line is greater of crt line's and tail's
      let left := x ++ (List.replicate (len - xLen) ' ')       -- pads as necessary to fit into length of transposed line
      let right := tail ++ (List.replicate (len - tailLen) []) -- pads as necessary to accomodate all chars in a row
      List.zipWith (· :: ·) left right                         -- adds each Char of crt line at the beginning of each transposed line
  let transposed := helper matrix
  String.intercalate "\n" $ transposed.map (·.asString)

end Transpose
