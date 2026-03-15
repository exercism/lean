# Introduction

There are multiple ways to solve `difference-of-squares`.
Some of them include:

* Recursing over numbers.
* Using known mathematical formulas.
* Folding over a range of numbers.

## Approach: Recursing over numbers

Recurse over decreasing numbers until a base case is reached, accumulating the result:

```lean
def sumN (n : Nat) (acc : Nat) : Nat :=
    if n = 0 
    then acc 
    else sumN (n - 1) (acc + n)

def squareOfSum (number : Nat) : Nat :=
    (sumN number 0) ^ 2

def sumSquareN (n : Nat) (acc : Nat) : Nat :=
    if n = 0 
    then acc 
    else sumSquareN (n - 1) (acc + (n ^ 2))

def sumOfSquares (number : Nat) : Nat :=
    sumSquareN number 0

def differenceOfSquares (number : Nat) : Nat := (squareOfSum number) - (sumOfSquares number)
```

For more details, see the [recurse-numbers][recurse-numbers] approach.

## Approach: Using mathematical formulas

Compute the results directly using mathematical formulas:

```lean
def sumFirstNPositive (n : Nat) : Nat :=
    n * (n + 1) / 2

def squareOfSum (number : Nat) : Nat :=
    (sumFirstNPositive number) ^ 2

def sumOfSquares (number : Nat) : Nat :=
    (number * (number + 1) * (2 * number + 1)) / 6

def differenceOfSquares (number : Nat) : Nat :=
    (squareOfSum number) - (sumOfSquares number)
```

For more details, see the [mathematical-formula][mathematical-formula] approach.

## Approach: Folding over range

Use a `fold` to iterate over a range of values and accumulate the result:

```lean
def squareOfSum (number : Nat) : Nat :=
    let sum := number.fold (init := 0) fun i _ acc => (i + 1) + acc
    sum ^ 2

def sumOfSquares (number : Nat) : Nat :=
    number.fold (fun i _ acc => acc + (i + 1) ^ 2) 0

def differenceOfSquares (number : Nat) : Nat := (squareOfSum number) - (sumOfSquares number)
```

For more details, see the [folding-over-range][folding-over-range] approach.

[recurse-numbers]: https://exercism.org/tracks/lean/exercises/difference-of-squares/approaches/recurse-numbers
[mathematical-formula]: https://exercism.org/tracks/lean/exercises/difference-of-squares/approaches/mathematical-formula
[folding-over-range]: https://exercism.org/tracks/lean/exercises/difference-of-squares/approaches/folding-over-range
