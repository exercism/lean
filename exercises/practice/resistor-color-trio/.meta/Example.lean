import Extra

open Lean Syntax Macro

namespace ResistorColorTrio

structure ResistorValue where
  text : String

instance : Repr ResistorValue where
  reprPrec v _ := f!"{v.text}"

macro_rules
  | `(*[[ $colors,* ]]) => do
    match colors.getElems.take 3 with
    | #[c₁, c₂, c₃] =>
      match c₁, c₂, c₃ with
      | `(ident| $v₁), `(ident| $v₂), `(ident| $v₃) =>
        let str ← `(
          let total := ((10 * ↑$v₁) + ↑$v₂) * (10 ^ ↑$v₃)
          if total >= 1_000_000_000 then
            let resistance := total / 1_000_000_000
            s!"{resistance} GΩ"
          else if total >= 1_000_000 then
            let resistance := total / 1_000_000
            s!"{resistance} MΩ"
          else if total >= 1_000 then
            let resistance := total / 1_000
            s!"{resistance} kΩ"
          else s!"{total} Ω"
        )
        `(ResistorValue.mk $str)
    | _ => Lean.Macro.throwUnsupported

end ResistorColorTrio
