import LeanTest
import WordCount

open LeanTest

def sort (list : List (String × Nat)) : List (String × Nat) :=
  list.mergeSort (fun x y => x.fst <= y.fst)

def sortedResult (sentence : String) : List (String × Nat) :=
  WordCount.countWords sentence |> Std.HashMap.toList |> sort

def wordCountTests : TestSuite :=
  (TestSuite.empty "WordCount")
  |>.addTest "count one word" (do
      return assertEqual (sort [("word", 1)]) (sortedResult "word"))
  |>.addTest "count one of each word" (do
      return assertEqual (sort [("one", 1), ("of", 1), ("each", 1)]) (sortedResult "one of each"))
  |>.addTest "multiple occurrences of a word" (do
      return assertEqual (sort [("one", 1), ("fish", 4), ("two", 1), ("red", 1), ("blue", 1)]) (sortedResult "one fish two fish red fish blue fish"))
  |>.addTest "handles cramped lists" (do
      return assertEqual (sort [("one", 1), ("two", 1), ("three", 1)]) (sortedResult "one,two,three"))
  |>.addTest "handles expanded lists" (do
      return assertEqual (sort [("one", 1), ("two", 1), ("three", 1)]) (sortedResult "one,\ntwo,\nthree"))
  |>.addTest "ignore punctuation" (do
      return assertEqual (sort [("car", 1), ("carpet", 1), ("as", 1), ("java", 1), ("javascript", 1)]) (sortedResult "car: carpet as java: javascript!!&@$%^&"))
  |>.addTest "include numbers" (do
      return assertEqual (sort [("testing", 2), ("1", 1), ("2", 1)]) (sortedResult "testing, 1, 2 testing"))
  |>.addTest "normalize case" (do
      return assertEqual (sort [("go", 3), ("stop", 2)]) (sortedResult "go Go GO Stop stop"))
  |>.addTest "with apostrophes" (do
      return assertEqual (sort [("first", 1), ("don't", 2), ("laugh", 1), ("then", 1), ("cry", 1), ("you're", 1), ("getting", 1), ("it", 1)] ) (sortedResult "'First: don't laugh. Then: don't cry. You're getting it.'"))
  |>.addTest "with quotations" (do
      return assertEqual (sort [("joe", 1), ("can't", 1), ("tell", 1), ("between", 1), ("large", 2), ("and", 1)]) (sortedResult "Joe can't tell between 'large' and large."))
  |>.addTest "substrings from the beginning" (do
      return assertEqual (sort [("joe", 1), ("can't", 1), ("tell", 1), ("between", 1), ("app", 1), ("apple", 1), ("and", 1), ("a", 1)]) (sortedResult "Joe can't tell between app, apple and a."))
  |>.addTest "multiple spaces not detected as a word" (do
      return assertEqual (sort [("multiple", 1), ("whitespaces", 1)]) (sortedResult " multiple   whitespaces"))
  |>.addTest "alternating word separators not detected as a word" (do
      return assertEqual (sort [("one", 1), ("two", 1), ("three", 1)]) (sortedResult ",\n,one,\n ,two \n 'three'"))
  |>.addTest "quotation for word with apostrophe" (do
      return assertEqual (sort [("can", 1), ("can't", 2)]) (sortedResult "can, can't, 'can't'"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [wordCountTests]
