# Tests

## Running Tests

To run the tests, make sure you have [Lean 4](https://lean-lang.org/) installed.

From the exercise directory, run:

```bash
lake test
```

## Solving the exercise

A solution to an exercise is a Lean module.
The module's name is defined in an _import statement_ at the beginning of the test suite:

```lean
import LeanTest
import ExerciseName

open LeanTest

def exerciseNameTests : TestSuite :=
  (TestSuite.empty "ExerciseName")
  |>.addTest "first test" (do
        return assertEqual someVal (ExerciseName.someFun someArg1 someArg2))
    ...

def main : IO UInt32 := do
  runTestSuitesWithExitCode [exerciseNameTests]
```

In this example, the test file imports, in line 2, a module named `ExerciseName`.
The test `first test` calls a funcion `ExerciseName.someFun` with arguments `someArg1` and `someArg2`.
This `ExerciseName` before `someFun` is a namespace, defined in the module with the same name, i.e., `ExerciseName`.
This means you have to create a file named `ExerciseName.lean` that looks like this:

```lean
namespace ExerciseName

def someFun (someArg1 : Type1) (someArg2 : Type2) : ReturnType :=
    ...

end ExerciseName
```

Note that tests usually call one or more function with a number of arguments.
All of them are expected to be defined in the solution module, within a namespace with the same name as the module.

Each argument and the return value for each function has some type.
This might be one of the basic types in Lean (for example, `Nat`, `List Int` or `Option String`), or a user-defined type.

You'll a find a file with the correct name already in place in the same folder as the test module.
This file should have a _stub_ with most initial informations, so that you can use it as a starting point for your solution.

Just keep in mind that this stub is there just for you to get started. 
Feel free to change it completely if you think it is the right thing to do.

## Using packages

Lean projects using Lake may always import two additional packages:

1. The core module `Lean`, which defines core elements of the language.
2. The standard library `Std`, which contains additional data structures, IO and system APIs, and other basic utilities.

Those modules may be imported and used in the same way:

```lean
import Lean
import Std

def someMap : Std.HashMap Int Nat := ...
```

Note that the module name is its namespace, so in this example the type `HashMap` was qualified with `Std`, the package where it is defined.
It is possible to open a module, so that all its data structures and functions are available without this namespace qualification:

```lean
import Std

open Std

def someSet : TreeSet String := ...
```

External packages are not directly available and must be added as a dependency in `lakefile.toml`.

While working locally, you can use any packages you like.
The online test runner, however, has access to only the default packages `Lean` and `Std`.
