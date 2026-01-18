namespace ArmstrongNumbers

def extractDigits (measure : Nat) (number : Nat) (acc : List Nat) : List Nat :=
  match measure with
  | 0 => acc
  | .succ measure2 =>
      if number < 10 then number :: acc
      else extractDigits measure2 (number / 10) ((number % 10) :: acc)

def isArmstrongNumber (number : Nat) : Bool :=
  let digits := extractDigits number number []
  let exponent := List.length digits
  (List.foldl (· + ·) 0 (List.map (Nat.pow · exponent) digits)) == number

end ArmstrongNumbers
