# Instructions append

## Vectors

The return value to the `plants` function is a `Vector Plant 4`.

Vectors represent arrays with a fixed-length, which can be a runtime value.
They can be thought of as a pair consisting of an underlying `Array` and a proof that this `Array` has the necessary length.
This means that you must provide this proof in order to construct a `Vector`.

[This chapter][introduction] provides a good introduction to theorem proving in Lean.
For a deeper dive, [this book][advanced] is listed as an official resource on the Lean website.

Lean offers many tactics that can automate a proof, or parts of it. 
You might want to check a [reference][reference] for the language.

[introduction]: https://lean-lang.org/functional_programming_in_lean/Programming___-Proving___-and-Performance/
[advanced]: https://lean-lang.org/theorem_proving_in_lean4/
[reference]: https://lean-lang.org/doc/reference/latest/Tactic-Proofs/#tactics
