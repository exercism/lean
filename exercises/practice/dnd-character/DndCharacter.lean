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
  sorry --remove this line and implement the function

def ability {α} [RandomGen α] (generator : α) : (Nat × α) :=
  sorry --remove this line and implement the function

def Character.new {α} [RandomGen α] (generator : α) : (Character × α) :=
  sorry --remove this line and implement the function

end DndCharacter
