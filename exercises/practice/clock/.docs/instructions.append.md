# Instructions Append

To complete this exercise you need to define the data type `Clock`, add a `BEq` and a `ToString` instance, and implement the functions:

* `create`, that takes two integers, possibly negative, representing hours and minutes respectively, and creates a valid Clock.
* `add`, that takes a Clock and a number of minutes to be added to the time in the Clock, generating a new Clock.
* `subtract`, that takes a Clock and a number of minutes to be subtracted from the time in the Clock, generating a new Clock.

Note that the Clock type represents a 24 hour clock going from "00:00" to "23:59".

~~~~exercism/advanced
Note that both the hours and the minutes in a `Clock` are bounded:

- `0 <= hour < 24`
- `0 <= minute < 60`

It is idiomatic in Lean to represent such constraints at the type level, so that invalid values are _unrepresentable_.
However, this also requires _proving_ that a given value satisfies these constraints.

If you are feeling up to it, here is a good introduction to this topic:

- [Programming with Dependent Types][dependent]

[dependent]: https://lean-lang.org/functional_programming_in_lean/Programming-with-Dependent-Types/#Functional-Programming-in-Lean--Programming-with-Dependent-Types
~~~~
