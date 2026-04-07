namespace PhoneNumber

def clean (phrase : String) : Option String := Id.run do
  if phrase.any (fun (c : Char) => c > '9') then none
  else
    let mut digits := phrase.toList.filter Char.isDigit
    if digits.length == 11 && digits[0]! == '1' then
      digits := List.tail? digits |> Option.get!
    if digits.length != 10 || digits[0]! <= '1' || digits[3]! <= '1' then none
    else some (digits |> String.ofList)

end PhoneNumber
