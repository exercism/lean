import Std

namespace SgfParsing

structure SgfTree where
  properties : Std.TreeMap String (Array String)
  children   : Array SgfTree
  deriving Repr

def parse (encoded : String) : Except String SgfTree :=
  sorry --remove this line and implement the function

end SgfParsing
