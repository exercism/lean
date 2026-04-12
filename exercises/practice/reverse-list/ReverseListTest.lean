import LeanTest
import ReverseList
import Extra

open LeanTest

theorem check: @Extra.custom_reverse = @List.reverse := by
  exact ReverseList.custom_reverse_eq_spec_reverse

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
