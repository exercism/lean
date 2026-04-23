import Extra

/-
  You are given syntax for colors already predefined using the `c*` prefix, e.g., `c*black`.
  You must then define syntax that associates a sequence of colors to a number, according to the instructions.
  The colors are within `*[[` and `]]` and separated by `, `, e.g., `*[[c*black, c*yellow, c*violet]]`.

  Note that the online test runner does not have support to the `Lean` library.
  Any solution that uses it will fail when submitted to exercism, even if correct.
  This library is not necessary to solve the exercise.

  Macros and notations are not qualified by namespace.
  For this reason, this exercise does not define a namespace.
-/
