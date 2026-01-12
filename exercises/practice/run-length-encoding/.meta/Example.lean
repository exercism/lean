namespace RunLengthEncoding

def encode (string : String) : String :=
  let repeats := fun (n : Nat) (letter : Char) =>
    match n with
    | 0 => []
    | 1 => [letter]
    | n => (toString n).toList ++ [letter]
  let rec loop := fun (n : Nat) (letter : Char) (letters : List Char) =>
    match letters with
    | [] => repeats n letter
    | (first :: rest) => if first == letter
                         then loop (1 + n) letter rest
                         else (repeats n letter) ++ (loop 1 first rest)
  (loop 0 '?' string.toList).asString

def decode (string : String) : String :=
  let rec process (n : Nat) (input : List Char) :=
    match input with
    | [] => []
    | (first :: rest) => if Char.isDigit first
                         then process (10 * n + first.val.toNat - 48) rest
                         else (List.replicate (max 1 n) first) ++ (process 0 rest)
  (process 0 string.toList).asString

end RunLengthEncoding
