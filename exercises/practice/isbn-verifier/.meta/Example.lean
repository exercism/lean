namespace IsbnVerifier

def isValid (isbn : String) : Bool := Id.run do
  let mut excess := -10
  let mut unweighted := 0
  let mut weighted := 0
  for c in isbn.toList.filter (fun c => c != '-') do
    excess := excess + 1
    let digit := if c == 'X' && excess == 0 then 10
                 else c.val - 48
    unweighted := unweighted + digit
    weighted := weighted + unweighted
  pure (excess == 0 && weighted % 11 == 0)

end IsbnVerifier
