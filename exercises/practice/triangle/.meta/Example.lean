namespace Triangle

def isValid (sides : List Float) : Bool :=
  match sides with
  | a :: b :: c :: [] => a > 0 && b > 0 && c > 0 && a <= b + c && b <= c + a && c <= a + b
  | _ => False

def equilateral (sides : List Float) : Bool :=
  isValid sides && match sides with
  | a :: b :: c :: [] => a == b && b == c && c == a
  | _ => False

def isosceles (sides : List Float) : Bool :=
  isValid sides && match sides with
  | a :: b :: c :: [] => a == b || b == c || c == a
  | _ => False

def scalene (sides : List Float) : Bool :=
  isValid sides && match sides with
  | a :: b :: c :: [] => a != b && b != c && c != a
  | _ => False

end Triangle
