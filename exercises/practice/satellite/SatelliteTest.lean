import LeanTest
import Satellite

open LeanTest

def satelliteTests : TestSuite :=
  (TestSuite.empty "Satellite")
  |>.addTest "Empty tree" (do
      return assertEqual (.ok
        .leaf)
        (Satellite.treeFromTraversals [] []))
  |>.addTest "Tree with one item" (do
      return assertEqual (.ok
        (.branch 'a'
          .leaf
          .leaf
        ))
        (Satellite.treeFromTraversals ['a'] ['a']))
  |>.addTest "Tree with many items" (do
      return assertEqual (.ok
        (.branch 'a'
          (.branch 'i'
            .leaf
            .leaf
          )
          (.branch 'x'
            (.branch 'f'
              .leaf
              .leaf
            )
            (.branch 'r'
              .leaf
              .leaf
            )
          )
        ))
        (Satellite.treeFromTraversals ['a', 'i', 'x', 'f', 'r'] ['i', 'a', 'f', 'x', 'r']))
  |>.addTest "Reject traversals of different length" (do
      return assertEqual (.error "traversals must have the same length")
        (Satellite.treeFromTraversals ['a', 'b'] ['b', 'a', 'r']))
  |>.addTest "Reject inconsistent traversals of same length" (do
      return assertEqual (.error "traversals must have the same elements")
        (Satellite.treeFromTraversals ['x', 'y', 'z'] ['a', 'b', 'c']))
  |>.addTest "Reject traversals with repeated items" (do
      return assertEqual (.error "traversals must contain unique items")
        (Satellite.treeFromTraversals ['a', 'b', 'a'] ['b', 'a', 'a']))
  |>.addTest "A degenerate binary tree" (do
      return assertEqual (.ok
        (.branch 'a'
          (.branch 'b'
            (.branch 'c'
              (.branch 'd'
                .leaf
                .leaf
              )
              .leaf
            )
            .leaf
          )
          .leaf
        ))
        (Satellite.treeFromTraversals ['a', 'b', 'c', 'd'] ['d', 'c', 'b', 'a']))
  |>.addTest "Another degenerate binary tree" (do
      return assertEqual (.ok
        (.branch 'a'
          .leaf
          (.branch 'b'
            .leaf
            (.branch 'c'
              .leaf
              (.branch 'd'
                .leaf
                .leaf
              )
            )
          )
        ))
        (Satellite.treeFromTraversals ['a', 'b', 'c', 'd'] ['a', 'b', 'c', 'd']))
  |>.addTest "Tree with many more items" (do
      return assertEqual (.ok
        (.branch 'a'
          (.branch 'b'
            (.branch 'd'
              (.branch 'g'
                .leaf
                .leaf
              )
              (.branch 'h'
                .leaf
                .leaf
              )
            )
            .leaf
          )
          (.branch 'c'
            (.branch 'e'
              .leaf
              .leaf
            )
            (.branch 'f'
              (.branch 'i'
                .leaf
                .leaf
              )
              .leaf
            )
          )
        ))
        (Satellite.treeFromTraversals ['a', 'b', 'd', 'g', 'h', 'c', 'e', 'f', 'i'] ['g', 'd', 'h', 'b', 'a', 'e', 'c', 'i', 'f']))
  |>.addTest "Left leaning tree of two" (do
      return assertEqual (.ok
        (.branch 'b'
          (.branch 'a'
            .leaf
            .leaf
          )
          .leaf
        ))
        (Satellite.treeFromTraversals ['b', 'a'] ['a', 'b']))
  |>.addTest "Right leaning tree of two" (do
      return assertEqual (.ok
        (.branch 'a'
          .leaf
          (.branch 'b'
            .leaf
            .leaf
          )
        ))
        (Satellite.treeFromTraversals ['a', 'b'] ['a', 'b']))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [satelliteTests]
