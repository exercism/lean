namespace TwoFer

def twoFer : Option String -> String
  |  none => "One for you, one for me."
  |  some person => s!"One for {person}, one for me."

end TwoFer
