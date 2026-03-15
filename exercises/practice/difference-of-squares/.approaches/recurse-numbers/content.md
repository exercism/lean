# Recurse All

In functional languages like Lean, recursion often fills the same role as loops in other languages.
It is the primary tool used to iterate over a group of elements or a range of values.

This exercise can be solved using straightforward recursion:

```lean
def sumFirstNPositive (n : Nat) : Nat :=
    match n with
    | 0     => 0
    | x + 1 => (x + 1) + sumFirstNPositive x 

def squareOfSum (number : Nat) : Nat :=
    (sumFirstNPositive number) ^ 2

def sumOfSquares (number : Nat) : Nat :=
    match number with
    | 0     => 0
    | x + 1 => (x + 1) * (x + 1) + sumOfSquares x

def differenceOfSquares (number : Nat) : Nat :=
    (squareOfSum number) - (sumOfSquares number)
```

In cases like this, where a function is defined as a simple pattern match on a value, there is an equivalent and more concise notation:

```lean
def sumFirstNPositive : Nat -> Nat
    | 0     => 0
    | x + 1 => (x + 1) + sumFirstNPositive x 

def squareOfSum (number : Nat) : Nat :=
    (sumFirstNPositive number) ^ 2

def sumOfSquares : Nat -> Nat
    | 0     => 0
    | x + 1 => (x + 1) * (x + 1) + sumOfSquares x

def differenceOfSquares (number : Nat) : Nat :=
    (squareOfSum number) - (sumOfSquares number)
```

It is also possible to use `if...then...else` to achieve the same effect:

```lean
def sumN (n : Nat) :=
    if n = 0 then 0 else n + sumN (n - 1)

def squareOfSum (number : Nat) : Nat :=
    (sumN number) ^ 2

def sumOfSquares (number : Nat) : Nat :=
    if number = 0 then 0 else number ^ 2 + sumOfSquares (number - 1)

def differenceOfSquares (number : Nat) : Nat := (squareOfSum number) - (sumOfSquares number)
```

Both functions can also be made [tail-recursive][tail-call] by adding an extra accumulating parameter:

```lean
def sumN (n : Nat) (acc : Nat) : Nat :=
    if n = 0 then acc else sumN (n - 1) (acc + n)

def squareOfSum (number : Nat) : Nat :=
    (sumN number 0) ^ 2

def sumSquareN (n : Nat) (acc : Nat) : Nat :=
    if n = 0 then acc else sumSquareN (n - 1) (acc + (n ^ 2))

def sumOfSquares (number : Nat) : Nat :=
    sumSquareN number 0

def differenceOfSquares (number : Nat) : Nat := (squareOfSum number) - (sumOfSquares number)
```

A tail-recursive function may be optimized by the compiler so that it does not require additional stack space, making it as efficient as a loop.

This approach has the advantage of being clear and self-documenting.
The problem involves summing a range of numbers, and that is exactly what the code expresses.

However, it is also inefficient, since it requires as many recursive calls as `number`, the argument to the functions. 
Even a tail-recursive variant still requires iterating over all values from `0` up to `number`.

[tail-call]: https://en.wikipedia.org/wiki/Tail_call
