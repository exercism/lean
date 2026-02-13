import LeanTest
import DndCharacter

open LeanTest

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def dndCharacterTests : TestSuite :=
  (TestSuite.empty "DndCharacter")
    |>.addTest "ability modifier -> ability modifier for score 3 is -4" (do
        return assertEqual (-4) (DndCharacter.modifier 3))
    |>.addTest "ability modifier -> ability modifier for score 4 is -3" (do
        return assertEqual (-3) (DndCharacter.modifier 4))
    |>.addTest "ability modifier -> ability modifier for score 5 is -3" (do
        return assertEqual (-3) (DndCharacter.modifier 5))
    |>.addTest "ability modifier -> ability modifier for score 6 is -2" (do
        return assertEqual (-2) (DndCharacter.modifier 6))
    |>.addTest "ability modifier -> ability modifier for score 7 is -2" (do
        return assertEqual (-2) (DndCharacter.modifier 7))
    |>.addTest "ability modifier -> ability modifier for score 8 is -1" (do
        return assertEqual (-1) (DndCharacter.modifier 8))
    |>.addTest "ability modifier -> ability modifier for score 9 is -1" (do
        return assertEqual (-1) (DndCharacter.modifier 9))
    |>.addTest "ability modifier -> ability modifier for score 10 is 0" (do
        return assertEqual 0 (DndCharacter.modifier 10))
    |>.addTest "ability modifier -> ability modifier for score 11 is 0" (do
        return assertEqual 0 (DndCharacter.modifier 11))
    |>.addTest "ability modifier -> ability modifier for score 12 is +1" (do
        return assertEqual 1 (DndCharacter.modifier 12))
    |>.addTest "ability modifier -> ability modifier for score 13 is +1" (do
        return assertEqual 1 (DndCharacter.modifier 13))
    |>.addTest "ability modifier -> ability modifier for score 14 is +2" (do
        return assertEqual 2 (DndCharacter.modifier 14))
    |>.addTest "ability modifier -> ability modifier for score 15 is +2" (do
        return assertEqual 2 (DndCharacter.modifier 15))
    |>.addTest "ability modifier -> ability modifier for score 16 is +3" (do
        return assertEqual 3 (DndCharacter.modifier 16))
    |>.addTest "ability modifier -> ability modifier for score 17 is +3" (do
        return assertEqual 3 (DndCharacter.modifier 17))
    |>.addTest "ability modifier -> ability modifier for score 18 is +4" (do
        return assertEqual 4 (DndCharacter.modifier 18))
    |>.addTest "random ability is within range" (do
        let expectedFreqs : Array Nat := #[
          100, 400, 1000, 2100, 3800,
          6200, 9100, 12200, 14800, 16700,
          17200, 16000, 13100, 9400, 5400, 2100
        ]
        let mut actualFreqs := Array.replicate 16 0
        let mut assert := AssertionResult.success
        let mut generator := mkStdGen 1812433253
        for _ in [:129600] do
          let (ability, newGen) := DndCharacter.ability generator
          generator := newGen
          assert := assert ++ assertInRange ability 3 18
          actualFreqs := actualFreqs.modify (ability - 3) (· + 1)
        let mut sumFreqs := 0.0
        for i in [:expectedFreqs.size] do
          let expected := expectedFreqs[i]!
          let squared := (actualFreqs[i]! - expected) ^ 2
          sumFreqs := sumFreqs + (squared.toFloat / expected.toFloat)
        let result := (sumFreqs * 1000).toUInt32.toNat
        assert := assert ++ assertInRange result 0 44263
        return assert)
    |>.addTest "random character is valid" (do
      let mut assert := AssertionResult.success
      let mut generator := mkStdGen 1812433253
      let (wulfgar, newGen) := DndCharacter.Character.new generator
      generator := newGen
      assert := assert ++ assertInRange wulfgar.strength 3 18
      assert := assert ++ assertInRange wulfgar.dexterity 3 18
      assert := assert ++ assertInRange wulfgar.constitution 3 18
      assert := assert ++ assertInRange wulfgar.intelligence 3 18
      assert := assert ++ assertInRange wulfgar.wisdom 3 18
      assert := assert ++ assertInRange wulfgar.charisma 3 18
      assert := assert ++ assertEqual (10 + DndCharacter.modifier wulfgar.constitution) wulfgar.hitpoints
      let (artemisEntreri, newGen) := DndCharacter.Character.new generator
      generator := newGen
      assert := assert ++ assertInRange artemisEntreri.strength 3 18
      assert := assert ++ assertInRange artemisEntreri.dexterity 3 18
      assert := assert ++ assertInRange artemisEntreri.constitution 3 18
      assert := assert ++ assertInRange artemisEntreri.intelligence 3 18
      assert := assert ++ assertInRange artemisEntreri.wisdom 3 18
      assert := assert ++ assertInRange artemisEntreri.charisma 3 18
      assert := assert ++ assertEqual (10 + DndCharacter.modifier artemisEntreri.constitution) artemisEntreri.hitpoints
      let (drizztDoUrden, newGen) := DndCharacter.Character.new generator
      generator := newGen
      assert := assert ++ assertInRange drizztDoUrden.strength 3 18
      assert := assert ++ assertInRange drizztDoUrden.dexterity 3 18
      assert := assert ++ assertInRange drizztDoUrden.constitution 3 18
      assert := assert ++ assertInRange drizztDoUrden.intelligence 3 18
      assert := assert ++ assertInRange drizztDoUrden.wisdom 3 18
      assert := assert ++ assertInRange drizztDoUrden.charisma 3 18
      assert := assert ++ assertEqual (10 + DndCharacter.modifier drizztDoUrden.constitution) drizztDoUrden.hitpoints
      let (elminster, newGen) := DndCharacter.Character.new generator
      generator := newGen
      assert := assert ++ assertInRange elminster.strength 3 18
      assert := assert ++ assertInRange elminster.dexterity 3 18
      assert := assert ++ assertInRange elminster.constitution 3 18
      assert := assert ++ assertInRange elminster.intelligence 3 18
      assert := assert ++ assertInRange elminster.wisdom 3 18
      assert := assert ++ assertInRange elminster.charisma 3 18
      assert := assert ++ assertEqual (10 + DndCharacter.modifier elminster.constitution) elminster.hitpoints
      let (cattieBrie, newGen) := DndCharacter.Character.new generator
      generator := newGen
      assert := assert ++ assertInRange cattieBrie.strength 3 18
      assert := assert ++ assertInRange cattieBrie.dexterity 3 18
      assert := assert ++ assertInRange cattieBrie.constitution 3 18
      assert := assert ++ assertInRange cattieBrie.intelligence 3 18
      assert := assert ++ assertInRange cattieBrie.wisdom 3 18
      assert := assert ++ assertInRange cattieBrie.charisma 3 18
      assert := assert ++ assertEqual (10 + DndCharacter.modifier cattieBrie.constitution) cattieBrie.hitpoints
      let (regis, _) := DndCharacter.Character.new generator
      assert := assert ++ assertInRange regis.strength 3 18
      assert := assert ++ assertInRange regis.dexterity 3 18
      assert := assert ++ assertInRange regis.constitution 3 18
      assert := assert ++ assertInRange regis.intelligence 3 18
      assert := assert ++ assertInRange regis.wisdom 3 18
      assert := assert ++ assertInRange regis.charisma 3 18
      assert := assert ++ assertEqual (10 + DndCharacter.modifier regis.constitution) regis.hitpoints
      return assert)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [dndCharacterTests]
