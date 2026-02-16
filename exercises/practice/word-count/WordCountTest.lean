import LeanTest
import Std
import WordCount

open LeanTest

def wordCountTests : TestSuite :=
  (TestSuite.empty "WordCount")
  |>.addTest "count one word" (do
      return assertEqual [
        ("word", 1)
      ] $ WordCount.countWords "word"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "count one of each word" (do
      return assertEqual [
        ("each", 1),
        ("of", 1),
        ("one", 1)
      ] $ WordCount.countWords "one of each"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "multiple occurrences of a word" (do
      return assertEqual [
        ("blue", 1),
        ("fish", 4),
        ("one", 1),
        ("red", 1),
        ("two", 1)
      ] $ WordCount.countWords "one fish two fish red fish blue fish"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "handles cramped lists" (do
      return assertEqual [
        ("one", 1),
        ("three", 1),
        ("two", 1)
      ] $ WordCount.countWords "one,two,three"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "handles expanded lists" (do
      return assertEqual [
        ("one", 1),
        ("three", 1),
        ("two", 1)
      ] $ WordCount.countWords "one,\ntwo,\nthree"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "ignore punctuation" (do
      return assertEqual [
        ("as", 1),
        ("car", 1),
        ("carpet", 1),
        ("java", 1),
        ("javascript", 1)
      ] $ WordCount.countWords "car: carpet as java: javascript!!&@$%^&"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "include numbers" (do
      return assertEqual [
        ("1", 1),
        ("2", 1),
        ("testing", 2)
      ] $ WordCount.countWords "testing, 1, 2 testing"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "normalize case" (do
      return assertEqual [
        ("go", 3),
        ("stop", 2)
      ] $ WordCount.countWords "go Go GO Stop stop"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "with apostrophes" (do
      return assertEqual [
        ("cry", 1),
        ("don't", 2),
        ("first", 1),
        ("getting", 1),
        ("it", 1),
        ("laugh", 1),
        ("then", 1),
        ("you're", 1)
      ] $ WordCount.countWords "'First: don't laugh. Then: don't cry. You're getting it.'"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "with quotations" (do
      return assertEqual [
        ("and", 1),
        ("between", 1),
        ("can't", 1),
        ("joe", 1),
        ("large", 2),
        ("tell", 1)
      ] $ WordCount.countWords "Joe can't tell between 'large' and large."
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "substrings from the beginning" (do
      return assertEqual [
        ("a", 1),
        ("and", 1),
        ("app", 1),
        ("apple", 1),
        ("between", 1),
        ("can't", 1),
        ("joe", 1),
        ("tell", 1)
      ] $ WordCount.countWords "Joe can't tell between app, apple and a."
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "multiple spaces not detected as a word" (do
      return assertEqual [
        ("multiple", 1),
        ("whitespaces", 1)
      ] $ WordCount.countWords " multiple   whitespaces"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "alternating word separators not detected as a word" (do
      return assertEqual [
        ("one", 1),
        ("three", 1),
        ("two", 1)
      ] $ WordCount.countWords ",\n,one,\n ,two \n 'three'"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)
  |>.addTest "quotation for word with apostrophe" (do
      return assertEqual [
        ("can", 1),
        ("can't", 2)
      ] $ WordCount.countWords "can, can't, 'can't'"
        |>.toList
        |>.mergeSort λ (k1, _) (k2, _) => k1 ≤ k2)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [wordCountTests]
