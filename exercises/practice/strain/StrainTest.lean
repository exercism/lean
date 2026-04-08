import LeanTest
import Strain

open LeanTest

structure StrainWrapper α where
  list : List α
  deriving BEq, Repr

instance {α} : Strain.Partition α (StrainWrapper α) where
  keep fn wrapper := ⟨Strain.Partition.keep fn wrapper.list⟩
  discard fn wrapper := ⟨Strain.Partition.discard fn wrapper.list⟩

def strainTests : TestSuite :=
  (TestSuite.empty "Strain")
  |>.addTest "keep on empty list returns empty list" (do
      let input : StrainWrapper Nat := ⟨[]⟩
      return assertEqual ⟨[]⟩ (Strain.Partition.keep (fun (_ : Nat) => true) input))
  |>.addTest "keeps everything" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        3,
        5
      ]⟩
      return assertEqual ⟨[
        1,
        3,
        5
      ]⟩ (Strain.Partition.keep (fun (_ : Nat) => true) input))
  |>.addTest "keeps nothing" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        3,
        5
      ]⟩
      return assertEqual ⟨[]⟩ (Strain.Partition.keep (fun (_ : Nat) => false) input))
  |>.addTest "keeps first and last" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        2,
        3
      ]⟩
      return assertEqual ⟨[
        1,
        3
      ]⟩ (Strain.Partition.keep (fun (x : Nat) => x % 2 == 1) input))
  |>.addTest "keeps neither first nor last" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        2,
        3
      ]⟩
      return assertEqual ⟨[
        2
      ]⟩ (Strain.Partition.keep (fun (x : Nat) => x % 2 == 0) input))
  |>.addTest "keeps strings" (do
      let input : StrainWrapper String := ⟨[
        "apple",
        "zebra",
        "banana",
        "zombies",
        "cherimoya",
        "zealot"
      ]⟩
      return assertEqual ⟨[
        "zebra",
        "zombies",
        "zealot"
      ]⟩ (Strain.Partition.keep (fun (x : String) => x.startsWith 'z') input))
  |>.addTest "keeps lists" (do
      let input : StrainWrapper (List Nat) := ⟨[
        [1, 2, 3],
        [5, 5, 5],
        [5, 1, 2],
        [2, 1, 2],
        [1, 5, 2],
        [2, 2, 1],
        [1, 2, 5]
      ]⟩
      return assertEqual ⟨[
        [5, 5, 5],
        [5, 1, 2],
        [1, 5, 2],
        [1, 2, 5]
      ]⟩ (Strain.Partition.keep (fun (x : (List Nat)) => x.contains 5) input))
  |>.addTest "discard on empty list returns empty list" (do
      let input : StrainWrapper Nat := ⟨[]⟩
      return assertEqual ⟨[]⟩ (Strain.Partition.discard (fun (_ : Nat) => true) input))
  |>.addTest "discards everything" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        3,
        5
      ]⟩
      return assertEqual ⟨[]⟩ (Strain.Partition.discard (fun (_ : Nat) => true) input))
  |>.addTest "discards nothing" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        3,
        5
      ]⟩
      return assertEqual ⟨[
        1,
        3,
        5
      ]⟩ (Strain.Partition.discard (fun (_ : Nat) => false) input))
  |>.addTest "discards first and last" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        2,
        3
      ]⟩
      return assertEqual ⟨[
        2
      ]⟩ (Strain.Partition.discard (fun (x : Nat) => x % 2 == 1) input))
  |>.addTest "discards neither first nor last" (do
      let input : StrainWrapper Nat := ⟨[
        1,
        2,
        3
      ]⟩
      return assertEqual ⟨[
        1,
        3
      ]⟩ (Strain.Partition.discard (fun (x : Nat) => x % 2 == 0) input))
  |>.addTest "discards strings" (do
      let input : StrainWrapper String := ⟨[
        "apple",
        "zebra",
        "banana",
        "zombies",
        "cherimoya",
        "zealot"
      ]⟩
      return assertEqual ⟨[
        "apple",
        "banana",
        "cherimoya"
      ]⟩ (Strain.Partition.discard (fun (x : String) => x.startsWith 'z') input))
  |>.addTest "discards lists" (do
      let input : StrainWrapper (List Nat) := ⟨[
        [1, 2, 3],
        [5, 5, 5],
        [5, 1, 2],
        [2, 1, 2],
        [1, 5, 2],
        [2, 2, 1],
        [1, 2, 5]
      ]⟩
      return assertEqual ⟨[
        [1, 2, 3],
        [2, 1, 2],
        [2, 2, 1]
      ]⟩ (Strain.Partition.discard (fun (x : (List Nat)) => x.contains 5) input))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [strainTests]
