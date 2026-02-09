import LeanTest
import LinkedList
import Std

open LeanTest
open Std

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def linkedListTests : TestSuite :=
  (TestSuite.empty "LinkedList")
  |>.addTest "pop gets element from the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 7
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 7) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "push/pop respectively add/remove at the end of the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 11
        list.push 13
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 13) result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 11) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "shift gets an element from the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 17
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 17) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "shift gets first element from the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 23
        list.push 5
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 23) result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 5) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "unshift adds element at start of the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.unshift 23
        list.unshift 5
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 5) result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 23) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "pop, push, shift, and unshift can be used in any order" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 1
        list.push 2
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 2) result)
        list.push 3
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 1) result)
        list.unshift 4
        list.push 5
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 4) result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 5) result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 3) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "count an empty list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        let result ← list.count
        asserts := asserts.push (assertEqual 0 result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "count a list with items" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 37
        list.push 1
        let result ← list.count
        asserts := asserts.push (assertEqual 2 result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "count is correct after mutation" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 31
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        list.unshift 43
        let result ← list.count
        asserts := asserts.push (assertEqual 2 result)
        let _ ← list.shift
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        let _ ← list.pop
        let result ← list.count
        asserts := asserts.push (assertEqual 0 result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "popping to empty doesn't break the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 41
        list.push 59
        let _ ← list.pop
        let _ ← list.pop
        list.push 47
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 47) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "shifting to empty doesn't break the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 41
        list.push 59
        let _ ← list.shift
        let _ ← list.shift
        list.push 47
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 47) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes the only element" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 61
        list.delete 61
        let result ← list.count
        asserts := asserts.push (assertEqual 0 result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes the element with the specified value from the list" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 71
        list.push 83
        list.push 79
        list.delete 83
        let result ← list.count
        asserts := asserts.push (assertEqual 2 result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 79) result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 71) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes the element with the specified value from the list, re-assigns tail" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 71
        list.push 83
        list.push 79
        list.delete 83
        let result ← list.count
        asserts := asserts.push (assertEqual 2 result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 79) result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 71) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes the element with the specified value from the list, re-assigns head" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 71
        list.push 83
        list.push 79
        list.delete 83
        let result ← list.count
        asserts := asserts.push (assertEqual 2 result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 71) result)
        let result ← list.shift
        asserts := asserts.push (assertEqual (some 79) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes the first of two elements" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 97
        list.push 101
        list.delete 97
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 101) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes the second of two elements" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 97
        list.push 101
        list.delete 101
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 97) result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "delete does not modify the list if the element is not found" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 89
        list.delete 103
        let result ← list.count
        asserts := asserts.push (assertEqual 1 result)
        return (asserts.foldl (· ++ ·) .success))
  |>.addTest "deletes only the first occurrence" (do
      return runST fun _ => do
        let list : LinkedList.LinkedList _ Int ← LinkedList.LinkedList.empty
        let mut asserts : Array AssertionResult := #[]
        list.push 73
        list.push 9
        list.push 9
        list.push 107
        list.delete 9
        let result ← list.count
        asserts := asserts.push (assertEqual 3 result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 107) result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 9) result)
        let result ← list.pop
        asserts := asserts.push (assertEqual (some 73) result)
        return (asserts.foldl (· ++ ·) .success))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [linkedListTests]
