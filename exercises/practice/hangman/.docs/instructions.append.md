# Instructions append

## Except

The return value of the `guess` function is of type `Except String Result`.

An [`Except ε α`][except] represents a computation that may either result in an error of type `ε` or produce a successful value of type `α`. 
It is a monad, allowing such computations to be composed.

## Reactive programming

For practical reasons, this exercise does not require a reactive programming approach.
Instead, consider implementing a [finite-state machine][finite-state-machine].

[except]: https://lean-lang.org/doc/reference/latest/Functors___-Monads-and--do--Notation/Varieties-of-Monads/#Except___error
[finite-state-machine]: https://en.wikipedia.org/wiki/Finite-state_machine
