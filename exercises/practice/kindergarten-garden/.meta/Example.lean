namespace KindergartenGarden

inductive Plant where
  | grass | clover | radishes | violets
  deriving BEq, Repr

def lookup (letter : Char) : Plant :=
  match letter with
  | 'C' => .clover
  | 'R' => .radishes
  | 'V' => .violets
  | _ => .grass

def plants (diagram : String) (student: String) : Vector Plant 4 :=
  let letters := diagram.toSlice.startPos
  let first := 2 * (student.front.val.toNat - 65)
  let second := first + 1
  let third := (diagram.length + 1) / 2 + first
  let fourth := third + 1
  let firstPlant := first |> letters.nextn |> (·.get!) |> lookup
  let secondPlant := second |> letters.nextn |> (·.get!) |> lookup
  let thirdPlant := third |> letters.nextn |> (·.get!) |> lookup
  let fourthPlant := fourth |> letters.nextn |> (·.get!) |> lookup
  { toArray := #[firstPlant, secondPlant, thirdPlant, fourthPlant], size_toArray := by simp }

end KindergartenGarden
