# Instructions append

## Defining an inductive type

This exercise expects the return value to be an [inductive type][inductive] `Classification` that you must define.

This type must have a [BEq][beq] instance, i.e., it admits a Boolean equality test, and a [Repr][repr] instance, i.e., values of the type can be formatted for display.

You can refer to [this page][instance] on instance declarations.
Lean can automatically [generate instances][deriving] for many classes.

## Subtypes

The argument to the `classify` function is a [subtype][subtype] called `Positive`: 

```
def Positive := { x : Nat // x > 0 }
```

Subtypes represent elements of a particular type that satisfy a predicate.
`Positive` represents elements of `Nat` that are greater than `0`.

Any element of a subtype can be thought of as a pair consisting of a value of the underlying type and a proof, in the mathematical sense, that this value satisfies the corresponding predicate.

Subtypes enforce invariants at the type level,ensuring that ill-formed values cannot be constructed.

[inductive]: https://lean-lang.org/functional_programming_in_lean/Getting-to-Know-Lean/Datatypes-and-Patterns/#datatypes-and-patterns
[beq]: https://lean-lang.org/doc/reference/latest/Type-Classes/Basic-Classes/#BEq___mk
[repr]: https://lean-lang.org/doc/reference/4.26.0/Interacting-with-Lean/?terms=Repr#repr
[instance]: https://lean-lang.org/doc/reference/latest/Type-Classes/Deriving-Instances/#deriving-instances
[deriving]: https://lean-lang.org/doc/reference/latest/Type-Classes/Deriving-Instances/#deriving-instances
[subtype]: https://lean-lang.org/doc/reference/latest/Basic-Types/Subtypes/#Subtype___mk
