namespace RomanNumerals

def place (ten : Char) (five : Char) (one : Char) (number : Nat) : String :=
  match number with
  | 9 => String.ofList [one, ten]
  | 4 => String.ofList [one, five]
  | _ => String.ofList ((List.replicate (number / 5) five) ++ (List.replicate (number % 5) one))

def roman (number : Fin 4000) : String :=
  let thousands := place '_' '_' 'M' (number / 1000)
  let hundreds  := place 'M' 'D' 'C' (number / 100 % 10)
  let tens      := place 'C' 'L' 'X' (number / 10 % 10)
  let units     := place 'X' 'V' 'I' (number % 10)
  thousands ++ hundreds ++ tens ++ units

end RomanNumerals
