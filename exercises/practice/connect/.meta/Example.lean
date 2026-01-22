import Std

namespace Connect

structure Cell where
  row : Nat
  column : Nat
  deriving BEq, Hashable

def read (lines : Array (Array Char)) (cell : Cell) : Char :=
  lines[cell.row]![2 * cell.column + cell.row]!

def edges : Array (Array Int) := #[
  #[-1, 0], -- above, left
  #[-1, 1], -- above, right
  #[0, -1], -- left
  #[0,  1], -- right
  #[1, -1], -- below, left
  #[1,  0], -- below, right
]

def adjacents (rows : Nat) (columns : Nat) (cell : Cell) : List Cell := Id.run do
  let mut result := []
  for edge in edges do
    let row : Int := cell.row + edge[0]!
    let column : Int := cell.column + edge[1]!
    if 0 <= row && row < rows && 0 <= column && column < columns
    then result := { row := row.toNat, column := column.toNat } :: result
  return result

def winner (board : Array String) : Char := Id.run do
  let rows := board.size
  let columns := (board[0]!.length + 1) >>> 1
  let lines : Array (Array Char) := board.map (·.toList.toArray)
  let mut pending : List Cell := []
  let mut seen : Std.HashSet Cell := Std.HashSet.emptyWithCapacity (2 * rows * columns)

  -- Each O on bottom side
  for j in [0:columns] do
    let cell := { row :=rows - 1, column := j }
    if read lines cell == 'O' then
      pending := cell :: pending
      seen := seen.insert cell

  -- Each X on right side
  for i in [0:rows] do
    let cell := { row := i, column := columns - 1 }
    if read lines cell == 'X' then
      pending := cell :: pending
      seen := seen.insert cell

  for _ in [0:rows * columns] do
    match pending with
    | [] => return ' '
    | (cell :: rest) =>
        let stone := read lines cell

        -- Reached O on top side?
        if stone == 'O' && cell.row == 0 then return 'O'

        -- Reached X on left side?
        if stone == 'X' && cell.column == 0 then return 'X'

        pending := rest
        for adjacent in adjacents rows columns cell do
          if ((read lines adjacent) == stone) && !(seen.contains adjacent) then
            pending := adjacent :: pending
            seen := seen.insert adjacent

  return ' '

end Connect
