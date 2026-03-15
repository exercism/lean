# Folding Over Range

In functional programming languages, a [fold][fold] is a common way to iterate over a collection while accumulating a result.

A fold processes the elements of a collection one by one, updating an accumulator at each step. 
To perform a fold, three things are needed:

1. A collection of elements, often stored in a `List` or an `Array`.
2. An initial value for the accumulator.
3. A function that combines the current element with the accumulator to produce a new accumulator.

For example, if we fold a collection of numbers using `0` as the initial value and addition as the combining function, the result will be the sum of all elements in the collection.

Lean provides helper functions for `List` and `Array` that generate collections of sequential numbers, which can then be processed with a fold:

```lean
def squareOfSum (number : Nat) : Nat :=
    let sum := (List.range' 1 number).foldl (fun acc x => acc + x) 0
    sum ^ 2

def sumOfSquares (number : Nat) : Nat :=
    (List.range' 1 number).foldl (init := 0) fun acc x => acc + x^2

def differenceOfSquares (number : Nat) : Nat := (squareOfSum number) - (sumOfSquares number)
```

Both [List.range'][list-range'] and [Array.range'][array-range'] create collections of consecutive natural numbers.
They take:

- a starting value (the first argument, `1` in the example), and
- a count (the second argument, `number`).

The result is a collection containing `number` values starting from the initial value.

An optional third argument specifies the _step size_, which determines how much each value increases relative to the previous one. 
If omitted, the default step is `1`, producing consecutive numbers.

Lean also defines a [fold directly for `Nat`][nat-fold]. 
Instead of folding over an explicit collection, this function iterates from `0` up to (but not including) a given number.

The folding function receives three arguments:

1. the current index,
2. a proof that the index is less than the bound, and
3. the current accumulator.

```lean
def squareOfSum (number : Nat) : Nat :=
    let sum := number.fold (init := 0) fun i _ acc => (i + 1) + acc
    sum ^ 2

def sumOfSquares (number : Nat) : Nat :=
    number.fold (fun i _ acc => acc + (i + 1) ^ 2) 0

def differenceOfSquares (number : Nat) : Nat := (squareOfSum number) - (sumOfSquares number)
```

This approach avoids explicitly creating a collection and instead performs the iteration directly over the natural numbers, which can be more efficient.

[fold]: https://en.wikipedia.org/wiki/Fold_(higher-order_function)
[list-range']: https://lean-lang.org/doc/reference/latest/Basic-Types/Linked-Lists/#List___range___
[array-range']: https://lean-lang.org/doc/reference/latest/Basic-Types/Arrays/#Array___range___
[nat-fold]: https://lean-lang.org/doc/reference/latest/Basic-Types/Natural-Numbers/#Nat___fold
