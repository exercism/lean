namespace LineUp

def suffix (tens : Nat) (units : Nat) : String :=
  match tens, units with
  | 1, _ => "th"
  | _, 1 => "st"
  | _, 2 => "nd"
  | _, 3 => "rd"
  | _, _ => "th"

def format (name : String) (number : Fin 1000) : String :=
  let tens := number / 10 % 10
  let units := number % 10
  name ++ ", you are the " ++ (toString number) ++ (suffix tens units) ++ " customer we serve today. Thank you!"

end LineUp
