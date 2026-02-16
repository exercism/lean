namespace ZebraPuzzle

inductive Nationality where
  | Englishman
  | Japanese
  | Norwegian
  | Spaniard
  | Ukrainian
  deriving BEq, Inhabited, Repr

def nextPermutation (a_ : Array Nat) : Array Nat := Id.run do
  let mut a := a_

  -- Step 1. find j
  let mut j := a.size - 2
  while a[j]! >= a[j + 1]! do
    j := j - 1

  -- Step 2. increase a[j]
  let mut l := a.size - 1
  while a[j]! >= a[l]! do
      l := l - 1

  let mut aj := a[j]!
  let mut al := a[l]!
  a := a.set! j al
  a := a.set! l aj

  -- Step 3. reverse a[j+1] ...
  j := j + 1
  l := a.size - 1
  while j < l do
    aj := a[j]!
    al := a[l]!
    a := a.set! j al
    a := a.set! l aj
    j := j + 1
    l := l - 1
  a

def adjacent (i : Nat) (j : Nat) : Bool :=
  (i + 1 == j) || (j + 1 == i)

inductive ZebraQuestion where
  | drinksWater
  | ownsZebra
  deriving BEq, Repr

def answer (question: ZebraQuestion): Nationality := Id.run do
  let mut result : Option Nationality := none

  let mut nationalities := #[0, 1, 2, 3, 4, 5]
  while result.isNone && (nationalities[0]! == 0) do
    let englishman := nationalities[1]!
    let japanese := nationalities[2]!
    let norwegian := nationalities[3]!
    let spaniard := nationalities[4]!
    let ukrainian := nationalities[5]!

    -- 10. The Norwegian lives in the first house.
    if norwegian == 1 then do
      let mut colors := #[0, 1, 2, 3, 4, 5]
      while result.isNone && (colors[0]! == 0) do
        let blue := colors[1]!
        let green := colors[2]!
        let ivory := colors[3]!
        let red := colors[4]!
        let yellow := colors[5]!

        -- 2. The Englishman lives in the red house.
        -- 6. The green house is immediately to the right of the ivory house.
        -- 15. The Norwegian lives next to the blue house.
        if (englishman == red) && (green == ivory + 1) && (adjacent norwegian blue) then do
          let mut drinks := #[0, 1, 2, 3, 4, 5]
          while result.isNone && (drinks[0]! == 0) do
            let coffee := drinks[1]!
            let milk := drinks[2]!
            let orangeJuice := drinks[3]!
            let tea := drinks[4]!
            let water := drinks[5]!

            -- 4. Coffee is drunk in the green house.
            -- 5. The Ukrainian drinks tea.
            -- 9. Milk is drunk in the middle house.
            if (coffee == green) && (ukrainian == tea) && (milk == 3) then do
              let mut hobbies := #[0, 1, 2, 3, 4, 5]
              while result.isNone && (hobbies[0]! == 0) do
                let reading := hobbies[1]!
                let painting := hobbies[2]!
                let football := hobbies[3]!
                let dancing := hobbies[4]!
                let chess := hobbies[5]!

                -- 8. The person in the yellow house is a painter.
                -- 13. The person who plays football drinks orange juice.
                -- 14. The Japanese person plays chess.
                if (painting == yellow) && (football == orangeJuice) && (japanese == chess) then do
                  let mut pets := #[0, 1, 2, 3, 4, 5]
                  while result.isNone && (pets[0]! == 0) do
                    let dog := pets[1]!
                    let fox := pets[2]!
                    let horse := pets[3]!
                    let snails := pets[4]!
                    let zebra := pets[5]!

                    -- 3. The Spaniard owns the dog.
                    -- 7. The snail owner likes to go dancing.
                    -- 11. The person who enjoys reading lives in the house next to the person with the fox.
                    -- 12. The painter's house is next to the house with the horse.
                    if (spaniard == dog) && (dancing == snails) && (adjacent reading fox) && (adjacent painting horse) then do
                      let selection := match question with
                      | .drinksWater => water
                      | .ownsZebra => zebra

                      if selection == englishman then result := some .Englishman
                      if selection == japanese then result := some .Japanese
                      if selection == norwegian then result := some .Norwegian
                      if selection == spaniard then result := some .Spaniard
                      if selection == ukrainian then result := some .Ukrainian

                    pets := nextPermutation pets
                hobbies := nextPermutation hobbies
            drinks := nextPermutation drinks
        colors := nextPermutation colors
    nationalities := nextPermutation nationalities
  return result.get!

def drinksWater : Nationality :=
  answer .drinksWater

def ownsZebra : Nationality :=
  answer .ownsZebra

end ZebraPuzzle
