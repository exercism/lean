namespace Bob

def response (heyBob : String) : String := Id.run do
  let mut empty := true
  let mut question := false
  let mut upper := false
  let mut lower := false
  for c in heyBob.toList.filter (fun c => c > ' ') do
    empty := false
    question := c == '?'
    upper := upper || (Char.isUpper c)
    lower := lower || (Char.isLower c)
  let yell := upper && !lower

  if yell && !question then "Whoa, chill out!"
  else if yell then "Calm down, I know what I'm doing!"
  else if question then "Sure."
  else if empty then "Fine. Be that way!"
  else "Whatever."

end Bob
