namespace TwoFer

def twoFer (name : Option String) : String :=
  match name with
  |  none => "One for you, one for me."
  |  some person => s!"One for {person}, one for me."

end TwoFer
