import LeanTest
import ReverseList

open LeanTest

theorem check: @Spec.custom_reverse = @List.reverse := by
  exact ReverseList.custom_reverse_eq_spec_reverse

def main : IO UInt32 := do
  runTestSuitesWithExitCode []
