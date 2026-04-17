import LeanTest
import PascalsTriangle

open LeanTest

instance : HAppend AssertionResult AssertionResult AssertionResult where
    hAppend
        | .success, .success => .success
        | .failure msg, _    => .failure msg
        | _, .failure msg    => .failure msg

def pascalsTriangleTests : TestSuite :=
  (TestSuite.empty "PascalsTriangle")
  |>.addTest "zero rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      return result)
  |>.addTest "single row" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      return result)
  |>.addTest "two rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      result := result ++ assertEqual #[1, 1] (← triangle(2))
      return result)
  |>.addTest "three rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      result := result ++ assertEqual #[1, 1] (← triangle(2))
      result := result ++ assertEqual #[1, 2, 1] (← triangle(3))
      return result)
  |>.addTest "four rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      result := result ++ assertEqual #[1, 1] (← triangle(2))
      result := result ++ assertEqual #[1, 2, 1] (← triangle(3))
      result := result ++ assertEqual #[1, 3, 3, 1] (← triangle(4))
      return result)
  |>.addTest "five rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      result := result ++ assertEqual #[1, 1] (← triangle(2))
      result := result ++ assertEqual #[1, 2, 1] (← triangle(3))
      result := result ++ assertEqual #[1, 3, 3, 1] (← triangle(4))
      result := result ++ assertEqual #[1, 4, 6, 4, 1] (← triangle(5))
      return result)
  |>.addTest "six rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      result := result ++ assertEqual #[1, 1] (← triangle(2))
      result := result ++ assertEqual #[1, 2, 1] (← triangle(3))
      result := result ++ assertEqual #[1, 3, 3, 1] (← triangle(4))
      result := result ++ assertEqual #[1, 4, 6, 4, 1] (← triangle(5))
      result := result ++ assertEqual #[1, 5, 10, 10, 5, 1] (← triangle(6))
      return result)
  |>.addTest "ten rows" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let mut result := assertEqual #[] (← triangle(0))
      result := result ++ assertEqual #[1] (← triangle(1))
      result := result ++ assertEqual #[1, 1] (← triangle(2))
      result := result ++ assertEqual #[1, 2, 1] (← triangle(3))
      result := result ++ assertEqual #[1, 3, 3, 1] (← triangle(4))
      result := result ++ assertEqual #[1, 4, 6, 4, 1] (← triangle(5))
      result := result ++ assertEqual #[1, 5, 10, 10, 5, 1] (← triangle(6))
      result := result ++ assertEqual #[1, 6, 15, 20, 15, 6, 1] (← triangle(7))
      result := result ++ assertEqual #[1, 7, 21, 35, 35, 21, 7, 1] (← triangle(8))
      result := result ++ assertEqual #[1, 8, 28, 56, 70, 56, 28, 8, 1] (← triangle(9))
      result := result ++ assertEqual #[1, 9, 36, 84, 126, 126, 84, 36, 9, 1] (← triangle(10))
      return result)
  |>.addTest "big row" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let row ← triangle(100)
      let prev ← triangle(99)
      let mut result := (assertEqual 100 row.size) ++ (assertEqual 99 prev.size)
      result := result ++ (assertEqual 1 row[0]!) ++ (assertEqual 1 row[row.size - 1]!)
      for i in [1:row.size - 1] do
        result := result ++ assertEqual row[i]! (prev[i - 1]! + prev[i]!)
      return result)
  |>.addTest "very big row" (do
      let triangle : PascalsTriangle.Triangle ← PascalsTriangle.mkTriangle
      let row ← triangle(1000)
      let prev ← triangle(999)
      let mut result := (assertEqual 1000 row.size) ++ (assertEqual 999 prev.size)
      result := result ++ (assertEqual 1 row[0]!) ++ (assertEqual 1 row[row.size - 1]!)
      for i in [1:row.size - 1] do
        result := result ++ assertEqual row[i]! (prev[i - 1]! + prev[i]!)
      return result)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [pascalsTriangleTests]
