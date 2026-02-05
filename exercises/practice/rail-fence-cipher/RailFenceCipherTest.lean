import LeanTest
import RailFenceCipher

open LeanTest

def railFenceCipherTests : TestSuite :=
  (TestSuite.empty "RailFenceCipher")
  |>.addTest "encode -> encode with two rails" (do
      return assertEqual "XXXXXXXXXOOOOOOOOO" (RailFenceCipher.encode ⟨2, by decide⟩ "XOXOXOXOXOXOXOXOXO"))
  |>.addTest "encode -> encode with three rails" (do
      return assertEqual "WECRLTEERDSOEEFEAOCAIVDEN" (RailFenceCipher.encode ⟨3, by decide⟩ "WEAREDISCOVEREDFLEEATONCE"))
  |>.addTest "encode -> encode with ending in the middle" (do
      return assertEqual "ESXIEECSR" (RailFenceCipher.encode ⟨4, by decide⟩ "EXERCISES"))
  |>.addTest "decode -> decode with three rails" (do
      return assertEqual "THEDEVILISINTHEDETAILS" (RailFenceCipher.decode ⟨3, by decide⟩ "TEITELHDVLSNHDTISEIIEA"))
  |>.addTest "decode -> decode with five rails" (do
      return assertEqual "EXERCISMISAWESOME" (RailFenceCipher.decode ⟨5, by decide⟩ "EIEXMSMESAORIWSCE"))
  |>.addTest "decode -> decode with six rails" (do
      return assertEqual "112358132134558914423337761098715972584418167651094617711286" (RailFenceCipher.decode ⟨6, by decide⟩ "133714114238148966225439541018335470986172518171757571896261"))
  |>.addTest "encode with one rail" (do
      return assertEqual "ABC" (RailFenceCipher.encode ⟨1, by decide⟩ "ABC"))
  |>.addTest "decode with one rail" (do
      return assertEqual "ABC" (RailFenceCipher.decode ⟨1, by decide⟩ "ABC"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [railFenceCipherTests]
