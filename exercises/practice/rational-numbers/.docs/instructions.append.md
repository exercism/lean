# Instructions append

## Proving properties

In this exercise, you must define a `RationalNumber` type which represents a fully reduced, valid, rational number.
This is enforced directly by a property that is part of the type itself.

Encoding specifications and constraints directly at the type level makes invalid states effectively unrepresentable.
However, this also places an additional burden on the programmer, who must prove that the property always holds.

[This chapter][introduction] provides a good introduction to theorem proving in Lean.
For a deeper dive, [this book][advanced] is listed as an official resource on the Lean website.

You might also want to check a [reference][reference] for the language.

[introduction]: https://lean-lang.org/functional_programming_in_lean/Programming___-Proving___-and-Performance/
[advanced]: https://lean-lang.org/theorem_proving_in_lean4/
[reference]: https://lean-lang.org/doc/reference/latest/Tactic-Proofs/#tactics
