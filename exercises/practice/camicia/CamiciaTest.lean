import LeanTest
import Camicia

open LeanTest

def camiciaTests : TestSuite :=
  (TestSuite.empty "Camicia")
  |>.addTest "two cards, one trick" (do
      return assertEqual ⟨.finished, 2, 1⟩ (Camicia.simulateGame [.C2] [.C3]))
  |>.addTest "three cards, one trick" (do
      return assertEqual ⟨.finished, 3, 1⟩ (Camicia.simulateGame [.C2, .C4] [.C3]))
  |>.addTest "four cards, one trick" (do
      return assertEqual ⟨.finished, 4, 1⟩ (Camicia.simulateGame [.C2, .C4] [.C3, .C5, .C6]))
  |>.addTest "the ace reigns supreme" (do
      return assertEqual ⟨.finished, 7, 1⟩ (Camicia.simulateGame [.C2, .CA] [.C3, .C4, .C5, .C6, .C7]))
  |>.addTest "the king beats ace" (do
      return assertEqual ⟨.finished, 7, 1⟩ (Camicia.simulateGame [.C2, .CA] [.C3, .C4, .C5, .C6, .CK]))
  |>.addTest "the queen seduces the king" (do
      return assertEqual ⟨.finished, 10, 1⟩ (Camicia.simulateGame [.C2, .CA, .C7, .C8, .CQ] [.C3, .C4, .C5, .C6, .CK]))
  |>.addTest "the jack betrays the queen" (do
      return assertEqual ⟨.finished, 12, 1⟩ (Camicia.simulateGame [.C2, .CA, .C7, .C8, .CQ] [.C3, .C4, .C5, .C6, .CK, .C9, .CJ]))
  |>.addTest "the 10 just wants to put on a show" (do
      return assertEqual ⟨.finished, 13, 1⟩ (Camicia.simulateGame [.C2, .CA, .C7, .C8, .CQ, .C10] [.C3, .C4, .C5, .C6, .CK, .C9, .CJ]))
  |>.addTest "simple loop with decks of 3 cards" (do
      return assertEqual ⟨.loop, 8, 3⟩ (Camicia.simulateGame [.CJ, .C2, .C3] [.C4, .CJ, .C5]))
  |>.addTest "the story is starting to get a bit complicated" (do
      return assertEqual ⟨.finished, 361, 1⟩ (Camicia.simulateGame [.C2, .C6, .C6, .CJ, .C4, .CK, .CQ, .C10, .CK, .CJ, .CQ, .C2, .C3, .CK, .C5, .C6, .CQ, .CQ, .CA, .CA, .C6, .C9, .CK, .CA, .C8, .CK, .C2, .CA, .C9, .CA, .CQ, .C4, .CK, .CK, .CK, .C3, .C5, .CK, .C8, .CQ, .C3, .CQ, .C7, .CJ, .CK, .CJ, .C9, .CJ, .C3, .C3, .CK, .CK, .CQ, .CA, .CK, .C7, .C10, .CA, .CQ, .C7, .C10, .CJ, .C4, .C5, .CJ, .C9, .C10, .CQ, .CJ, .CJ, .CK, .C6, .C10, .CJ, .C6, .CQ, .CJ, .C5, .CJ, .CQ, .CQ, .C8, .C3, .C8, .CA, .C2, .C6, .C9, .CK, .C7, .CJ, .CK, .CK, .C8, .CK, .CQ, .C6, .C10, .CJ, .C10, .CJ, .CQ, .CJ, .C10, .C3, .C8, .CK, .CA, .C6, .C9, .CK, .C2, .CA, .CA, .C10, .CJ, .C6, .CA, .C4, .CJ, .CA, .CJ, .CJ, .C6, .C2, .CJ, .C3, .CK, .C2, .C5, .C9, .CJ, .C9, .C6, .CK, .CA, .C5, .CQ, .CJ, .C2, .CQ, .CK, .CA, .C3, .CK, .CJ, .CK, .C2, .C5, .C6, .CQ, .CJ, .CQ, .CQ, .CJ, .C2, .CJ, .C9, .CQ, .C7, .C7, .CA, .CQ, .C7, .CQ, .CJ, .CK, .CJ, .CA, .C7, .C7, .C8, .CQ, .C10, .CJ, .C10, .CJ, .CJ, .C9, .C2, .CA, .C2] [.C7, .C2, .C10, .CK, .C8, .C2, .CJ, .C9, .CA, .C5, .C6, .CJ, .CQ, .C6, .CK, .C6, .C5, .CA, .C4, .CQ, .C7, .CJ, .C7, .C10, .C2, .CQ, .C8, .C2, .C2, .CK, .CJ, .CA, .C5, .C5, .CA, .C4, .CQ, .C6, .CQ, .CK, .C10, .C8, .CQ, .C2, .C10, .CJ, .CA, .CQ, .C8, .CQ, .CQ, .CJ, .CJ, .CA, .CA, .C9, .C10, .CJ, .CK, .C4, .CQ, .C10, .C10, .CJ, .CK, .C10, .C2, .CJ, .C7, .CA, .CK, .CK, .CJ, .CA, .CJ, .C10, .C8, .CK, .CA, .C7, .CQ, .CQ, .CJ, .C3, .CQ, .C4, .CA, .C3, .CA, .CQ, .CQ, .CQ, .C5, .C4, .CK, .CJ, .C10, .CA, .CQ, .CJ, .C6, .CJ, .CA, .C10, .CA, .C5, .C8, .C3, .CK, .C5, .C9, .CQ, .C8, .C7, .C7, .CJ, .C7, .CQ, .CQ, .CQ, .CA, .C7, .C8, .C9, .CA, .CQ, .CA, .CK, .C8, .CA, .CA, .CJ, .C8, .C4, .C8, .CK, .CJ, .CA, .C10, .CQ, .C8, .CJ, .C8, .C6, .C10, .CQ, .CJ, .CJ, .CA, .CA, .CJ, .C5, .CQ, .C6, .CJ, .CK, .CQ, .C8, .CK, .C4, .CQ, .CQ, .C6, .CJ, .CK, .C4, .C7, .CJ, .CJ, .C9, .C9, .CA, .CQ, .CQ, .CK, .CA, .C6, .C5, .CK]))
  |>.addTest "two tricks" (do
      return assertEqual ⟨.finished, 5, 2⟩ (Camicia.simulateGame [.CJ] [.C3, .CJ]))
  |>.addTest "more tricks" (do
      return assertEqual ⟨.finished, 12, 4⟩ (Camicia.simulateGame [.CJ, .C2, .C4] [.C3, .CJ, .CA]))
  |>.addTest "simple loop with decks of 4 cards" (do
      return assertEqual ⟨.loop, 16, 4⟩ (Camicia.simulateGame [.C2, .C3, .CJ, .C6] [.CK, .C5, .CJ, .C7]))
  |>.addTest "easy card combination" (do
      return assertEqual ⟨.finished, 40, 4⟩ (Camicia.simulateGame [.C4, .C8, .C7, .C5, .C4, .C10, .C3, .C9, .C7, .C3, .C10, .C10, .C6, .C8, .C2, .C8, .C5, .C4, .C5, .C9, .C6, .C5, .C2, .C8, .C10, .C9] [.C6, .C9, .C4, .C7, .C2, .C2, .C3, .C6, .C7, .C3, .CA, .CA, .CA, .CA, .CK, .CK, .CK, .CK, .CQ, .CQ, .CQ, .CQ, .CJ, .CJ, .CJ, .CJ]))
  |>.addTest "easy card combination, inverted decks" (do
      return assertEqual ⟨.finished, 40, 4⟩ (Camicia.simulateGame [.C3, .C3, .C5, .C7, .C3, .C2, .C10, .C7, .C6, .C7, .CA, .CA, .CA, .CA, .CK, .CK, .CK, .CK, .CQ, .CQ, .CQ, .CQ, .CJ, .CJ, .CJ, .CJ] [.C5, .C10, .C8, .C2, .C6, .C7, .C2, .C4, .C9, .C2, .C6, .C10, .C10, .C5, .C4, .C8, .C4, .C8, .C6, .C9, .C8, .C5, .C9, .C3, .C4, .C9]))
  |>.addTest "mirrored decks" (do
      return assertEqual ⟨.finished, 59, 4⟩ (Camicia.simulateGame [.C2, .CA, .C3, .CA, .C3, .CK, .C4, .CK, .C2, .CQ, .C2, .CQ, .C10, .CJ, .C5, .CJ, .C6, .C10, .C2, .C9, .C10, .C7, .C3, .C9, .C6, .C9] [.C6, .CA, .C4, .CA, .C7, .CK, .C4, .CK, .C7, .CQ, .C7, .CQ, .C5, .CJ, .C8, .CJ, .C4, .C5, .C8, .C9, .C10, .C6, .C8, .C3, .C8, .C5]))
  |>.addTest "opposite decks" (do
      return assertEqual ⟨.finished, 151, 21⟩ (Camicia.simulateGame [.C4, .CA, .C9, .CA, .C4, .CK, .C9, .CK, .C6, .CQ, .C8, .CQ, .C8, .CJ, .C10, .CJ, .C9, .C8, .C4, .C6, .C3, .C6, .C5, .C2, .C4, .C3] [.C10, .C7, .C3, .C2, .C9, .C2, .C7, .C8, .C7, .C5, .CJ, .C7, .CJ, .C10, .CQ, .C10, .CQ, .C3, .CK, .C5, .CK, .C6, .CA, .C2, .CA, .C5]))
  |>.addTest "random decks #1" (do
      return assertEqual ⟨.finished, 542, 76⟩ (Camicia.simulateGame [.CK, .C10, .C9, .C8, .CJ, .C8, .C6, .C9, .C7, .CA, .CK, .C5, .C4, .C4, .CJ, .C5, .CJ, .C4, .C3, .C5, .C8, .C6, .C7, .C7, .C4, .C9] [.C6, .C3, .CK, .CA, .CQ, .C10, .CA, .C2, .CQ, .C8, .C2, .C10, .C10, .C2, .CQ, .C3, .CK, .C9, .C7, .CA, .C3, .CQ, .C5, .CJ, .C2, .C6]))
  |>.addTest "random decks #2" (do
      return assertEqual ⟨.finished, 327, 42⟩ (Camicia.simulateGame [.C8, .CA, .C4, .C8, .C5, .CQ, .CJ, .C2, .C6, .C2, .C9, .C7, .CK, .CA, .C8, .C10, .CK, .C8, .C10, .C9, .CK, .C6, .C7, .C3, .CK, .C9] [.C10, .C5, .C2, .C6, .CQ, .CJ, .CA, .C9, .C5, .C5, .C3, .C7, .C3, .CJ, .CA, .C2, .CQ, .C3, .CJ, .CQ, .C4, .C10, .C4, .C7, .C4, .C6]))
  |>.addTest "Kleber 1999" (do
      return assertEqual ⟨.finished, 5790, 805⟩ (Camicia.simulateGame [.C4, .C8, .C9, .CJ, .CQ, .C8, .C5, .C5, .CK, .C2, .CA, .C9, .C8, .C5, .C10, .CA, .C4, .CJ, .C3, .CK, .C6, .C9, .C2, .CQ, .CK, .C7] [.C10, .CJ, .C3, .C2, .C4, .C10, .C4, .C7, .C5, .C3, .C6, .C6, .C7, .CA, .CJ, .CQ, .CA, .C7, .C2, .C10, .C3, .CK, .C9, .C6, .C8, .CQ]))
  |>.addTest "Collins 2006" (do
      return assertEqual ⟨.finished, 6913, 960⟩ (Camicia.simulateGame [.CA, .C8, .CQ, .CK, .C9, .C10, .C3, .C7, .C4, .C2, .CQ, .C3, .C2, .C10, .C9, .CK, .CA, .C8, .C7, .C7, .C4, .C5, .CJ, .C9, .C2, .C10] [.C4, .CJ, .CA, .CK, .C8, .C5, .C6, .C6, .CA, .C6, .C5, .CQ, .C4, .C6, .C10, .C8, .CJ, .C2, .C5, .C7, .CQ, .CJ, .C3, .C3, .CK, .C9]))
  |>.addTest "Mann and Wu 2007" (do
      return assertEqual ⟨.finished, 7157, 1007⟩ (Camicia.simulateGame [.CK, .C2, .CK, .CK, .C3, .C3, .C6, .C10, .CK, .C6, .CA, .C2, .C5, .C5, .C7, .C9, .CJ, .CA, .CA, .C3, .C4, .CQ, .C4, .C8, .CJ, .C6] [.C4, .C5, .C2, .CQ, .C7, .C9, .C9, .CQ, .C7, .CJ, .C9, .C8, .C10, .C3, .C10, .CJ, .C4, .C10, .C8, .C6, .C8, .C7, .CA, .CQ, .C5, .C2]))
  |>.addTest "Nessler 2012" (do
      return assertEqual ⟨.finished, 7207, 1015⟩ (Camicia.simulateGame [.C10, .C3, .C6, .C7, .CQ, .C2, .C9, .C8, .C2, .C8, .C4, .CA, .C10, .C6, .CK, .C2, .C10, .CA, .C5, .CA, .C2, .C4, .CQ, .CJ, .CK, .C4] [.C10, .CQ, .C4, .C6, .CJ, .C9, .C3, .CJ, .C9, .C3, .C3, .CQ, .CK, .C5, .C9, .C5, .CK, .C6, .C5, .C7, .C8, .CJ, .CA, .C7, .C8, .C7]))
  |>.addTest "Anderson 2013" (do
      return assertEqual ⟨.finished, 7225, 1016⟩ (Camicia.simulateGame [.C6, .C7, .CA, .C3, .CQ, .C3, .C5, .CJ, .C3, .C2, .CJ, .C7, .C4, .C5, .CQ, .C10, .C5, .CA, .CJ, .C2, .CK, .C8, .C9, .C9, .CK, .C3] [.C4, .CJ, .C6, .C9, .C8, .C5, .C10, .C7, .C9, .CQ, .C2, .C7, .C10, .C8, .C4, .C10, .CA, .C6, .C4, .CA, .C6, .C8, .CQ, .CK, .CK, .C2]))
  |>.addTest "Rucklidge 2014" (do
      return assertEqual ⟨.finished, 7959, 1122⟩ (Camicia.simulateGame [.C8, .CJ, .C2, .C9, .C4, .C4, .C5, .C8, .CQ, .C3, .C9, .C3, .C6, .C2, .C8, .CA, .CA, .CA, .C9, .C4, .C7, .C2, .C5, .CQ, .CQ, .C3] [.CK, .C7, .C10, .C6, .C3, .CJ, .CA, .C7, .C6, .C5, .C5, .C8, .C10, .C9, .C10, .C4, .C2, .C7, .CK, .CQ, .C10, .CK, .C6, .CJ, .CJ, .CK]))
  |>.addTest "Nessler 2021" (do
      return assertEqual ⟨.finished, 7972, 1106⟩ (Camicia.simulateGame [.C7, .C2, .C3, .C4, .CK, .C9, .C6, .C10, .CA, .C8, .C9, .CQ, .C7, .CA, .C4, .C8, .CJ, .CJ, .CA, .C4, .C3, .C2, .C5, .C6, .C6, .CJ] [.C3, .C10, .C8, .C9, .C8, .CK, .CK, .C2, .C5, .C5, .C7, .C6, .C4, .C3, .C5, .C7, .CA, .C9, .CJ, .CK, .C2, .CQ, .C10, .CQ, .C10, .CQ]))
  |>.addTest "Nessler 2022" (do
      return assertEqual ⟨.finished, 8344, 1164⟩ (Camicia.simulateGame [.C2, .C10, .C10, .CA, .CJ, .C3, .C8, .CQ, .C2, .C5, .C5, .C5, .C9, .C2, .C4, .C3, .C10, .CQ, .CA, .CK, .CQ, .CJ, .CJ, .C9, .CQ, .CK] [.C10, .C7, .C6, .C3, .C6, .CA, .C8, .C9, .C4, .C3, .CK, .CJ, .C6, .CK, .C4, .C9, .C7, .C8, .C5, .C7, .C8, .C2, .CA, .C7, .C4, .C6]))
  |>.addTest "Casella 2024, first infinite game found" (do
      return assertEqual ⟨.loop, 474, 66⟩ (Camicia.simulateGame [.C2, .C8, .C4, .CK, .C5, .C2, .C3, .CQ, .C6, .CK, .CQ, .CA, .CJ, .C3, .C5, .C9, .C8, .C3, .CA, .CA, .CJ, .C4, .C4, .CJ, .C7, .C5] [.C7, .C7, .C8, .C6, .C10, .C10, .C6, .C10, .C7, .C2, .CQ, .C6, .C3, .C2, .C4, .CK, .CQ, .C10, .CJ, .C5, .C9, .C8, .C9, .C9, .CK, .CA]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [camiciaTests]
