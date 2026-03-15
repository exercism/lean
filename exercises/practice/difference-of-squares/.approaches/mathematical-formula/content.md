# Mathematical Formula

A possible way to solve this exercise is to use [known mathematical formulas][formulas]:

* The sum of positive integers up to `n`, inclusive, is `n * (n + 1) / 2`.
  Squaring that sum gives `squareOfSum`.
* The sum of the squares of positive integers up to `n`, inclusive, is `n * (n + 1) * (2 * n + 1) / 6`.

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

This is probably the most efficient approach, since the problem reduces to a few constant multiplications and divisions, whereas the other approaches are `O(n)`.
On the other hand, the solution becomes more opaque because these formulas are not obvious from the structure of the problem. 
They require previous knowledge or further research.

[formulas]: https://en.wikipedia.org/wiki/Triangular_number
