import LeanTest
import BookStore

open LeanTest

def bookStoreTests : TestSuite :=
  (TestSuite.empty "BookStore")
  |>.addTest "Only a single book" (do
      return assertEqual 800 (BookStore.total [
        ⟨1, by decide⟩
      ]))
  |>.addTest "Two of the same book" (do
      return assertEqual 1600 (BookStore.total [
        ⟨2, by decide⟩,
        ⟨2, by decide⟩
      ]))
  |>.addTest "Empty basket" (do
      return assertEqual 0 (BookStore.total []))
  |>.addTest "Two different books" (do
      return assertEqual 1520 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨2, by decide⟩
      ]))
  |>.addTest "Three different books" (do
      return assertEqual 2160 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩
      ]))
  |>.addTest "Four different books" (do
      return assertEqual 2560 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩
      ]))
  |>.addTest "Five different books" (do
      return assertEqual 3000 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "Two groups of four is cheaper than group of five plus group of three" (do
      return assertEqual 5120 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "Two groups of four is cheaper than groups of five and three" (do
      return assertEqual 5120 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "Group of four plus group of two is cheaper than two groups of three" (do
      return assertEqual 4080 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩
      ]))
  |>.addTest "Two each of first four books and one copy each of rest" (do
      return assertEqual 5560 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "Two copies of each book" (do
      return assertEqual 6000 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "Three copies of first book and two each of remaining" (do
      return assertEqual 6800 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩,
        ⟨1, by decide⟩
      ]))
  |>.addTest "Three each of first two books and two each of remaining books" (do
      return assertEqual 7520 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩
      ]))
  |>.addTest "Four groups of four are cheaper than two groups each of five and three" (do
      return assertEqual 10240 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "Check that groups of four are created properly even when there are more groups of three than groups of five" (do
      return assertEqual 14560 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩
      ]))
  |>.addTest "One group of one and four is cheaper than one group of two and three" (do
      return assertEqual 3360 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩
      ]))
  |>.addTest "One group of one and two plus three groups of four is cheaper than one group of each size" (do
      return assertEqual 10000 (BookStore.total [
        ⟨1, by decide⟩,
        ⟨2, by decide⟩,
        ⟨2, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨3, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨4, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩,
        ⟨5, by decide⟩
      ]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [bookStoreTests]
