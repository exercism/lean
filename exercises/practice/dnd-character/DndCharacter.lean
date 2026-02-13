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
  sorry

def ability {α} [RandomGen α] (generator : α) : (Nat × α) :=
  sorry

def Character.new {α} [RandomGen α] (generator : α) : (Character × α) :=
  sorry

end DndCharacter
