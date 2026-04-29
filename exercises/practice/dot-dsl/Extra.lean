namespace Extra

structure Attribute where
  property : String
  value    : String
  deriving BEq, Repr

structure Node where
  name  : String
  attrs : Array Attribute
  deriving BEq, Repr

structure Edge where
  node₁ : Node
  node₂ : Node
  attrs : Array Attribute
  deriving BEq, Repr

structure Tree where
  nodes : Array Node
  edges : Array Edge
  attrs : Array Attribute
  deriving BEq, Repr

end Extra
