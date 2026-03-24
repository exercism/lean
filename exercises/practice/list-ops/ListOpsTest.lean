import LeanTest
import ListOps

open LeanTest

def listOpsTests : TestSuite :=
  (TestSuite.empty "ListOps")
  |>.addTest "append entries to a list and return the new list -> empty lists" (do
      return assertEqual ([] : List Int) (ListOps.append [] []))
  |>.addTest "append entries to a list and return the new list -> list to empty list" (do
      return assertEqual [1, 2, 3, 4] (ListOps.append ([] : List Int) [1, 2, 3, 4]))
  |>.addTest "append entries to a list and return the new list -> empty list to list" (do
      return assertEqual [1, 2, 3, 4] (ListOps.append [1, 2, 3, 4] ([] : List Int)))
  |>.addTest "append entries to a list and return the new list -> non-empty lists" (do
      return assertEqual [1, 2, 2, 3, 4, 5] (ListOps.append [1, 2] [2, 3, 4, 5]))
  |>.addTest "concatenate a list of lists -> empty list" (do
      return assertEqual ([] : List Int) (ListOps.concat ([] : List (List Int))))
  |>.addTest "concatenate a list of lists -> list of lists" (do
      return assertEqual [1, 2, 3, 4, 5, 6] (ListOps.concat [[1, 2], [3], [], [4, 5, 6]]))
  |>.addTest "concatenate a list of lists -> list of nested lists" (do
      return assertEqual [[1], [2], [3], [], [4, 5, 6]] (ListOps.concat [[[1], [2]], [[3]], [[]], [[4, 5, 6]]]))
  |>.addTest "filter list returning only values that satisfy the filter function -> empty list" (do
      return assertEqual ([] : List Int) (ListOps.filter (fun x => x % 2 == 1) []))
  |>.addTest "filter list returning only values that satisfy the filter function -> non-empty list" (do
      return assertEqual [1, 3, 5] (ListOps.filter (fun x => x % 2 == 1) [1, 2, 3, 5]))
  |>.addTest "returns the length of a list -> empty list" (do
      return assertEqual 0 (ListOps.length ([] : List Int)))
  |>.addTest "returns the length of a list -> non-empty list" (do
      return assertEqual 4 (ListOps.length [1, 2, 3, 4]))
  |>.addTest "return a list of elements whose values equal the list value transformed by the mapping function -> empty list" (do
      return assertEqual ([] : List Int) (ListOps.map (· + 1) ([] : List Int)))
  |>.addTest "return a list of elements whose values equal the list value transformed by the mapping function -> non-empty list" (do
      return assertEqual [2, 4, 6, 8] (ListOps.map (· + 1) [1, 3, 5, 7]))
  |>.addTest "folds (reduces) the given list from the left with a function -> empty list" (do
      return assertEqual 2 (ListOps.foldl (fun acc el => el * acc) 2 ([] : List Int)))
  |>.addTest "folds (reduces) the given list from the left with a function -> direction independent function applied to non-empty list" (do
      return assertEqual 15 (ListOps.foldl (fun acc el => el + acc) 5 [1, 2, 3, 4]))
  |>.addTest "folds (reduces) the given list from the left with a function -> direction dependent function applied to non-empty list" (do
      return assertEqual 0 (ListOps.foldl (· / ·) 5 [2, 5]))
  |>.addTest "folds (reduces) the given list from the right with a function -> empty list" (do
      return assertEqual 2 (ListOps.foldr (fun el acc => el * acc) 2 ([] : List Int)))
  |>.addTest "folds (reduces) the given list from the right with a function -> direction independent function applied to non-empty list" (do
      return assertEqual 15 (ListOps.foldr (fun el acc => el + acc) 5 [1, 2, 3, 4]))
  |>.addTest "folds (reduces) the given list from the right with a function -> direction dependent function applied to non-empty list" (do
      return assertEqual 2 (ListOps.foldr (· / ·) 5 [2, 5]))
  |>.addTest "reverse the elements of the list -> empty list" (do
      return assertEqual ([] : List Int) (ListOps.reverse ([] : List Int)))
  |>.addTest "reverse the elements of the list -> non-empty list" (do
      return assertEqual [7, 5, 3, 1] (ListOps.reverse [1, 3, 5, 7]))
  |>.addTest "reverse the elements of the list -> list of lists is not flattened" (do
      return assertEqual [[4, 5, 6], [], [3], [1, 2]] (ListOps.reverse [[1, 2], [3], [], [4, 5, 6]]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [listOpsTests]
