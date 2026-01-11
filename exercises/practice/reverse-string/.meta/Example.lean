namespace ReverseString

def reverse (value : String) : String :=
  let stringList := value.toList
  let rec helper := fun (acc : List Char) (crt : List Char) =>
    match crt with
    | [] => acc
    | x :: xs => helper (x :: acc) xs
  let reversed := helper [] stringList
  reversed.asString

end ReverseString
