import LeanTest
import Diamond

open LeanTest

def diamondTests : TestSuite :=
  (TestSuite.empty "Diamond")
  |>.addTest "Degenerate case with a single 'A' row" (do
      return assertEqual [
        "A"
      ] (Diamond.rows 'A'))
  |>.addTest "Degenerate case with no row containing 3 distinct groups of spaces" (do
      return assertEqual [
        " A ",
        "B B",
        " A "
      ] (Diamond.rows 'B'))
  |>.addTest "Smallest non-degenerate case with odd diamond side length" (do
      return assertEqual [
        "  A  ",
        " B B ",
        "C   C",
        " B B ",
        "  A  "
      ] (Diamond.rows 'C'))
  |>.addTest "Smallest non-degenerate case with even diamond side length" (do
      return assertEqual [
        "   A   ",
        "  B B  ",
        " C   C ",
        "D     D",
        " C   C ",
        "  B B  ",
        "   A   "
      ] (Diamond.rows 'D'))
  |>.addTest "Largest possible diamond" (do
      return assertEqual [
        "                         A                         ",
        "                        B B                        ",
        "                       C   C                       ",
        "                      D     D                      ",
        "                     E       E                     ",
        "                    F         F                    ",
        "                   G           G                   ",
        "                  H             H                  ",
        "                 I               I                 ",
        "                J                 J                ",
        "               K                   K               ",
        "              L                     L              ",
        "             M                       M             ",
        "            N                         N            ",
        "           O                           O           ",
        "          P                             P          ",
        "         Q                               Q         ",
        "        R                                 R        ",
        "       S                                   S       ",
        "      T                                     T      ",
        "     U                                       U     ",
        "    V                                         V    ",
        "   W                                           W   ",
        "  X                                             X  ",
        " Y                                               Y ",
        "Z                                                 Z",
        " Y                                               Y ",
        "  X                                             X  ",
        "   W                                           W   ",
        "    V                                         V    ",
        "     U                                       U     ",
        "      T                                     T      ",
        "       S                                   S       ",
        "        R                                 R        ",
        "         Q                               Q         ",
        "          P                             P          ",
        "           O                           O           ",
        "            N                         N            ",
        "             M                       M             ",
        "              L                     L              ",
        "               K                   K               ",
        "                J                 J                ",
        "                 I               I                 ",
        "                  H             H                  ",
        "                   G           G                   ",
        "                    F         F                    ",
        "                     E       E                     ",
        "                      D     D                      ",
        "                       C   C                       ",
        "                        B B                        ",
        "                         A                         "
      ] (Diamond.rows 'Z'))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [diamondTests]
