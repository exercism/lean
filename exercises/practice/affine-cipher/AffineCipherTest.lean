import LeanTest
import AffineCipher

open LeanTest

def affineCipherTests : TestSuite :=
  (TestSuite.empty "AffineCipher")
  |>.addTest "encode - encode yes" (do
      return assertEqual (some "xbt")
          (AffineCipher.encode "yes" 5 7))
  |>.addTest "encode - encode no" (do
      return assertEqual (some "fu")
          (AffineCipher.encode "no" 15 18))
  |>.addTest "encode - encode OMG" (do
      return assertEqual (some "lvz")
          (AffineCipher.encode "OMG" 21 3))
  |>.addTest "encode - encode O M G" (do
      return assertEqual (some "hjp")
          (AffineCipher.encode "O M G" 25 47))
  |>.addTest "encode - encode mindblowingly" (do
      return assertEqual (some "rzcwa gnxzc dgt")
          (AffineCipher.encode "mindblowingly" 11 15))
  |>.addTest "encode - encode numbers" (do
      return assertEqual (some "jqgjc rw123 jqgjc rw")
          (AffineCipher.encode "Testing,1 2 3, testing." 3 4))
  |>.addTest "encode - encode deep thought" (do
      return assertEqual (some "iynia fdqfb ifje")
          (AffineCipher.encode "Truth is fiction." 5 17))
  |>.addTest "encode - encode all the letters" (do
      return assertEqual (some "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
          (AffineCipher.encode "The quick brown fox jumps over the lazy dog." 17 33))
  |>.addTest "encode - encode with a not coprime to m" (do
      return assertEqual none (AffineCipher.encode "This is a test." 6 17))
  |>.addTest "decode - decode exercism" (do
      return assertEqual (some "exercism")
          (AffineCipher.decode "tytgn fjr" 3 7))
  |>.addTest "decode - decode a sentence" (do
      return assertEqual (some "anobstacleisoftenasteppingstone")
          (AffineCipher.decode "qdwju nqcro muwhn odqun oppmd aunwd o" 19 16))
  |>.addTest "decode - decode numbers" (do
      return assertEqual (some "testing123testing")
          (AffineCipher.decode "odpoz ub123 odpoz ub" 25 7))
  |>.addTest "decode - decode all the letters" (do
      return assertEqual (some "thequickbrownfoxjumpsoverthelazydog")
          (AffineCipher.decode "swxtj npvyk lruol iejdc blaxk swxmh qzglf" 17 33))
  |>.addTest "decode - decode with no spaces in input" (do
      return assertEqual (some "thequickbrownfoxjumpsoverthelazydog")
          (AffineCipher.decode "swxtjnpvyklruoliejdcblaxkswxmhqzglf" 17 33))
  |>.addTest "decode - decode with too many spaces" (do
      return assertEqual (some "jollygreengiant")
          (AffineCipher.decode "vszzm    cly   yd cg    qdp" 15 16))
  |>.addTest "decode - decode with a not coprime to m" (do
      return assertEqual none (AffineCipher.decode "Test" 13 5))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [affineCipherTests]
