# About

Lean has two common types for whole numbers.
`Nat` is for numbers that are never negative.
`Int` is for numbers that can be negative.

## `Nat`

A plain number like `12` is a `Nat` by default.
A `Nat` has no fixed upper limit.

`Nat` supports the usual arithmetic operators.

```lean
#eval 3 + 4  -- 7
#eval 3 * 4  -- 12
#eval 7 / 2  -- 3
#eval 7 % 2  -- 1
```

`/` rounds down.
`%` gives the remainder (modulus).

### Subtraction on `Nat`

A `Nat` can never be negative.
So subtraction on `Nat` stops at `0`.

```lean
#eval 8 - 2  -- 6
#eval 8 - 20 -- 0
```

If a result would be less than `0`, Lean gives `0` instead.
This is called truncated subtraction.

## `Int`

Use `Int` when you need negative numbers.

```lean
def temperature : Int := -5
#eval temperature -- -5
```

Subtraction on `Int` does not stop at `0`.

```lean
#eval (3 : Int) - 5 -- -2
```

A negative literal needs parentheses when it is a function argument.

```lean
def addTemperatures (a b : Int) : Int :=
  a + b

#eval addTemperatures 3 (-5) -- -2
```

Without the parentheses, Lean reads `-5` as subtraction, not as a negative number.

### Division and Modulus on `Int`

Division on two positive `Int` behaves exactly like on `Nat`.

However, when one of the numbers is negative, Lean follows the mathematical convention of always having a non-negative remainder.
This remainder is chosen so that `divisor * quotient + remainder == dividend`.

That means that the result may change whether the negative number is the dividend (the number being divided) or the divisor (the number dividing the dividend):

```lean
-- negative dividend
#eval (-7 : Int) / 3 -- -3
#eval (-7 : Int) % 3 --  2

-- negative divisor
#eval 7 / (-3 : Int) -- -2
#eval 7 % (-3 : Int) --  1
```

Note that in real, mathematical, division, `-7 / 3 == 7 / -3 == -2.333...`.
In `Int` division, as a rule of thumb:

- when the divisor is positive, we take the floor (`-2.333...` becomes `-3`).
- when the divisor is negative, we take the ceiling (`-2.333...` becomes `-2`).

## Comparing numbers

You can compare numbers with `< <= > >= == !=`.

```lean
#eval 3 < 5   -- true
#eval 3 == 3  -- true
```

These comparisons return a `Bool`.
You will learn about `Bool` later.

