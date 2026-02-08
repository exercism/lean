import LeanTest
import BinarySearchTree

open LeanTest

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def binarySearchTreeTests : TestSuite :=
  (TestSuite.empty "BinarySearchTree")
    |>.addTest "data is retained" (do
      let tree := BinarySearchTree.buildTree [
        4
      ]
      return assertEqual 4 tree.data!
    )
    |>.addTest "insert data at proper node -> smaller number at left node" (do
      let tree := BinarySearchTree.buildTree [
        4, 2
      ]
      return assertEqual 4 tree.data!
          ++ assertEqual 2 tree.left!.data!
    )
    |>.addTest "insert data at proper node -> same number at left node" (do
      let tree := BinarySearchTree.buildTree [
        4, 4
      ]
      return assertEqual 4 tree.data!
          ++ assertEqual 4 tree.left!.data!
    )
    |>.addTest "insert data at proper node -> greater number at right node" (do
      let tree := BinarySearchTree.buildTree [
        4, 5
      ]
      return assertEqual 4 tree.data!
          ++ assertEqual 5 tree.right!.data!
    )
    |>.addTest "can create complex tree" (do
      let tree := BinarySearchTree.buildTree [
        4, 2, 6, 1, 3, 5, 7
      ]
      return assertEqual 4 tree.data!
          ++ assertEqual 2 tree.left!.data!
          ++ assertEqual 1 tree.left!.left!.data!
          ++ assertEqual 3 tree.left!.right!.data!
          ++ assertEqual 6 tree.right!.data!
          ++ assertEqual 5 tree.right!.left!.data!
          ++ assertEqual 7 tree.right!.right!.data!
    )
    |>.addTest "can sort data -> can sort single number" (do
      let tree := BinarySearchTree.buildTree [
        2
      ]
      return assertEqual [
        2
      ] tree.sort)
    |>.addTest "can sort data -> can sort if second number is smaller than first" (do
      let tree := BinarySearchTree.buildTree [
        2, 1
      ]
      return assertEqual [
        1, 2
      ] tree.sort)
    |>.addTest "can sort data -> can sort if second number is same as first" (do
      let tree := BinarySearchTree.buildTree [
        2, 2
      ]
      return assertEqual [
        2, 2
      ] tree.sort)
    |>.addTest "can sort data -> can sort if second number is greater than first" (do
      let tree := BinarySearchTree.buildTree [
        2, 3
      ]
      return assertEqual [
        2, 3
      ] tree.sort)
    |>.addTest "can sort data -> can sort complex tree" (do
      let tree := BinarySearchTree.buildTree [
        2, 1, 3, 6, 7, 5
      ]
      return assertEqual [
        1, 2, 3, 5, 6, 7
      ] tree.sort)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [binarySearchTreeTests]
