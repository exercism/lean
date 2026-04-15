/-
  The solution in this comment reuses the macro already defined in `Extra.lean`.
  In order to make use of the values expanded by this macro, the expression must be evaluated in an elaborator.
  However, the tools to do that are inside `Lean.Elab`, a module not supported by the online test runner.

  For this reason, this solution is only presented here as a reference.

import Lean.Elab
import Extra

open Lean Elab Term

syntax "*[[" term,* "]]" : term

elab_rules : term
  | `(*[[ $vals,* ]]) => do
    let elems := vals.getElems

    guard (elems.size >= 2)

    let a₁ ← elabTerm elems[0]! none
    let a₂ ← elabTerm elems[1]! none

    match a₁.nat? >>= fun v₁ => a₂.nat? >>= fun v₂ => pure (v₁ * 10 + v₂) with
    | none     => throwUnsupportedSyntax
    | some sum => return Lean.mkNatLit sum
-/

import Extra

syntax "*[[" term,* "]]" : term

def getValue : Lean.TSyntax `term → Option Nat
  | `(c*black)  => some 0
  | `(c*brown)  => some 1
  | `(c*red)    => some 2
  | `(c*orange) => some 3
  | `(c*yellow) => some 4
  | `(c*green)  => some 5
  | `(c*blue)   => some 6
  | `(c*violet) => some 7
  | `(c*grey)   => some 8
  | `(c*white)  => some 9
  | _ => none

macro_rules
  | `(*[[ $vals,* ]]) => do
    let elems := vals.getElems.toList
    match elems with
    | a₁ :: a₂ :: _ =>
      match getValue a₁, getValue a₂ with
      | some v₁, some v₂ => return Lean.Syntax.mkNatLit (10 * v₁ + v₂)
      | _, _ => Lean.Macro.throwUnsupported
    | _ => Lean.Macro.throwUnsupported
