import LeanTest
import Zipper

open LeanTest
open Zipper

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def initialTree : BinTree Int :=
  .node 1
    (.node 2
      .nil
      (.node 3 .nil .nil))
    (.node 4 .nil .nil)

def zipperTests : TestSuite :=
  (TestSuite.empty "Zipper")
    |>.addTest "data is retained" (do
      let zipper := fromTree initialTree
      let tree := zipper.toTree
      return assertEqual initialTree tree)
    |>.addTest "left, right and value" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.right
        >>= Zipper.value
      return assertEqual (some 3) result)
    |>.addTest "dead end" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.left
      return assertEqual (none : Option (Zipper Int)) result)
    |>.addTest "tree from deep focus" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.right
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual initialTree z.toTree)
    |>.addTest "traversing up from top" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.up
      return assertEqual (none : Option (Zipper Int)) result)
    |>.addTest "left, right, and up" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.up
        >>= Zipper.right
        >>= Zipper.up
        >>= Zipper.left
        >>= Zipper.right
        >>= Zipper.value
      return assertEqual (some 3) result)
    |>.addTest "test ability to descend multiple levels and return" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.right
        >>= Zipper.up
        >>= Zipper.up
        >>= Zipper.value
      return assertEqual (some 1) result)
    |>.addTest "set_value" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        |>.map (Zipper.setValue 5)
      let expected : BinTree Int :=
        .node 1
          (.node 5
            .nil
            (.node 3 .nil .nil))
          (.node 4 .nil .nil)
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual expected z.toTree)
    |>.addTest "set_value after traversing up" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.right
        >>= Zipper.up
        |>.map (Zipper.setValue 5)
      let expected : BinTree Int :=
        .node 1
          (.node 5
            .nil
            (.node 3 .nil .nil))
          (.node 4 .nil .nil)
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual expected z.toTree)
    |>.addTest "set_left with leaf" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        |>.map (Zipper.setLeft (.node 5 .nil .nil))
      let expected : BinTree Int :=
        .node 1
          (.node 2
            (.node 5 .nil .nil)
            (.node 3 .nil .nil))
          (.node 4 .nil .nil)
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual expected z.toTree)
    |>.addTest "set_right with null" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        |>.map (Zipper.setRight .nil)
      let expected : BinTree Int :=
        .node 1
          (.node 2
            .nil
            .nil)
          (.node 4 .nil .nil)
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual expected z.toTree)
    |>.addTest "set_right with subtree" (do
      let modified := (fromTree initialTree).setRight
        (.node 6
          (.node 7 .nil .nil)
          (.node 8 .nil .nil))
      let expected : BinTree Int :=
        .node 1
          (.node 2
            .nil
            (.node 3 .nil .nil))
          (.node 6
            (.node 7 .nil .nil)
            (.node 8 .nil .nil))
      return assertEqual expected modified.toTree)
    |>.addTest "set_value on deep focus" (do
      let result := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.right
        |>.map (Zipper.setValue 5)
      let expected : BinTree Int :=
        .node 1
          (.node 2
            .nil
            (.node 5 .nil .nil))
          (.node 4 .nil .nil)
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual expected z.toTree)
    |>.addTest "different paths to same zipper" (do
      let path1 := (some (fromTree initialTree))
        >>= Zipper.left
        >>= Zipper.up
        >>= Zipper.right
      let path2 := (some (fromTree initialTree))
        >>= Zipper.right
      match path1, path2 with
      | some z1, some z2 => return assertEqual z1.toTree z2.toTree
      | none, _ => return .failure "path1 returned none"
      | _, none => return .failure "path2 returned none")
    -- Extra test cases for String type
    |>.addTest "string tree: data is retained" (do
      let tree : BinTree String :=
        .node "a"
          (.node "b" .nil (.node "c" .nil .nil))
          (.node "d" .nil .nil)
      let zipper := fromTree tree
      return assertEqual tree zipper.toTree)
    |>.addTest "string tree: left, right and value" (do
      let tree : BinTree String :=
        .node "a"
          (.node "b" .nil (.node "c" .nil .nil))
          (.node "d" .nil .nil)
      let result := (some (fromTree tree))
        >>= Zipper.left
        >>= Zipper.right
        >>= Zipper.value
      return assertEqual (some "c") result)
    |>.addTest "string tree: set_value" (do
      let tree : BinTree String :=
        .node "a"
          (.node "b" .nil (.node "c" .nil .nil))
          (.node "d" .nil .nil)
      let result := (some (fromTree tree))
        >>= Zipper.left
        |>.map (Zipper.setValue "x")
      let expected : BinTree String :=
        .node "a"
          (.node "x" .nil (.node "c" .nil .nil))
          (.node "d" .nil .nil)
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual expected z.toTree)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [zipperTests]
