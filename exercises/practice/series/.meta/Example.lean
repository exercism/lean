namespace Series

def slices (series : String) (sliceLength : Nat) : Option (Array String) :=
  if sliceLength == 0 || sliceLength > String.length series
  then none
  else some ((Array.range ((String.length series) + 1 - sliceLength)).map (fun (n : Nat) => (series.drop n).take sliceLength))

end Series
