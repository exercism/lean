# Hints

## General

- [Natural Numbers][nat] and [Integers][int] in the Lean reference cover `Nat` and `Int` in detail.
- All four functions need explicit parameter and return types, as usual.

## 1. Convert hours and minutes to total minutes

- An hour has `60` minutes.

## 2. Split total minutes back into hours and minutes

- Division on `Nat` rounds down.
- You can use `/` to divide two numbers, and `%` to get the remainder of a division.

## 3. Calculate the water left in a canteen

- `Nat` subtraction stops at `0`, it never goes negative.

## 4. Calculate the elevation change

- The parameters and the return type are `Int`, not `Nat`, so the result can be negative.
- A negative number needs parentheses when it is a function argument, for example `f 3 (-5)`.

[nat]: https://lean-lang.org/doc/reference/latest/Basic-Types/Natural-Numbers/
[int]: https://lean-lang.org/doc/reference/latest/Basic-Types/Integers/
