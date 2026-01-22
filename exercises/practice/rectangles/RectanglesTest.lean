import LeanTest
import Rectangles

open LeanTest

def rectanglesTests : TestSuite :=
  (TestSuite.empty "Rectangles")
  |>.addTest "no rows" (do
      return assertEqual 0 (Rectangles.rectangles #[]))
  |>.addTest "no columns" (do
      return assertEqual 0 (Rectangles.rectangles #[""]))
  |>.addTest "no rectangles" (do
      return assertEqual 0 (Rectangles.rectangles #[" "]))
  |>.addTest "one rectangle" (do
      return assertEqual 1 (Rectangles.rectangles #["+-+","| |","+-+"]))
  |>.addTest "two rectangles without shared parts" (do
      return assertEqual 2 (Rectangles.rectangles #["  +-+","  | |","+-+-+","| |  ","+-+  "]))
  |>.addTest "five rectangles with shared parts" (do
      return assertEqual 5 (Rectangles.rectangles #["  +-+","  | |","+-+-+","| | |","+-+-+"]))
  |>.addTest "rectangle of height 1 is counted" (do
      return assertEqual 1 (Rectangles.rectangles #["+--+","+--+"]))
  |>.addTest "rectangle of width 1 is counted" (do
      return assertEqual 1 (Rectangles.rectangles #["++","||","++"]))
  |>.addTest "1x1 square is counted" (do
      return assertEqual 1 (Rectangles.rectangles #["++","++"]))
  |>.addTest "only complete rectangles are counted" (do
      return assertEqual 1 (Rectangles.rectangles #["  +-+","    |","+-+-+","| | -","+-+-+"]))
  |>.addTest "rectangles can be of different sizes" (do
      return assertEqual 3 (Rectangles.rectangles #["+------+----+","|      |    |","+---+--+    |","|   |       |","+---+-------+"]))
  |>.addTest "corner is required for a rectangle to be complete" (do
      return assertEqual 2 (Rectangles.rectangles #["+------+----+","|      |    |","+------+    |","|   |       |","+---+-------+"]))
  |>.addTest "large input with many rectangles" (do
      return assertEqual 60 (Rectangles.rectangles #["+---+--+----+","|   +--+----+","+---+--+    |","|   +--+----+","+---+--+--+-+","+---+--+--+-+","+------+  | |","          +-+"]))
  |>.addTest "rectangles must have four sides" (do
      return assertEqual 5 (Rectangles.rectangles #["+-+ +-+","| | | |","+-+-+-+","  | |  ","+-+-+-+","| | | |","+-+ +-+"]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [rectanglesTests]
