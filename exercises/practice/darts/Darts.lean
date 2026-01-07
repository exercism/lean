namespace Darts

def distance (x : Float) (y : Float) : Float :=
  Float.sqrt (x ^ 2 + y ^ 2)

def score (x : Float) (y : Float) : Int :=
  let dist := distance x y
  if dist > 10.0 then 0
  else
    if dist > 5.0 then 1
    else
      if dist > 1.0 then 5
      else 10

end Darts
