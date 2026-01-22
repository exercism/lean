import LeanTest
import Connect

open LeanTest

def connectTests : TestSuite :=
  (TestSuite.empty "Connect")
  |>.addTest "an empty board has no winner" (do
      return assertEqual ' ' (Connect.winner #[". . . . .",
                                               " . . . . .",
                                               "  . . . . .",
                                               "   . . . . .",
                                               "    . . . . ."]))
  |>.addTest "X can win on a 1x1 board" (do
      return assertEqual 'X' (Connect.winner #["X"]))
  |>.addTest "O can win on a 1x1 board" (do
      return assertEqual 'O' (Connect.winner #["O"]))
  |>.addTest "only edges does not make a winner" (do
      return assertEqual ' ' (Connect.winner #["O O O X",
                                               " X . . X",
                                               "  X . . X",
                                               "   X O O O"]))
  |>.addTest "illegal diagonal does not make a winner" (do
      return assertEqual ' ' (Connect.winner #["X O . .",
                                               " O X X X",
                                               "  O X O .",
                                               "   . O X .",
                                               "    X X O O"]))
  |>.addTest "nobody wins crossing adjacent angles" (do
      return assertEqual ' ' (Connect.winner #["X . . .",
                                               " . X O .",
                                               "  O . X O",
                                               "   . O . X",
                                               "    . . O ."]))
  |>.addTest "X wins crossing from left to right" (do
      return assertEqual 'X' (Connect.winner #[". O . .",
                                               " O X X X",
                                               "  O X O .",
                                               "   X X O X",
                                               "    . O X ."]))
  |>.addTest "O wins crossing from top to bottom" (do
      return assertEqual 'O' (Connect.winner #[". O . .",
                                               " O X X X",
                                               "  O O O .",
                                               "   X X O X",
                                               "    . O X ."]))
  |>.addTest "X wins using a convoluted path" (do
      return assertEqual 'X' (Connect.winner #[". X X . .",
                                               " X . X . X",
                                               "  . X . X .",
                                               "   . X X . .",
                                               "    O O O O O"]))
  |>.addTest "X wins using a spiral path" (do
      return assertEqual 'X' (Connect.winner #["O X X X X X X X X",
                                               " O X O O O O O O O",
                                               "  O X O X X X X X O",
                                               "   O X O X O O O X O",
                                               "    O X O X X X O X O",
                                               "     O X O O O X O X O",
                                               "      O X X X X X O X O",
                                               "       O O O O O O O X O",
                                               "        X X X X X X X X O"]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [connectTests]
