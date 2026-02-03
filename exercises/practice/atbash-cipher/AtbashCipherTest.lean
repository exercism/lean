import LeanTest
import AtbashCipher

open LeanTest

def atbashCipherTests : TestSuite :=
  (TestSuite.empty "AtbashCipher")
  |>.addTest "encode -> encode yes" (do
      return assertEqual "bvh" (AtbashCipher.encode "yes"))
  |>.addTest "encode -> encode no" (do
      return assertEqual "ml" (AtbashCipher.encode "no"))
  |>.addTest "encode -> encode OMG" (do
      return assertEqual "lnt" (AtbashCipher.encode "OMG"))
  |>.addTest "encode -> encode spaces" (do
      return assertEqual "lnt" (AtbashCipher.encode "O M G"))
  |>.addTest "encode -> encode mindblowingly" (do
      return assertEqual "nrmwy oldrm tob" (AtbashCipher.encode "mindblowingly"))
  |>.addTest "encode -> encode numbers" (do
      return assertEqual "gvhgr mt123 gvhgr mt" (AtbashCipher.encode "Testing,1 2 3, testing."))
  |>.addTest "encode -> encode deep thought" (do
      return assertEqual "gifgs rhurx grlm" (AtbashCipher.encode "Truth is fiction."))
  |>.addTest "encode -> encode all the letters" (do
      return assertEqual "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt" (AtbashCipher.encode "The quick brown fox jumps over the lazy dog."))
  |>.addTest "decode -> decode exercism" (do
      return assertEqual "exercism" (AtbashCipher.decode "vcvix rhn"))
  |>.addTest "decode -> decode a sentence" (do
      return assertEqual "anobstacleisoftenasteppingstone" (AtbashCipher.decode "zmlyh gzxov rhlug vmzhg vkkrm thglm v"))
  |>.addTest "decode -> decode numbers" (do
      return assertEqual "testing123testing" (AtbashCipher.decode "gvhgr mt123 gvhgr mt"))
  |>.addTest "decode -> decode all the letters" (do
      return assertEqual "thequickbrownfoxjumpsoverthelazydog" (AtbashCipher.decode "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))
  |>.addTest "decode -> decode with too many spaces" (do
      return assertEqual "exercism" (AtbashCipher.decode "vc vix    r hn"))
  |>.addTest "decode -> decode with no spaces" (do
      return assertEqual "anobstacleisoftenasteppingstone" (AtbashCipher.decode "zmlyhgzxovrhlugvmzhgvkkrmthglmv"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [atbashCipherTests]
