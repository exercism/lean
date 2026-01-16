namespace PrimeFactors

def factors (value : Nat) : List Nat :=
  -- m is a descending measure that proves termination
  -- n is value after any already-found factors have been removed
  -- p is a candidate prime
  -- s is the step to the next candidate prime
  -- f is the factors already found
  let rec helper (m : Nat) (n : Nat) (p : Nat) (s : Nat) (f : List Nat) : List Nat :=
    match m with
    | 0 => f
    | .succ m2 =>
        if n == 1 then f
        else if n % p == 0 then helper m2 (n / p) p s (p :: f)
        else helper m2 n (p + s) (if s == 2 then 4 else 2) f
  helper value value 2 1 [] |> List.reverse

end PrimeFactors
