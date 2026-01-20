# Instructions append

## Asynchronous tasks

[Tasks][tasks] are the primary abstraction for writing asynchronous code in Lean.
They are lightweight and may execute in parallel on another thread, or concurrently on the same thread.

Tasks can be either pure or impure.
Pure tasks are created with `Task.spawn`, which accepts a pure computation.
Impure tasks are created from `IO` computations using, for example, `IO.asTask`, which lifts an `IO α` into a `Task α` within the `IO` monad.

In this exercise, the function `calculateFrequencies` is monadic, returning a `IO (Std.TreeMap Char Nat)`.
This allows the use of impure tasks via `IO.asTask`, and also makes it possible to spawn pure tasks for intermediate computations before returning the final value.

## Preventing data races

As a functional language, most values in Lean are persistent, i.e., immutable.
Operations that appear to modify a value actually produce a new value with the requested changes.
This means that memory can often be shared safely between tasks without introducing data races.

Note, however, that not all data structures are equally well suited to persistent use.
For example, updating a single element of an `Array` usually requires copying the entire array.
The same is true for `Std.HashSet` and `Std.HashMap`.

To make such data structures efficient, Lean employs reference counting.
As long as a value has a unique reference, updates may be performed destructively, avoiding unnecessary copying.

Other data structures, such as `List`, `Std.TreeSet` and `Std.TreeMap`, are designed to share structure internally.
They reuse unchanged nodes when updates are performed, so that multiple values may share references to those nodes.
As a result, modifying one part of the structure does not usually require copying the entire value.
This makes them particularly well suited for sharing between tasks.

## Measuring execution speed

The execution time of each test is measured in nanoseconds using `IO.monoNanosNow` and shown alongside the results.
You can experiment with different approaches and check their impact on runtime performance.

[tasks]: https://lean-lang.org/doc/reference/latest/IO/Tasks-and-Threads/#Task
