/-
notation "c*black"  => (0 : Fin 10)
notation "c*brown"  => (1 : Fin 10)
notation "c*red"    => (2 : Fin 10)
notation "c*orange" => (3 : Fin 10)
notation "c*yellow" => (4 : Fin 10)
notation "c*green"  => (5 : Fin 10)
notation "c*blue"   => (6 : Fin 10)
notation "c*violet" => (7 : Fin 10)
notation "c*grey"   => (8 : Fin 10)
notation "c*white"  => (9 : Fin 10)
notation "c*all"    => (Array.finRange 10)
-/

syntax "c*" ident:term

macro_rules
  | `(c*black)  => `((⟨0, by decide⟩ : Fin 10))
  | `(c*brown)  => `((⟨1, by decide⟩ : Fin 10))
  | `(c*red)    => `((⟨2, by decide⟩ : Fin 10))
  | `(c*orange) => `((⟨3, by decide⟩ : Fin 10))
  | `(c*yellow) => `((⟨4, by decide⟩ : Fin 10))
  | `(c*green)  => `((⟨5, by decide⟩ : Fin 10))
  | `(c*blue)   => `((⟨6, by decide⟩ : Fin 10))
  | `(c*violet) => `((⟨7, by decide⟩ : Fin 10))
  | `(c*grey)   => `((⟨8, by decide⟩ : Fin 10))
  | `(c*white)  => `((⟨9, by decide⟩ : Fin 10))
  | `(c*all)    => `((Array.finRange 10))
