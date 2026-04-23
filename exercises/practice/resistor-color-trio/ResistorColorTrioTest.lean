import LeanTest
import ResistorColorTrio

open LeanTest

/--
  info: 33 Ω
-/
#guard_msgs(info, drop all) in
#eval *[[c*orange, c*orange, c*black]]

/--
  info: 680 Ω
-/
#guard_msgs(info, drop all) in
#eval *[[c*blue, c*grey, c*brown]]

/--
  info: 2 kΩ
-/
#guard_msgs(info, drop all) in
#eval *[[c*red, c*black, c*red]]

/--
  info: 51 kΩ
-/
#guard_msgs(info, drop all) in
#eval *[[c*green, c*brown, c*orange]]

/--
  info: 470 kΩ
-/
#guard_msgs(info, drop all) in
#eval *[[c*yellow, c*violet, c*yellow]]

/--
  info: 67 MΩ
-/
#guard_msgs(info, drop all) in
#eval *[[c*blue, c*violet, c*blue]]

/--
  info: 0 Ω
-/
#guard_msgs(info, drop all) in
#eval *[[c*black, c*black, c*black]]

/--
  info: 99 GΩ
-/
#guard_msgs(info, drop all) in
#eval *[[c*white, c*white, c*white]]

/--
  info: 8 Ω
-/
#guard_msgs(info, drop all) in
#eval *[[c*black, c*grey, c*black]]

/--
  info: 650 kΩ
-/
#guard_msgs(info, drop all) in
#eval *[[c*blue, c*green, c*yellow, c*orange]]

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
