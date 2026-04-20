import LeanTest
import Alphametics

open LeanTest

def alphameticsTests : TestSuite :=
  (TestSuite.empty "Alphametics")
  |>.addTest "puzzle with three letters" (do
      return assertEqual (some [('B', 9), ('I', 1), ('L', 0)])
          (Alphametics.solve "I + BB == ILL"))
  |>.addTest "solution must have unique value for each letter" (do
      return assertEqual none
          (Alphametics.solve "A == B"))
  |>.addTest "leading zero solution is invalid" (do
      return assertEqual none
          (Alphametics.solve "ACA + DD == BD"))
  |>.addTest "puzzle with two digits final carry" (do
      return assertEqual (some [('A', 9), ('B', 1), ('C', 0)])
          (Alphametics.solve "A + A + A + A + A + A + A + A + A + A + A + B == BCC"))
  |>.addTest "puzzle with four letters" (do
      return assertEqual (some [('A', 9), ('M', 1), ('O', 0), ('S', 2)])
          (Alphametics.solve "AS + A == MOM"))
  |>.addTest "puzzle with six letters" (do
      return assertEqual (some [('A', 0), ('E', 2), ('L', 1), ('N', 7), ('O', 4), ('T', 9)])
          (Alphametics.solve "NO + NO + TOO == LATE"))
  |>.addTest "puzzle with seven letters" (do
      return assertEqual (some [('E', 4), ('G', 2), ('H', 5), ('I', 0), ('L', 1), ('S', 9), ('T', 7)])
          (Alphametics.solve "HE + SEES + THE == LIGHT"))
  |>.addTest "puzzle with eight letters" (do
      return assertEqual (some [('D', 7), ('E', 5), ('M', 1), ('N', 6), ('O', 0), ('R', 8), ('S', 9), ('Y', 2)])
          (Alphametics.solve "SEND + MORE == MONEY"))
  |>.addTest "puzzle with ten letters" (do
      return assertEqual (some [('A', 5), ('D', 3), ('E', 4), ('F', 7), ('G', 8), ('N', 0), ('O', 2), ('R', 1), ('S', 6), ('T', 9)])
          (Alphametics.solve "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"))
  |>.addTest "puzzle with ten letters and 199 addends" (do
      return assertEqual (some [('A', 1), ('E', 0), ('F', 5), ('H', 8), ('I', 7), ('L', 2), ('O', 6), ('R', 3), ('S', 4), ('T', 9)])
          (Alphametics.solve "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES"))
  |>.addTest "puzzle with a colors theme" (do
      return assertEqual (some [('A', 5), ('C', 2), ('E', 4), ('G', 8), ('L', 9), ('N', 6), ('O', 1), ('R', 3), ('S', 0)])
          (Alphametics.solve "GREEN + ORANGE == COLORS"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [alphameticsTests]
