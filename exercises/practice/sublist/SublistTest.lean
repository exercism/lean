import LeanTest
import Sublist

open LeanTest

def sublistTests : TestSuite :=
  (TestSuite.empty "Sublist")
  |>.addTest "empty lists" (do
      return assertEqual .equal (Sublist.sublist [] []))
  |>.addTest "empty list within non empty list" (do
      return assertEqual .sublist (Sublist.sublist [] [1,2,3]))
  |>.addTest "non empty list contains empty list" (do
      return assertEqual .superlist (Sublist.sublist [1,2,3] []))
  |>.addTest "list equals itself" (do
      return assertEqual .equal (Sublist.sublist [1,2,3] [1,2,3]))
  |>.addTest "different lists" (do
      return assertEqual .unequal (Sublist.sublist [1,2,3] [2,3,4]))
  |>.addTest "false start" (do
      return assertEqual .sublist (Sublist.sublist [1,2,5] [0,1,2,3,1,2,5,6]))
  |>.addTest "consecutive" (do
      return assertEqual .sublist (Sublist.sublist [1,1,2] [0,1,1,1,2,1,2]))
  |>.addTest "sublist at start" (do
      return assertEqual .sublist (Sublist.sublist [0,1,2] [0,1,2,3,4,5]))
  |>.addTest "sublist in middle" (do
      return assertEqual .sublist (Sublist.sublist [2,3,4] [0,1,2,3,4,5]))
  |>.addTest "sublist at end" (do
      return assertEqual .sublist (Sublist.sublist [3,4,5] [0,1,2,3,4,5]))
  |>.addTest "at start of superlist" (do
      return assertEqual .superlist (Sublist.sublist [0,1,2,3,4,5] [0,1,2]))
  |>.addTest "in middle of superlist" (do
      return assertEqual .superlist (Sublist.sublist [0,1,2,3,4,5] [2,3]))
  |>.addTest "at end of superlist" (do
      return assertEqual .superlist (Sublist.sublist [0,1,2,3,4,5] [3,4,5]))
  |>.addTest "first list missing element from second list" (do
      return assertEqual .unequal (Sublist.sublist [1,3] [1,2,3]))
  |>.addTest "second list missing element from first list" (do
      return assertEqual .unequal (Sublist.sublist [1,2,3] [1,3]))
  |>.addTest "first list missing additional digits from second list" (do
      return assertEqual .unequal (Sublist.sublist [1,2] [1,22]))
  |>.addTest "order matters to a list" (do
      return assertEqual .unequal (Sublist.sublist [1,2,3] [3,2,1]))
  |>.addTest "same digits but different numbers" (do
      return assertEqual .unequal (Sublist.sublist [1,0,1] [10,1]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [sublistTests]
