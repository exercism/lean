declare_syntax_cat colors
syntax "c*" ident : colors

macro_rules
  | `(colors|c*black)  => `((0 : Fin 10))
  | `(colors|c*brown)  => `((1 : Fin 10))
  | `(colors|c*red)    => `((2 : Fin 10))
  | `(colors|c*orange) => `((3 : Fin 10))
  | `(colors|c*yellow) => `((4 : Fin 10))
  | `(colors|c*green)  => `((5 : Fin 10))
  | `(colors|c*blue)   => `((6 : Fin 10))
  | `(colors|c*violet) => `((7 : Fin 10))
  | `(colors|c*grey)   => `((8 : Fin 10))
  | `(colors|c*white)  => `((9 : Fin 10))

syntax "*[[" colors,* "]]" : term
