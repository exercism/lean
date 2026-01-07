namespace Darts

def score (x : Float) (y : Float) : Int :=
  let distance := Float.sqrt (x * x + y * y)
  if distance <= 1 then 10
  else if distance <= 5 then 5
  else if distance <= 10 then 1
  else 0

end Darts
