import LeanTest
import Triangle

open LeanTest

def triangleTests : TestSuite :=
  (TestSuite.empty "Triangle")
  |>.addTest "equilateral triangle -> all sides are equal" (do
      return assertEqual true (Triangle.equilateral [2, 2, 2]))
  |>.addTest "equilateral triangle -> any side is unequal" (do
      return assertEqual false (Triangle.equilateral [2, 3, 2]))
  |>.addTest "equilateral triangle -> no sides are equal" (do
      return assertEqual false (Triangle.equilateral [5, 4, 6]))
  |>.addTest "equilateral triangle -> all zero sides is not a triangle" (do
      return assertEqual false (Triangle.equilateral [0, 0, 0]))
  |>.addTest "equilateral triangle -> sides may be floats" (do
      return assertEqual true (Triangle.equilateral [0.5, 0.5, 0.5]))
  |>.addTest "isosceles triangle -> last two sides are equal" (do
      return assertEqual true (Triangle.isosceles [3, 4, 4]))
  |>.addTest "isosceles triangle -> first two sides are equal" (do
      return assertEqual true (Triangle.isosceles [4, 4, 3]))
  |>.addTest "isosceles triangle -> first and last sides are equal" (do
      return assertEqual true (Triangle.isosceles [4, 3, 4]))
  |>.addTest "isosceles triangle -> equilateral triangles are also isosceles" (do
      return assertEqual true (Triangle.isosceles [4, 4, 4]))
  |>.addTest "isosceles triangle -> no sides are equal" (do
      return assertEqual false (Triangle.isosceles [2, 3, 4]))
  |>.addTest "isosceles triangle -> first triangle inequality violation" (do
      return assertEqual false (Triangle.isosceles [1, 1, 3]))
  |>.addTest "isosceles triangle -> second triangle inequality violation" (do
      return assertEqual false (Triangle.isosceles [1, 3, 1]))
  |>.addTest "isosceles triangle -> third triangle inequality violation" (do
      return assertEqual false (Triangle.isosceles [3, 1, 1]))
  |>.addTest "isosceles triangle -> sides may be floats" (do
      return assertEqual true (Triangle.isosceles [0.5, 0.4, 0.5]))
  |>.addTest "scalene triangle -> no sides are equal" (do
      return assertEqual true (Triangle.scalene [5, 4, 6]))
  |>.addTest "scalene triangle -> all sides are equal" (do
      return assertEqual false (Triangle.scalene [4, 4, 4]))
  |>.addTest "scalene triangle -> first and second sides are equal" (do
      return assertEqual false (Triangle.scalene [4, 4, 3]))
  |>.addTest "scalene triangle -> first and third sides are equal" (do
      return assertEqual false (Triangle.scalene [3, 4, 3]))
  |>.addTest "scalene triangle -> second and third sides are equal" (do
      return assertEqual false (Triangle.scalene [4, 3, 3]))
  |>.addTest "scalene triangle -> may not violate triangle inequality" (do
      return assertEqual false (Triangle.scalene [7, 3, 2]))
  |>.addTest "scalene triangle -> sides may be floats" (do
      return assertEqual true (Triangle.scalene [0.5, 0.4, 0.6]))

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [triangleTests]
