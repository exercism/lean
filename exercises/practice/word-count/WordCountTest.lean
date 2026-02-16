import LeanTest
import Std
import WordCount

open LeanTest

def wordCountTests : TestSuite :=
  (TestSuite.empty "WordCount")
  |>.addTest "count one word" (do
      return assertEqual [
        ("word", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "word"))
  |>.addTest "count one of each word" (do
      return assertEqual [
        ("each", 1),
        ("of", 1),
        ("one", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "one of each"))
  |>.addTest "multiple occurrences of a word" (do
      return assertEqual [
        ("blue", 1),
        ("fish", 4),
        ("one", 1),
        ("red", 1),
        ("two", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "one fish two fish red fish blue fish"))
  |>.addTest "handles cramped lists" (do
      return assertEqual [
        ("one", 1),
        ("three", 1),
        ("two", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "one,two,three"))
  |>.addTest "handles expanded lists" (do
      return assertEqual [
        ("one", 1),
        ("three", 1),
        ("two", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "one,\ntwo,\nthree"))
  |>.addTest "ignore punctuation" (do
      return assertEqual [
        ("as", 1),
        ("car", 1),
        ("carpet", 1),
        ("java", 1),
        ("javascript", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "car: carpet as java: javascript!!&@$%^&"))
  |>.addTest "include numbers" (do
      return assertEqual [
        ("1", 1),
        ("2", 1),
        ("testing", 2)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "testing, 1, 2 testing"))
  |>.addTest "normalize case" (do
      return assertEqual [
        ("go", 3),
        ("stop", 2)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "go Go GO Stop stop"))
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
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "'First: don't laugh. Then: don't cry. You're getting it.'"))
  |>.addTest "with quotations" (do
      return assertEqual [
        ("and", 1),
        ("between", 1),
        ("can't", 1),
        ("joe", 1),
        ("large", 2),
        ("tell", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "Joe can't tell between 'large' and large."))
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
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "Joe can't tell between app, apple and a."))
  |>.addTest "multiple spaces not detected as a word" (do
      return assertEqual [
        ("multiple", 1),
        ("whitespaces", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords " multiple   whitespaces"))
  |>.addTest "alternating word separators not detected as a word" (do
      return assertEqual [
        ("one", 1),
        ("three", 1),
        ("two", 1)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords ",\n,one,\n ,two \n 'three'"))
  |>.addTest "quotation for word with apostrophe" (do
      return assertEqual [
        ("can", 1),
        ("can't", 2)
      ] ((·.mergeSort (λ (k1, _) (k2, _) => k1 ≤ k2)) <| Std.HashMap.toList <| WordCount.countWords "can, can't, 'can't'"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [wordCountTests]
