# About

Lean is a general-purpose, dependently typed, strict, pure functional programming language with an integrated proof assistant.
It is used to write programs together with machine-checked correctness guarantees and is widely applied in the formal verification of software and mathematics.

**Dependently typed** means that types can depend on values.
This allows specifications and constraints to be encoded directly in the type system, making invalid states effectively _unrepresentable_.
Lean is based on the propositions-as-types principle, where logical propositions are represented as types and proofs are programs inhabiting those types.
Every value of a type that encodes a specification must be constructed in a way that _proves_ it is valid.

**Strict evaluation** means that function arguments are evaluated eagerly, giving a deterministic evaluation order.
This simplifies reasoning about program behavior and performance.
Lean supports laziness, but only explicitly.

**Purely functional** means that functions do not mutate state or have hidden side effects.
A pure function always returns the same value for the same input, effects must be made explicit and controlled.

Lean is compiled ahead of time to native code.
Its runtime system features non-tracing garbage collection and efficient in-place updates for unshared data.
