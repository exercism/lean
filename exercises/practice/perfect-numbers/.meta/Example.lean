namespace PerfectNumbers

def Positive := { x : Nat // x > 0 }

inductive Classification where
  | abundant  : Classification
  | perfect   : Classification
  | deficient : Classification
  deriving BEq, Repr

def getFactors (number : Nat) (factor : Nat) (acc : List Nat) : List Nat :=
  if factor < number then
    if number % factor == 0 then
      getFactors number (factor + 1) (factor :: acc)
    else
      getFactors number (factor + 1) acc
  else acc

def classify (number : Positive) : Classification :=
  let factors := getFactors number.val 1 []
  let sum := factors.foldl (· + ·) 0
  match compare sum number.val with
  | .lt => .deficient
  | .gt => .abundant
  | .eq => .perfect

end PerfectNumbers
