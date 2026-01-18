# Instructions append

## IO process

Unlike other exercises, `grep` requires interacting with the "external world": reading files, handling system errors and printing to `stdout`.

In Lean, interacting with the system is usually done in the [IO][io] monad, which allows for side effects to occur in a contained environment without affecting the pure state of most other functions.

## Reading arguments

Lean allows for a file to be called as a script, either directly as a standalone script via `lean --run` or with the use of `lake`.

A lean project has one point of entry, a function called `main`, that takes a `List String` with all arguments passed to it.
In order to simulate running `Grep.lean` as an executable, arguments are passed in the same way in this exercise.

## Writing output

Instead of returning a value, this exercise requires results are written to standard output or standard error.
There are [functions][console] in Lean for this purpose.

## Handling system errors

Unlike errors in `Except`, `IO` exceptions are actually runtime exceptions.
You may use `try`/`catch` to handle them:

```
try
    /- 
        code that may possibly raise an exception 
    -/
catch msg =>
    /-
        code that is executed only if an exception was thrown
    -/
```

[io]: https://lean-lang.org/doc/reference/latest/IO/#io
[console]: https://lean-lang.org/doc/reference/latest/IO/Console-Output/#The-Lean-Language-Reference--IO--Console-Output