import LeanTest
import AllYourBase

open LeanTest

def allYourBaseTests : TestSuite :=
  (TestSuite.empty "AllYourBase")
  |>.addTest "single bit one to decimal" (do
      return assertEqual [1] (AllYourBase.rebase ⟨2, (by decide)⟩ [1] ⟨10, (by decide)⟩))
  |>.addTest "binary to single decimal" (do
      return assertEqual [5] (AllYourBase.rebase ⟨2, (by decide)⟩ [1, 0, 1] ⟨10, (by decide)⟩))
  |>.addTest "single decimal to binary" (do
      return assertEqual [1, 0, 1] (AllYourBase.rebase ⟨10, (by decide)⟩ [5] ⟨2, (by decide)⟩))
  |>.addTest "binary to multiple decimal" (do
      return assertEqual [4, 2] (AllYourBase.rebase ⟨2, (by decide)⟩ [1, 0, 1, 0, 1, 0] ⟨10, (by decide)⟩))
  |>.addTest "decimal to binary" (do
      return assertEqual [1, 0, 1, 0, 1, 0] (AllYourBase.rebase ⟨10, (by decide)⟩ [4, 2] ⟨2, (by decide)⟩))
  |>.addTest "trinary to hexadecimal" (do
      return assertEqual [2, 10] (AllYourBase.rebase ⟨3, (by decide)⟩ [1, 1, 2, 0] ⟨16, (by decide)⟩))
  |>.addTest "hexadecimal to trinary" (do
      return assertEqual [1, 1, 2, 0] (AllYourBase.rebase ⟨16, (by decide)⟩ [2, 10] ⟨3, (by decide)⟩))
  |>.addTest "15-bit integer" (do
      return assertEqual [6, 10, 45] (AllYourBase.rebase ⟨97, (by decide)⟩ [3, 46, 60] ⟨73, (by decide)⟩))
  |>.addTest "empty list" (do
      return assertEqual [0] (AllYourBase.rebase ⟨2, (by decide)⟩ [] ⟨10, (by decide)⟩))
  |>.addTest "single zero" (do
      return assertEqual [0] (AllYourBase.rebase ⟨10, (by decide)⟩ [0] ⟨2, (by decide)⟩))
  |>.addTest "multiple zeros" (do
      return assertEqual [0] (AllYourBase.rebase ⟨10, (by decide)⟩ [0, 0, 0] ⟨2, (by decide)⟩))
  |>.addTest "leading zeros" (do
      return assertEqual [4, 2] (AllYourBase.rebase ⟨7, (by decide)⟩ [0, 6, 0] ⟨10, (by decide)⟩))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [allYourBaseTests]
