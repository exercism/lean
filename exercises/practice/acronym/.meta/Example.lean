namespace Acronym

def abbreviate (phrase : String) : String :=
  let rec helper (input : List Char) (acc : List Char) (inWord : Bool) : String :=
    match input with
    | [] => (List.reverse acc).asString
    | c :: rest =>
        if Char.isAlpha c && !inWord
        then helper rest ((Char.toUpper c) :: acc) true
        else helper rest acc ((Char.isAlpha c) || (inWord && c == '\''))
  helper phrase.toList [] false

end Acronym
