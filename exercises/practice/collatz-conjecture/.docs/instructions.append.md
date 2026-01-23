# Instructions append

## Subtypes

This exercise defines a Subtype called `Positive`, for all natural numbers greater than 0.
A Subtype can be thought of as a pair `⟨x, h⟩`, where x is the value and h is the proof of its validity.

The value inside a Subtype (x, in this case) can be accessed by using .val, for example, `x.val`.
Its proof can be accessed by using .property, for example, `x.property`.
Both can also be accessed by pattern matching, as usual.

In order to construct a value for a Subtype, it is necessary to prove its validity, in this case, that the number is greater than 0.

There are a number of lemmas and theorems in Lean that may serve as a starting point for this proof.
For example, `Nat.zero_lt_succ` is a lemma that asserts that for any natural number `n`: `0 < n + 1`.

~~~~exercism/advanced
A good reference for theorem proving in Lean can be found in [the core documentation][theorem-proving].

[theorem-proving]: https://lean-lang.org/theorem_proving_in_lean4/
~~~~

## Proof of termination

In Lean, recursive functions must prove their termination.
This proof is sometimes straightforward, following implicitly from the structure of a function.
In other cases, it must be made explicit.

In this exercise, the termination of the function is precisely the `collatz conjecture`, which is an open mathematical problem.

Consider using one of the following options:

1. Adding the `partial` keyword before the declaration of the function disables termination checking and allows for (potentially unsafe) recursive calls.
2. Imperative constructs allowed in monadic code, such as `while`, are implemented using partial recursion under the hood, so they can be used whenever termination is not enforced.
   Using the `Id` monad is a convenient way to enable these constructs in otherwise pure-looking code, without introducing additional effects.
