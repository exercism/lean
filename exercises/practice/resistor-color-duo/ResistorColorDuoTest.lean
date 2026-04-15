import LeanTest
import ResistorColorDuo

open LeanTest

/--
  info: 10
-/
#guard_msgs(info, drop all) in
#eval *[[c*brown, c*black]]

/--
  info: 68
-/
#guard_msgs(info, drop all) in
#eval *[[c*blue, c*grey]]

/--
  info: 47
-/
#guard_msgs(info, drop all) in
#eval *[[c*yellow, c*violet]]

/--
  info: 92
-/
#guard_msgs(info, drop all) in
#eval *[[c*white, c*red]]

/--
  info: 33
-/
#guard_msgs(info, drop all) in
#eval *[[c*orange, c*orange]]

/--
  info: 51
-/
#guard_msgs(info, drop all) in
#eval *[[c*green, c*brown, c*orange]]

/--
  info: 1
-/
#guard_msgs(info, drop all) in
#eval *[[c*black, c*brown]]

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
