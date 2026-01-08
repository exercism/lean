namespace MatchingBrackets

def process (pending : Option (List Char)) (c : Char) : Option (List Char) :=
  match pending with
  | none => none
  | some list =>
      match c with
      | '[' => some (']' :: list)
      | '{' => some ('}' :: list)
      | '(' => some (')' :: list)
      | ']' | '}' | ')' => if List.head? list == some c
                           then List.tail? list
                           else none
      | _ => pending

def isPaired (value : String) : Bool :=
  some [] == String.foldl process (some []) value

end MatchingBrackets
