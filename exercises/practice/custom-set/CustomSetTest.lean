import LeanTest
import CustomSet

open LeanTest

def customSetTests : TestSuite :=
  (TestSuite.empty "CustomSet")
    |>.addTest "Returns true if the set contains no elements -> sets with no elements are empty" (do
        return assertEqual ∅ <| CustomSet.Set.ofList [])
    |>.addTest "Returns true if the set contains no elements -> sets with elements are not empty" (do
        return assertNotEqual ∅ <| CustomSet.Set.ofList [1])
    |>.addTest "Sets can report if they contain an element -> nothing is contained in an empty set" (do
        return assert <| decide <| 1 ∉ CustomSet.Set.ofList [])
    |>.addTest "Sets can report if they contain an element -> when the element is in the set" (do
        return assert <| decide <| 1 ∈ CustomSet.Set.ofList [1, 2, 3])
    |>.addTest "Sets can report if they contain an element -> when the element is not in the set" (do
        return assert <| decide <| 4 ∉ CustomSet.Set.ofList [1, 2, 3])
    |>.addTest "A set is a subset if all of its elements are contained in the other set -> empty set is a subset of another empty set" (do
        return assert <| decide <| CustomSet.Set.ofList [] ⊆ CustomSet.Set.ofList [])
    |>.addTest "A set is a subset if all of its elements are contained in the other set -> empty set is a subset of non-empty set" (do
        return assert <| decide <| CustomSet.Set.ofList [] ⊆ CustomSet.Set.ofList [1])
    |>.addTest "A set is a subset if all of its elements are contained in the other set -> non-empty set is not a subset of empty set" (do
        return assert <| decide <| CustomSet.Set.ofList [1] ⊈ CustomSet.Set.ofList [])
    |>.addTest "A set is a subset if all of its elements are contained in the other set -> set is a subset of set with exact same elements" (do
        return assert <| decide <| CustomSet.Set.ofList [1, 2, 3] ⊆ CustomSet.Set.ofList [1, 2, 3])
    |>.addTest "A set is a subset if all of its elements are contained in the other set -> set is a subset of larger set with same elements" (do
        return assert <| decide <| CustomSet.Set.ofList [1, 2, 3] ⊆ CustomSet.Set.ofList [4, 1, 2, 3])
    |>.addTest "A set is a subset if all of its elements are contained in the other set -> set is not a subset of set that does not contain its elements" (do
        return assert <| decide <| CustomSet.Set.ofList [1, 2, 3] ⊈ CustomSet.Set.ofList [4, 1, 3])
    |>.addTest "Sets are disjoint if they share no elements -> the empty set is disjoint with itself" (do
        return assertTrue <| (CustomSet.Set.ofList []).disjoint <| CustomSet.Set.ofList [])
    |>.addTest "Sets are disjoint if they share no elements -> empty set is disjoint with non-empty set" (do
        return assertTrue <| (CustomSet.Set.ofList []).disjoint <| CustomSet.Set.ofList [1])
    |>.addTest "Sets are disjoint if they share no elements -> non-empty set is disjoint with empty set" (do
        return assertTrue <| (CustomSet.Set.ofList [1]).disjoint <| CustomSet.Set.ofList [])
    |>.addTest "Sets are disjoint if they share no elements -> sets are not disjoint if they share an element" (do
        return assertFalse <| (CustomSet.Set.ofList [1, 2]).disjoint <| CustomSet.Set.ofList [2, 3])
    |>.addTest "Sets are disjoint if they share no elements -> sets are disjoint if they share no elements" (do
        return assertTrue <| (CustomSet.Set.ofList [1, 2]).disjoint <| CustomSet.Set.ofList [3, 4])
    |>.addTest "Sets with the same elements are equal -> empty sets are equal" (do
        return assert <| CustomSet.Set.ofList [] == CustomSet.Set.ofList [])
    |>.addTest "Sets with the same elements are equal -> empty set is not equal to non-empty set" (do
        return assert <| CustomSet.Set.ofList [] != CustomSet.Set.ofList [1, 2, 3])
    |>.addTest "Sets with the same elements are equal -> non-empty set is not equal to empty set" (do
        return assert <| CustomSet.Set.ofList [1, 2, 3] != CustomSet.Set.ofList [])
    |>.addTest "Sets with the same elements are equal -> sets with the same elements are equal" (do
        return assert <| CustomSet.Set.ofList [1, 2] == CustomSet.Set.ofList [2, 1])
    |>.addTest "Sets with the same elements are equal -> sets with different elements are not equal" (do
        return assert <| CustomSet.Set.ofList [1, 2, 3] != CustomSet.Set.ofList [1, 2, 4])
    |>.addTest "Sets with the same elements are equal -> set is not equal to larger set with same elements" (do
        return assert <| CustomSet.Set.ofList [1, 2, 3] != CustomSet.Set.ofList [1, 2, 3, 4])
    |>.addTest "Sets with the same elements are equal -> set is equal to a set constructed from an array with duplicates" (do
        return assert <| CustomSet.Set.ofList [1] == CustomSet.Set.ofList [1, 1])
    |>.addTest "Unique elements can be added to a set -> add to empty set" (do
        return assertEqual (CustomSet.Set.ofList [3]) <| (CustomSet.Set.ofList []).add 3)
    |>.addTest "Unique elements can be added to a set -> add to non-empty set" (do
        return assertEqual (CustomSet.Set.ofList [1, 2, 3, 4]) <| (CustomSet.Set.ofList [1, 2, 4]).add 3)
    |>.addTest "Unique elements can be added to a set -> adding an existing element does not change the set" (do
        return assertEqual (CustomSet.Set.ofList [1, 2, 3]) <| (CustomSet.Set.ofList [1, 2, 3]).add 3)
    |>.addTest "Intersection returns a set of all shared elements -> intersection of two empty sets is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [] ∩ CustomSet.Set.ofList [])
    |>.addTest "Intersection returns a set of all shared elements -> intersection of an empty set and non-empty set is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [] ∩ CustomSet.Set.ofList [3, 2, 5])
    |>.addTest "Intersection returns a set of all shared elements -> intersection of a non-empty set and an empty set is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [1, 2, 3, 4] ∩ CustomSet.Set.ofList [])
    |>.addTest "Intersection returns a set of all shared elements -> intersection of two sets with no shared elements is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [1, 2, 3] ∩ CustomSet.Set.ofList [4, 5, 6])
    |>.addTest "Intersection returns a set of all shared elements -> intersection of two sets with shared elements is a set of the shared elements" (do
        return assertEqual (CustomSet.Set.ofList [2, 3]) <| CustomSet.Set.ofList [1, 2, 3, 4] ∩ CustomSet.Set.ofList [3, 2, 5])
    |>.addTest "Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of two empty sets is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [] \ CustomSet.Set.ofList [])
    |>.addTest "Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of empty set and non-empty set is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [] \ CustomSet.Set.ofList [3, 2, 5])
    |>.addTest "Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of a non-empty set and an empty set is the non-empty set" (do
        return assertEqual (CustomSet.Set.ofList [1, 2, 3, 4]) <| CustomSet.Set.ofList [1, 2, 3, 4] \ CustomSet.Set.ofList [])
    |>.addTest "Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference of two non-empty sets is a set of elements that are only in the first set" (do
        return assertEqual (CustomSet.Set.ofList [1, 3]) <| CustomSet.Set.ofList [3, 2, 1] \ CustomSet.Set.ofList [2, 4])
    |>.addTest "Difference (or Complement) of a set is a set of all elements that are only in the first set -> difference removes all duplicates in the first set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [1, 1] \ CustomSet.Set.ofList [1])
    |>.addTest "Union returns a set of all elements in either set -> union of empty sets is an empty set" (do
        return assertEqual (CustomSet.Set.ofList []) <| CustomSet.Set.ofList [] ∪ CustomSet.Set.ofList [])
    |>.addTest "Union returns a set of all elements in either set -> union of an empty set and non-empty set is the non-empty set" (do
        return assertEqual (CustomSet.Set.ofList [2]) <| CustomSet.Set.ofList [] ∪ CustomSet.Set.ofList [2])
    |>.addTest "Union returns a set of all elements in either set -> union of a non-empty set and empty set is the non-empty set" (do
        return assertEqual (CustomSet.Set.ofList [1, 3]) <| CustomSet.Set.ofList [1, 3] ∪ CustomSet.Set.ofList [])
    |>.addTest "Union returns a set of all elements in either set -> union of non-empty sets contains all unique elements" (do
        return assertEqual (CustomSet.Set.ofList [3, 2, 1]) <| CustomSet.Set.ofList [1, 3] ∪ CustomSet.Set.ofList [2, 3])

def main : IO UInt32 := do
  runTestSuitesWithExitCode [customSetTests]
