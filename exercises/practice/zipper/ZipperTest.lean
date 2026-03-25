import LeanTest
import Zipper

open LeanTest
open Zipper

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def initialTree : BinTree :=
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
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.right >>= (·.value)
      return assertEqual (some 3) result)
    |>.addTest "dead end" (do
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.left
      return assertEqual none result)
    |>.addTest "tree from deep focus" (do
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.right
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z => return assertEqual initialTree z.toTree)
    |>.addTest "traversing up from top" (do
      let zipper := fromTree initialTree
      let result := zipper.up
      return assertEqual none result)
    |>.addTest "left, right, and up" (do
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.up >>= Zipper.right >>= Zipper.up >>= Zipper.left >>= Zipper.right >>= (·.value)
      return assertEqual (some 3) result)
    |>.addTest "test ability to descend multiple levels and return" (do
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.right >>= Zipper.up >>= Zipper.up
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z =>
        match z.value with
        | none => return .failure "Expected a value but got none"
        | some v => return assertEqual 1 v)
    |>.addTest "set_value" (do
      let zipper := fromTree initialTree
      let result := zipper.left
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z =>
        let modified := z.setValue 5
        let expected : BinTree :=
          .node 1
            (.node 5
              .nil
              (.node 3 .nil .nil))
            (.node 4 .nil .nil)
        return assertEqual expected modified.toTree)
    |>.addTest "set_value after traversing up" (do
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.right >>= Zipper.up
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z =>
        let modified := z.setValue 5
        let expected : BinTree :=
          .node 1
            (.node 5
              .nil
              (.node 3 .nil .nil))
            (.node 4 .nil .nil)
        return assertEqual expected modified.toTree)
    |>.addTest "set_left with leaf" (do
      let zipper := fromTree initialTree
      let result := zipper.left
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z =>
        let modified := z.setLeft (.node 5 .nil .nil)
        let expected : BinTree :=
          .node 1
            (.node 2
              (.node 5 .nil .nil)
              (.node 3 .nil .nil))
            (.node 4 .nil .nil)
        return assertEqual expected modified.toTree)
    |>.addTest "set_right with null" (do
      let zipper := fromTree initialTree
      let result := zipper.left
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z =>
        let modified := z.setRight .nil
        let expected : BinTree :=
          .node 1
            (.node 2
              .nil
              .nil)
            (.node 4 .nil .nil)
        return assertEqual expected modified.toTree)
    |>.addTest "set_right with subtree" (do
      let modified := (fromTree initialTree).setRight
        (.node 6
          (.node 7 .nil .nil)
          (.node 8 .nil .nil))
      let expected : BinTree :=
        .node 1
          (.node 2
            .nil
            (.node 3 .nil .nil))
          (.node 6
            (.node 7 .nil .nil)
            (.node 8 .nil .nil))
      return assertEqual expected modified.toTree)
    |>.addTest "set_value on deep focus" (do
      let zipper := fromTree initialTree
      let result := zipper.left >>= Zipper.right
      match result with
      | none => return .failure "Expected a zipper but got none"
      | some z =>
        let modified := z.setValue 5
        let expected : BinTree :=
          .node 1
            (.node 2
              .nil
              (.node 5 .nil .nil))
            (.node 4 .nil .nil)
        return assertEqual expected modified.toTree)
    |>.addTest "different paths to same zipper" (do
      let zipper := fromTree initialTree
      let path1 := zipper.left >>= Zipper.up >>= Zipper.right
      let path2 := zipper.right
      match path1, path2 with
      | some z1, some z2 => return assertEqual z1.toTree z2.toTree
      | none, _ => return .failure "path1 returned none"
      | _, none => return .failure "path2 returned none")

def main : IO UInt32 := do
  runTestSuitesWithExitCode [zipperTests]
