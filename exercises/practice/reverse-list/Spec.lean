namespace Spec

def custom_reverse {α : Type u} : List α → List α
  | []      => []
  | x :: xs => custom_reverse xs ++ [x]

end Spec
