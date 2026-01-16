namespace Say

def upToTeens : Array String := #[
  "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
  "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
]

def tens : Array String := #[
  "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
]

def say (number : Fin 999999999999) : String :=
  let rec helper := fun n =>
    if n >= 1000000000 then
      let billion := n / 1000000000
      let rest := n % 1000000000
      if rest == 0 then helper billion ++ " billion"
      else helper billion ++ " billion " ++ helper rest
    else if n >= 1000000 then
      let million := n / 1000000
      let rest := n % 1000000
      if rest == 0 then helper million ++ " million"
      else helper million ++ " million " ++ helper rest
    else if n >= 1000 then
      let thousand := n / 1000
      let rest := n % 1000
      if rest == 0 then helper thousand ++ " thousand"
      else helper thousand ++ " thousand " ++ helper rest
    else if n >= 100 then
      let hundred := n / 100
      let rest := n % 100
      if rest == 0 then helper hundred ++ " hundred"
      else helper hundred ++ " hundred " ++ helper rest
    else if n >= 20 then
      let ten := n / 10
      let rest := n % 10
      if rest == 0 then tens[ten - 2]!
      else tens[ten - 2]! ++ "-" ++ helper rest
    else upToTeens[n]!
  helper number.val

end Say
