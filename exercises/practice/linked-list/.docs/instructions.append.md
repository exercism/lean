# Instructions append

## Stateful data structures

In functional languages, such as Lean, most values are immutable by design.
This means updates are usually made by producing a new value.
Both the old and the new value coexist and may be referenced and used.

However, there are many situations where a _stateful_ value is desired, or even necessary.
A stateful value is updated by mutation, _replacing_ the old value rather than creating a new one.
After a mutation, only the updated value remains accessible.

Note that mutations can break some guarantees of the language.
A pure function must always return the same result for the same set of inputs, but if an input may change over time, then the function may return different results even when called with the same arguments.
Similarly, if a function can produce external changes other than returning a result, or can read from sources other than its parameters, then two calls to the same function may have different and sometimes unpredictable outcomes.

To handle such stateful behavior, Lean, like other functional languages, requires that effectful functions be wrapped in a special kind of structure that distinguishes them from pure functions.
These structures are called _monads_.

It is important to note that, although every stateful value lives inside some effectful monad, not every monad represents mutable state.
Notable examples of "pure" monads are `Option`, `Except` and `Id`.

In this exercise, you are going to define a stateful data structure called `LinkedList`.
Instances of this data structure are updated by mutation.

To support this, all functions are wrapped inside `IO`, which is the most general effectful monad in Lean.
Functions in `IO` can interact with `stdin` and `stdout`, open and write to files, spawn threads, and produce many other kinds of effects.
