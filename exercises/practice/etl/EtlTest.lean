import LeanTest
import Etl
import Std

open LeanTest

def Std.HashMap.toSortedList (map : Std.HashMap Char Nat) :=
  map.toArray.qsort (λ (k1, _) (k2, _) => k1 ≤ k2)

instance : BEq (Std.HashMap Char Nat) where
  beq a b := a.toSortedList == b.toSortedList

def etlTests : TestSuite :=
  (TestSuite.empty "Etl")
  |>.addTest "single letter" (do
      return assertEqual (.ofList [
        ('a', 1)
      ]) $ Etl.transform (.ofList [
        (1, ['A'])
      ]))
  |>.addTest "single score with multiple letters" (do
      return assertEqual (.ofList [
        ('a', 1),
        ('e', 1),
        ('i', 1),
        ('o', 1),
        ('u', 1)
      ]) $ Etl.transform (.ofList [
        (1, ['A', 'E', 'I', 'O', 'U'])
      ]))
  |>.addTest "multiple scores with multiple letters" (do
      return assertEqual (.ofList [
        ('a', 1),
        ('d', 2),
        ('e', 1),
        ('g', 2)
      ]) $ Etl.transform (.ofList [
        (1, ['A', 'E']),
        (2, ['D', 'G'])
      ]))
  |>.addTest "multiple scores with differing numbers of letters" (do
      return assertEqual (.ofList [
        ('a', 1),
        ('b', 3),
        ('c', 3),
        ('d', 2),
        ('e', 1),
        ('f', 4),
        ('g', 2),
        ('h', 4),
        ('i', 1),
        ('j', 8),
        ('k', 5),
        ('l', 1),
        ('m', 3),
        ('n', 1),
        ('o', 1),
        ('p', 3),
        ('q', 10),
        ('r', 1),
        ('s', 1),
        ('t', 1),
        ('u', 1),
        ('v', 4),
        ('w', 4),
        ('x', 8),
        ('y', 4),
        ('z', 10)
      ]) $ Etl.transform (.ofList [
        (1, ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']),
        (10, ['Q', 'Z']),
        (2, ['D', 'G']),
        (3, ['B', 'C', 'M', 'P']),
        (4, ['F', 'H', 'V', 'W', 'Y']),
        (5, ['K']),
        (8, ['J', 'X'])
      ]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [etlTests]
