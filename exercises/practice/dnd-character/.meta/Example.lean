namespace DndCharacter

structure Character where
  strength     : Nat
  dexterity    : Nat
  constitution : Nat
  intelligence : Nat
  wisdom       : Nat
  charisma     : Nat
  hitpoints    : Int

def modifier (score : Nat) : Int :=
  (Int.ofNat score - 10) / 2

def ability {α} [RandomGen α] (generator : α) : (Nat × α) :=
  let (dice, gen) := (List.range 4).foldl (fun (acc, gen) _ =>
    let (n, g) := randNat gen 1 6
    (n :: acc, g)
  ) ([], generator)
  let sum := dice.mergeSort (· ≥ ·) |>.take 3 |>.sum
  (sum, gen)

def Character.new {α} [RandomGen α] (generator : α) : (Character × α) :=
  let (scores, gen) := (List.range 6).foldl (fun (ss, gen) _ =>
    let (s, g) := ability gen
    (s :: ss, g)
  ) ([], generator)
  match scores with
  | [str, dex, con, int, wis, cha] =>
    let character : Character := {
      strength := str,
      dexterity := dex,
      constitution := con,
      intelligence := int,
      wisdom := wis,
      charisma := cha,
      hitpoints := 10 + modifier con
    }
    (character, gen)
  | _ => (⟨0, 0, 0, 0, 0, 0, 0⟩, gen)

end DndCharacter
