namespace Raindrops

def convert (number : Nat) : String :=
  let sound := fun (factor : Nat) (name : String) =>
    if number % factor == 0 then name
    else ""
  let sounds := (sound 3 "Pling") ++ (sound 5 "Plang") ++ (sound 7 "Plong")
  if sounds == "" then toString number
  else sounds

end Raindrops
