# Instructions append

## Proving theorems in Lean

Theorem proving is an integral part of Lean.
It empowers programmers to prove properties about their programs, reason about their behavior, and encode constraints and specifications at the type level.

[This chapter][introduction] provides a good introduction to theorem proving in Lean.
For a deeper dive, [this book][advanced] is listed as an official resource on the Lean website.

Lean offers many tactics that can automate proofs, or parts of them. 
You might want to check a [language reference][reference].

~~~~exercism/advanced
We can use the compiler attribute `csimp` on a theorem proving equality between two definitions.
This attribute instructs the compiler to use the second definition in place of the first:

```lean
@[csimp]
theorem custom_reverse_eq_spec_reverse : @Extra.custom_reverse = @List.reverse := by
    ... -- proof here

-- now any occurrence of `Extra.custom_reverse` may now compile to `List.reverse`.
```

It is particularly useful in situations where an implementation is more efficient but less clear.
We can write a simple specification and have compiled code use the more efficient implementation instead.
Many `List` and `Array` functions use this pattern.
~~~~

[introduction]: https://lean-lang.org/functional_programming_in_lean/Programming___-Proving___-and-Performance/
[advanced]: https://lean-lang.org/theorem_proving_in_lean4/
[reference]: https://lean-lang.org/doc/reference/latest/Tactic-Proofs/#tactics
