# Proving the Formula Approach Equivalent to the Recursive Approach

One of Lean's strong points is its integrated proof assistant.
It empowers the programmer to formally _prove_ properties about the program.

The exercise `difference-of-squares` is well positioned to showcase this feature of the language:

* There is a clear implementation using recursion that directly follows from the problem statement.
  However, its time complexity is `O(n)`, which makes it relatively slow.
  This approach is explored in [recurse-numbers][recurse-numbers].
* On the other hand, there are mathematical formulas that may be used to solve the exercise.
  They are `O(1)` but result in a less clear implementation that requires previous knowledge.
  This approach is explored in [mathematical-formula][mathematical-formula].

In particular, whenever there is more than one way to solve a problem, proving that a particular algorithm is equivalent to a reference implementation offers a high degree of trust in its correctness.

Since we are interested in clarity rather than performance, let us consider the direct recursive implementation, without tail recursion.
It will be our specification:

```lean
def sumFirstNPositive (n : Nat) : Nat :=
    match n with
    | 0     => 0
    | x + 1 => (x + 1) + sumFirstNPositive x 

def squareOfSum (number : Nat) : Nat :=
    (sumFirstNPositive number) ^ 2

def sumOfSquares (number : Nat) : Nat :=
    match number with
    | 0     => 0
    | x + 1 => (x + 1) * (x + 1) + sumOfSquares x

def differenceOfSquares (number : Nat) : Nat :=
    (squareOfSum number) - (sumOfSquares number)
```

We aim to prove that the following implementation using mathematical formulas is equivalent to our specification using recursion:

```lean
def sumFirstNPositive' (n : Nat) : Nat :=
    n * (n + 1) / 2

def squareOfSum' (number : Nat) : Nat :=
    (sumFirstNPositive number) ^ 2

def sumOfSquares' (number : Nat) : Nat :=
    (number * (number + 1) * (2 * number + 1)) / 6

def differenceOfSquares' (number : Nat) : Nat :=
    (squareOfSum number) - (sumOfSquares number)
```

Note that we have added `'` at the end of those functions to differentiate them from our specification functions.

Since `differenceOfSquares'` and `squareOfSum'` are equal to `differenceOfSquares` and `squareOfSum`, respectively, we need only to prove that `sumFirstNPositive'` is equivalent to `sumFirstNPositive` and that `sumOfSquares'` is equivalent to `sumOfSquares`.

Let us sketch a quick stub for both theorems:

```lean
theorem sumFirstNPositive_eq_sumFirstNPositive' : sumFirstNPositive = sumFirstNPositive' := by
    sorry

theorem sumOfSquares_eq_sumOfSquares' : sumOfSquares = sumOfSquares' := by
    sorry
```

Note that the proven proposition is the **type** of a value the theorem "returns".
In Lean, all propositions are types and proofs are values of that type.

The keyword `by` marks the beginning of our proof.
Right now there is nothing but `sorry`, which is a placeholder used to skip a proof or definition temporarily.
We must now implement our proof.

There are many ways to prove theorems in Lean.
Data types such as `Nat` and `List` have rich APIs, full of theorems that can serve as starting points for any proof.
In addition, Lean provides many [tactics][tactics] that can automate this process.

This is a simple way to prove both theorems, with much of the heavy lifting done by the `simp` and `grind` tactics:

```lean
theorem sumFirstNPositive_eq_sumFirstNPositive' : sumFirstNPositive = sumFirstNPositive' := by
    funext n
    induction n with
    | zero =>
      simp [sumFirstNPositive, sumFirstNPositive']
    | succ x h =>
      simp [sumFirstNPositive, sumFirstNPositive', h]
      grind

theorem sumOfSquares_eq_sumOfSquares' : sumOfSquares = sumOfSquares' := by
    funext n
    induction n with
    | zero =>
      simp [sumOfSquares, sumOfSquares']
    | succ x h =>
      simp [sumOfSquares, sumOfSquares', h]
      grind
```

Since our theorem proves equality of functions, we start by introducing a variable `n` which is to be applied to both functions.
This is what `funext n` does.
The functions will be equivalent if we can prove that, for any value of `n`, their result will be the same.

Since `n` is a `Nat`, which is a nice inductive type, we pattern match on its constructors.
This is the role of `induction n with`.

There are two possible constructors for a `Nat`: 

1. `zero`, that represents the number `0`, and 
2. `succ`, which represents the successor of a `Nat` `x`, i.e., `x + 1`.

Once we prove the equivalence holds for `zero`, showing that if it holds for `x`, it also holds for `x + 1`, is enough to prove the equivalence for all `Nat` by induction.

The proof for the case `zero` follows from the simplification of both functions.
Both `sumFirstNPositive` and `sumOfSquares` are defined to return `0` if their argument is `0`.
And substituting `0` in the formula for `sumFirstNPositive'` and `sumOfSquares'` will also result in `0`.
So the equivalence is proved, in both theorems.

In the case of a successor, however, the proof is more involved.
We leave most of the heavy lifting to `grind`, a powerful tactic that is able to automatically prove many properties involving inequalities, systems of linear equations and other situations.

Note that both theorems use `simp`.
This tactic tries to simplify a goal, i.e., what we are trying to prove, considering definitions and theorems already proven.
We use it here to make the definitions of the functions known to the theorem, so that values may be substituted and compared.

It is also possible to prove both theorems from first principles and basic properties and theorems involving `Nat`.
This is usually a manual task that involves much more work.

The following is an overly verbose proof of `sumFirstNPositive'_eq_sumFirstNPositive` that does not use `grind` or `simp` and relies on basic `Nat` theorems, congruence of functions and sequential calculations of transitive equations:

```lean
theorem sumFirstNPositive'_eq_sumFirstNPositive (n : Nat) :
  sumFirstNPositive n = sumFirstNPositive' n := by
    induction n with
    | zero      => rfl
    | succ x h₁ =>
      have h₂: (x + 1) + x * (x + 1) / 2 = (x + 1) * (x + 2) / 2 := by
        calc
          (x + 1) + x * (x + 1) / 2 = 2 * (x + 1) / 2 + x * (x + 1) / 2 := by
            have h₃: x + 1 = 2 * (x + 1) / 2 := by exact (Nat.mul_div_cancel_left (x + 1) (by decide)).symm
            exact congrArg (fun t => t + x * (x + 1) / 2) h₃
          _ = (2 * (x + 1) + x * (x + 1)) / 2 := by
            have h₃: 2 ∣ 2 * (x + 1) := by
              exact Nat.dvd_mul_right 2 (x + 1)
            have h₄: 2 ∣ x * (x + 1) := by
              have h₅: 2 ∣ x ∨ 2 ∣ (x + 1) := by
                by_cases h: x % 2 = 0
                {
                  left
                  exact Nat.dvd_iff_mod_eq_zero.mpr h
                }
                {
                  right
                  have h₆: x % 2 = 1 := by
                    exact Nat.mod_two_ne_zero.mp h
                  have h₇: (x + 1) % 2 = 0 := by
                    calc
                      (x + 1) % 2 = (x % 2 + 1) % 2 := by
                        exact Nat.add_mod x 1 2
                      _ = (1 + 1) % 2 := by
                        exact congrArg (fun t => (t + 1) % 2) h₆
                      _ = 0 := by decide
                  exact Nat.dvd_of_mod_eq_zero h₇
                }
              by_cases h: 2 ∣ x
              {
                exact Nat.dvd_mul_right_of_dvd h (x + 1)
              }
              {
                have h₆: 2 ∣ (x + 1) := by
                  exact h₅.resolve_left h
                exact Nat.dvd_mul_left_of_dvd h₆ x
              }
            have h₅: (2 * (x + 1)) % 2 + (x * (x + 1)) % 2 = 0 := by
              calc
                (2 * (x + 1)) % 2 + (x * (x + 1)) % 2 = 0 + (x * (x + 1)) % 2 := by
                  exact congrArg (fun t => t + (x * (x + 1)) % 2) (Nat.mod_eq_zero_of_dvd h₃)
                _ = 0 := by
                  exact congrArg (fun t => 0 + t) (Nat.mod_eq_zero_of_dvd h₄)
            have h₆: ∀ a b c : Nat, c ∣ a → c ∣ b → c > 0 → a / c + b / c = (a + b) / c := by
              intro a b c h₁ h₂ h₃
              rcases h₁ with ⟨k, hk⟩
              rcases h₂ with ⟨l, hl⟩
              subst hk
              subst hl
              calc
                (c * k) / c + (c * l) / c = (k * c) / c + (c * l) / c := by
                  exact congrArg (fun t => t / c + (c * l) / c) (Nat.mul_comm c k)
                _ = (k * c) / c + (l * c) / c := by
                  exact congrArg (fun t => (k * c) / c + t / c) (Nat.mul_comm c l)
                _ = k + (l * c) / c := by
                  exact congrArg (fun t => t + (l * c) / c) (Nat.mul_div_cancel k h₃)
                _ = k + l := by
                  exact congrArg (fun t => k + t) (Nat.mul_div_cancel l h₃)
                _ = (k + l) * c / c := by
                  exact (Nat.mul_div_cancel (k + l) h₃).symm
                _ = (k * c + l * c) / c := by
                  exact congrArg (fun t => t / c) (Nat.add_mul k l c)
                _ = (c * k + l * c) / c := by
                  exact congrArg (fun t => (t + l * c) / c) (Nat.mul_comm k c)
                _ = (c * k + c * l) / c := by
                  exact congrArg (fun t => (c * k + t) / c) (Nat.mul_comm l c)
            exact h₆ (2 * (x + 1)) (x * (x + 1)) 2 h₃ h₄ (by decide)
          _ = ((x + 1) * 2 + x * (x + 1)) / 2 := by
            exact congrArg (fun t => (t + x * (x + 1)) / 2) (Nat.mul_comm 2 (x + 1))
          _ = ((x + 1) * 2 + (x + 1) * x) / 2 := by
            exact congrArg (fun t => ((x + 1) * 2 + t) / 2) (Nat.mul_comm x (x + 1))
          _ = ((x + 1) * (2 + x)) / 2 := by
            exact congrArg (fun t => t / 2) (Nat.mul_add (x + 1) 2 x).symm
          _ = ((x + 1) * (x + 2)) / 2 := by
            exact congrArg (fun t => ((x + 1) * t) / 2) (Nat.add_comm 2 x)
      calc
        sumFirstNPositive (x + 1) = (x + 1) + sumFirstNPositive x := by
          rfl
        _ = (x + 1) + x * (x + 1) / 2 := by
          rw [h₁]
          rfl
        _ = (x + 1) * (x + 2) / 2 := by
          exact h₂
        _ = sumFirstNPositive' (x + 1) := by
          rfl
```

~~~~exercism/note
We can use the compiler attribute `csimp` on any proof of equivalence between two definitions.
This attribute instructs the compiler to use the second definition in place of the first:

```lean
@[csimp]
theorem sumFirstNPositive_eq_sumFirstNPositive' : sumFirstNPositive = sumFirstNPositive' := by
    ... -- proof here

-- now any occurrence of `sumFirstNPositive` will be replaced by `sumFirstNPositive'` at runtime.
```

It is particularly useful in situations where an implementation is more efficient but less clear.
We can then have a clear specification that is substituted at runtime by the more efficient implementation.
Many `List` and `Array` functions use this pattern.
~~~~

[recurse-numbers]: https://exercism.org/tracks/lean/exercises/difference-of-squares/approaches/recurse-numbers
[mathematical-formula]: https://exercism.org/tracks/lean/exercises/difference-of-squares/approaches/mathematical-formula
[tactics]: https://lean-lang.org/doc/reference/latest/Tactic-Proofs/#tactics
