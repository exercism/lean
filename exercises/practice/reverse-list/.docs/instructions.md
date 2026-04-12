# Instructions

Your task is to prove the equality between a custom list reversing function and the built-in `List.reverse`.

Due to the nature of this exercise, instead of relying on traditional runtime tests, the proof is checked by a theorem `check`.
You may consider the test passing if this theorem typechecks.

If you work locally or in Lean's [online playground][playground], you will get instant feedback on whether any theorem succeeds or fails, and why it fails, through Lean InfoView.
It is an invaluable tool, capable of showing all local values in use by your proof, and your current goal.

[playground]: https://live.lean-lang.org/

~~~~exercism/caution
The `sorry` tactic makes any proof appear to be correct. 
For this reason, the `check` theorem might appear to automatically typecheck before any proof is actually written.
Once you remove `sorry` from your proof, Lean InfoView will show the correct feedback.
~~~~
