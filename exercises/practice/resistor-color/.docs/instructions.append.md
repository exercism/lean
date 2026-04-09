# Instructions append

## Defining syntax

In this exercise, you must define syntax for colors using the `c!` prefix, e.g., `c!black`.
This syntax should expand at compile time to each color's corresponding value as a `Fin 10`, according to the instructions.
In the same way, you must define syntax for an array of all color values using `c!all`.

This task will likely require you to use either notations or macros.
You might want to check a [reference][macro-reference].

Because new syntax is expanded at compile time, any test would fail to compile unless all the required syntax is defined.
For this reason, instead of relying on traditional runtime tests, we check all values using theorems.
If a theorem typechecks, you may consider it a passing test.

If you work locally or in Lean's [online playground][playground], you will get instant feedback on whether any theorem succeeds or fails, and why it fails, through Lean InfoView.

[macro-reference]: https://lean-lang.org/doc/reference/latest/Notations-and-Macros/#language-extension
[playground]: https://live.lean-lang.org/
