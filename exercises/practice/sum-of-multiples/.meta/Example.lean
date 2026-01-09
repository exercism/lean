namespace SumOfMultiples

def isMultiple (factors : List UInt64) (candidate : UInt64) : Bool :=
  match factors with
  | [] => false
  | (factor :: rest) => if candidate % factor == 0 then true
                        else isMultiple rest candidate

def sum (factors : List UInt64) (limit : UInt64) : UInt64 := Id.run do
  let mut result := 0
  for candidate in [1:(UInt64.toNat limit)] do
    result := result + (if isMultiple factors (UInt64.ofNat candidate) then candidate else 0)
  return (UInt64.ofNat result)

end SumOfMultiples
