# Instructions append

In this exercise, you will be working with **Lists** and **Arrays**.
Both are very important data structures in Lean.

## Lists

Like most functional languages, [Lists][list] are a fundamental data structure in Lean.

A List has two constructors, one for the empty list (`[]`) and another for a list containing one element (the `head`) and another list (the `tail`).
It is possible to prepend elements to a list using `::`, thus creating a new list:

```lean
let list := x :: xs -- prepending x to xs creates a new list where x is the head and xs is the tail
```

Lists are inherently recursive, which makes them well suited to inductive reasoning.
They also support structural sharing: you can prepend a new element to a list without copying the existing list:

```lean
let list1 := [1, 2]
let list2 := 0 :: list1
-- now both list1 and list2 share [1, 2]
```

However, most operations on lists take time proportional to their length, since each element must be traversed to reach the next one.

## Arrays

An [Array][array] is a dynamically-sized contiguous block of memory.

For many operations, arrays can be much more efficient than lists:

1. Accessing any element in an array is fast and runs in constant time.
2. Arrays are modeled after dynamic arrays, which tend to be particularly efficient on modern systems
due to [cache locality][locality].

Arrays are not, however, very friendly to structural sharing.
In general, updating an array in a functional setting requires copying the entire existing array.

Lean uses reference counting to mitigate this drawback.
As long as there is never more than one reference to an array (that is, it is used _linearly_), no copy is made and updates can be performed destructively.

Lean also supports [do-notation][do-notation], an embedded language for writing code in an imperative style.

Inside a `do` block, it is possible to declare mutable local variables, which can be reassigned, using the `mut` keyword.
When used with data structures such as arrays, this allows Lean's runtime system to perform in-place destructive updates under the hood, whenever it is safe to do so.

Do-notation can only be used inside a monad.
A convenient way to write imperative-style code that remains pure and has no observable side effects is to use the [Identity monad][id]:

```lean
def function (array : Array Nat) := Id.run do
    let mut sum := 0
    for element in array do
        sum := sum + element
    return sum
```

[list]: https://lean-lang.org/doc/reference/latest/Basic-Types/Linked-Lists/#List
[array]: https://lean-lang.org/doc/reference/latest/Basic-Types/Arrays/
[locality]: https://en.wikipedia.org/wiki/Locality_of_reference
[do-notation]: https://lean-lang.org/doc/reference/latest/Functors___-Monads-and--do--Notation/Syntax/#do-notation
[id]: https://lean-lang.org/doc/reference/latest/Functors___-Monads-and--do--Notation/Varieties-of-Monads/#Id
