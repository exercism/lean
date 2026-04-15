syntax "c*" ident:term

macro_rules
  | `(c*black)  => `((0 : Fin 10))
  | `(c*brown)  => `((1 : Fin 10))
  | `(c*red)    => `((2 : Fin 10))
  | `(c*orange) => `((3 : Fin 10))
  | `(c*yellow) => `((4 : Fin 10))
  | `(c*green)  => `((5 : Fin 10))
  | `(c*blue)   => `((6 : Fin 10))
  | `(c*violet) => `((7 : Fin 10))
  | `(c*grey)   => `((8 : Fin 10))
  | `(c*white)  => `((9 : Fin 10))
