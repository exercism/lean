# About

Lean is a functional programming language.
You give a name to a value or a function with the keyword `def`.

## Defining values

A `def` has a name, a type, and a value.

```lean
def applesInBasket : Nat := 12
```

This defines `applesInBasket`, a constant of type `Nat` (a natural number), with value `12`.

Lean uses `:=` for a `def`, not `=`.
`=` is for equality between expressions that already exist.

## Defining functions

A function is a `def` with parameters.
Each parameter has a name and a type, written `(name : Type)`.

```lean
def double (n : Nat) : Nat :=
  n * 2
```

This defines `double`, a function that takes one `Nat` parameter and returns a `Nat`.

You call a function by writing its name, followed by its arguments, separated by spaces.

```lean
def quadruple (n : Nat) : Nat :=
  double (double n)
```

This defines `quadruple`, which calls `double` twice.
A `def` can only use names defined earlier in the same file, so `double` has to come before `quadruple`.

Lean can sometimes work out a `def`'s type on its own.
For example, `applesInBasket` above could have been written without `: Nat`.

This guessing, however, is fragile.
It breaks when there isn't enough information to pin down a type.
For example, this happens in a function whose parameters are only used with `+` or `*`.

On this track, always write out the type of every parameter.
Also write out the return type of every `def`.
This way, neither Lean nor your reader has to guess.

## Trying out expressions with `#eval`

`#eval` evaluates an expression and shows the result.
Use it while you write your solution, to try out an expression or a function call.

```lean
#eval double 5 -- 10
```

Lines starting with `#eval` are a tool for exploring your code.
They are not part of your solution, and are not graded.

The test runner on this track does not currently print `#eval` output.
So use `#eval` to explore your code as you write it, not to check your final answer.
Remove any leftover `#eval` lines before you submit.

## Comments

A line comment starts with `--` and runs to the end of the line.

```lean
-- the price of one apple, in cents
def applePrice : Nat := 50
```

A block comment starts with `/-` and ends with `-/`, and can span several lines.

```lean
/- This function doubles its input.
   It is used in more than one place below. -/
def double (n : Nat) : Nat :=
  n * 2
```

## The namespace wrapper

Every exercise file on this track starts with a line like `namespace SomeName` and ends with `end SomeName`.
This groups your definitions under a name, so they don't clash with definitions from other files.
You don't need to do anything with it, just write your own `def`s between those two lines.
