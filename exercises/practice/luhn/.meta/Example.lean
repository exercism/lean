namespace Luhn

def value (digit : UInt32) (isOdd : Bool) : UInt32 :=
  if isOdd then digit
  else if digit < 5 then 2 * digit
  else 2 * digit - 9

def validTotal (digits : List Char) : Bool := Id.run do
  let mut count := 0
  let mut total := 0
  for digit in (List.reverse digits) do
    count := count + 1
    total := total + (value (digit.val - 48) (count % 2 != 0))
  return total % 10 == 0

def valid (value : String) : Bool := Id.run do
  let digits := value.toList.filter (fun c => c != ' ')
  return (List.length digits >= 2) && (List.all digits Char.isDigit) && (validTotal digits)

end Luhn
