import LeanTest
import ResistorColor

open LeanTest

theorem h_black: c*black = (0 : Fin 10) := by rfl
theorem h_brown: c*brown = (1 : Fin 10) := by rfl
theorem h_red: c*red = (2 : Fin 10) := by rfl
theorem h_orange: c*orange = (3 : Fin 10) := by rfl
theorem h_yellow: c*yellow = (4 : Fin 10) := by rfl
theorem h_green: c*green = (5 : Fin 10) := by rfl
theorem h_blue: c*blue = (6 : Fin 10) := by rfl
theorem h_violet: c*violet = (7 : Fin 10) := by rfl
theorem h_grey: c*grey = (8 : Fin 10) := by rfl
theorem h_white: c*white = (9 : Fin 10) := by rfl
theorem h_all: c*all = #[c*black, c*brown, c*red, c*orange, c*yellow, c*green, c*blue, c*violet, c*grey, c*white] := by rfl

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
