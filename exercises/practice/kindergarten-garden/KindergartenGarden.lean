namespace KindergartenGarden

inductive Plant where
  | grass | clover | radishes | violets
  deriving BEq, Repr

def plants (diagram : String) (student: String) : Vector Plant 4 :=
  sorry --remove this line and implement the function

end KindergartenGarden
