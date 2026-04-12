## General

- The tactic [`funext`][funext] can reduce a proof of equality between functions to proving that they return the same value for all possible arguments.
It introduces a new argument into the proof, representing an input applied to both functions.

- Using `@` before a function makes all [implicit parameters][implicit-parameters] explicit.
That means type variables can be brought into scope with `funext`.

- The [`induction` tactic][induction-tactic] is often useful for constructing proofs by [mathematical induction][mathematical-induction] on inductive types.

- Simplification tactics such as [`simp`][simp] may help after applying induction.

- There are many `List` lemmas that can serve as a starting point for your proof.
They are listed in the [API reference][api-reference], particularly in [Init.Data.List.Basic][list-basic] and [Init.Data.List.Lemmas][list-lemmas].

[funext]: https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference/#funext-next
[implicit-parameters]: https://lean-lang.org/doc/reference/latest/Terms/Functions/#implicit-functions
[induction-tactic]: https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference/#induction
[mathematical-induction]: https://en.wikipedia.org/wiki/Mathematical_induction
[simp]: https://lean-lang.org/doc/reference/4.19.0//Tactic-Proofs/Tactic-Reference/#simp
[api-reference]: https://lean-lang.org/doc/api/
[list-basic]: https://lean-lang.org/doc/api/Init/Data/List/Basic.html
[list-lemmas]: https://lean-lang.org/doc/api/Init/Data/List/Lemmas.html
