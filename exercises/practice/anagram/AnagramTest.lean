import LeanTest
import Anagram

open LeanTest

def anagramTests : TestSuite :=
  (TestSuite.empty "Anagram")
  |>.addTest "no matches" (do
      return assertEqual [] (Anagram.findAnagrams "diaper" ["hello", "world", "zombies", "pants"]))
  |>.addTest "detects two anagrams" (do
      return assertEqual ["lemons", "melons"] (Anagram.findAnagrams "solemn" ["lemons", "cherry", "melons"]))
  |>.addTest "does not detect anagram subsets" (do
      return assertEqual [] (Anagram.findAnagrams "good" ["dog", "goody"]))
  |>.addTest "detects anagram" (do
      return assertEqual ["inlets"] (Anagram.findAnagrams "listen" ["enlists", "google", "inlets", "banana"]))
  |>.addTest "detects three anagrams" (do
      return assertEqual ["gallery", "regally", "largely"] (Anagram.findAnagrams "allergy" ["gallery", "ballerina", "regally", "clergy", "largely", "leading"]))
  |>.addTest "detects multiple anagrams with different case" (do
      return assertEqual ["Eons", "ONES"] (Anagram.findAnagrams "nose" ["Eons", "ONES"]))
  |>.addTest "does not detect non-anagrams with identical checksum" (do
      return assertEqual [] (Anagram.findAnagrams "mass" ["last"]))
  |>.addTest "detects anagrams case-insensitively" (do
      return assertEqual ["Carthorse"] (Anagram.findAnagrams "Orchestra" ["cashregister", "Carthorse", "radishes"]))
  |>.addTest "detects anagrams using case-insensitive subject" (do
      return assertEqual ["carthorse"] (Anagram.findAnagrams "Orchestra" ["cashregister", "carthorse", "radishes"]))
  |>.addTest "detects anagrams using case-insensitive possible matches" (do
      return assertEqual ["Carthorse"] (Anagram.findAnagrams "orchestra" ["cashregister", "Carthorse", "radishes"]))
  |>.addTest "does not detect an anagram if the original word is repeated" (do
      return assertEqual [] (Anagram.findAnagrams "go" ["goGoGO"]))
  |>.addTest "anagrams must use all letters exactly once" (do
      return assertEqual [] (Anagram.findAnagrams "tapper" ["patter"]))
  |>.addTest "words are not anagrams of themselves" (do
      return assertEqual [] (Anagram.findAnagrams "BANANA" ["BANANA"]))
  |>.addTest "words are not anagrams of themselves even if letter case is partially different" (do
      return assertEqual [] (Anagram.findAnagrams "BANANA" ["Banana"]))
  |>.addTest "words are not anagrams of themselves even if letter case is completely different" (do
      return assertEqual [] (Anagram.findAnagrams "BANANA" ["banana"]))
  |>.addTest "words other than themselves can be anagrams" (do
      return assertEqual ["Silent"] (Anagram.findAnagrams "LISTEN" ["LISTEN", "Silent"]))

  def main : IO UInt32 := do
    runTestSuitesWithExitCode [anagramTests]
