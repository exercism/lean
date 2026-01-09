import LeanTest
import FlattenArray

open LeanTest

def flattenArrayTests : TestSuite :=
  (TestSuite.empty "FlattenArray")
  |>.addTest "empty" (do
      return assertEqual #[] (FlattenArray.flatten (FlattenArray.Box.many #[
      ])))
  |>.addTest "no nesting" (do
      return assertEqual #[0, 1, 2] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 0),
      (FlattenArray.Box.one 1),
      (FlattenArray.Box.one 2)])))
  |>.addTest "flattens a nested array" (do
      return assertEqual #[] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      ])])])))
  |>.addTest "flattens array with just integers present" (do
      return assertEqual #[1, 2, 3, 4, 5, 6, 7, 8] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 1),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 2),
      (FlattenArray.Box.one 3),
      (FlattenArray.Box.one 4),
      (FlattenArray.Box.one 5),
      (FlattenArray.Box.one 6),
      (FlattenArray.Box.one 7)]),
      (FlattenArray.Box.one 8)])))
  |>.addTest "5 level nesting" (do
      return assertEqual #[0, 2, 2, 3, 8, 100, 4, 50, (-2)] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 0),
      (FlattenArray.Box.one 2),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 2),
      (FlattenArray.Box.one 3)]),
      (FlattenArray.Box.one 8),
      (FlattenArray.Box.one 100),
      (FlattenArray.Box.one 4),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 50)])])])]),
      (FlattenArray.Box.one (-2))])))
  |>.addTest "6 level nesting" (do
      return assertEqual #[1, 2, 3, 4, 5, 6, 7, 8] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 1),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 2),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 3)])]),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 4),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 5)])])]),
      (FlattenArray.Box.one 6),
      (FlattenArray.Box.one 7)]),
      (FlattenArray.Box.one 8)])))
  |>.addTest "null values are omitted from the final result" (do
      return assertEqual #[1, 2] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 1),
      (FlattenArray.Box.one 2),
      FlattenArray.Box.zero])))
  |>.addTest "consecutive null values at the front of the array are omitted from the final result" (do
      return assertEqual #[3] (FlattenArray.flatten (FlattenArray.Box.many #[
      FlattenArray.Box.zero,
      FlattenArray.Box.zero,
      (FlattenArray.Box.one 3)])))
  |>.addTest "consecutive null values in the middle of the array are omitted from the final result" (do
      return assertEqual #[1, 4] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 1),
      FlattenArray.Box.zero,
      FlattenArray.Box.zero,
      (FlattenArray.Box.one 4)])))
  |>.addTest "6 level nested array with null values" (do
      return assertEqual #[0, 2, 2, 3, 8, 100, (-2)] (FlattenArray.flatten (FlattenArray.Box.many #[
      (FlattenArray.Box.one 0),
      (FlattenArray.Box.one 2),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 2),
      (FlattenArray.Box.one 3)]),
      (FlattenArray.Box.one 8),
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.one 100)])]),
      FlattenArray.Box.zero,
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      FlattenArray.Box.zero])])]),
      (FlattenArray.Box.one (-2))])))
  |>.addTest "all values in nested array are null" (do
      return assertEqual #[] (FlattenArray.flatten (FlattenArray.Box.many #[
      FlattenArray.Box.zero,
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      FlattenArray.Box.zero])])]),
      FlattenArray.Box.zero,
      FlattenArray.Box.zero,
      (FlattenArray.Box.many #[
      (FlattenArray.Box.many #[
      FlattenArray.Box.zero,
      FlattenArray.Box.zero]),
      FlattenArray.Box.zero]),
      FlattenArray.Box.zero])))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [flattenArrayTests]
