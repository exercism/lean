# Hints

## General

- [Definitions][definitions] in the Lean reference covers `def` for both values and functions.
- If you run Lean locally, you may try out an expression with `#eval` before you write it into a `def`.
  The online editor does not show `#eval` output.

## 1. Set the price of one apple

- This is a `def` with a type, but no parameters, so it is not a function.

## 2. Calculate the revenue

- You need a `def` with one `Nat` parameter and a `Nat` return type.
- Use `*` to multiply the number of apples sold by `applePrice`.

## 3. Calculate the profit

- You need a `def` with two `Nat` parameters and a `Nat` return type.
- You can call `revenue` from inside `profit`, the same way you would call it from `#eval`.
- Use `-` to subtract the expenses from the revenue.

[definitions]: https://lean-lang.org/doc/reference/latest/Definitions/
