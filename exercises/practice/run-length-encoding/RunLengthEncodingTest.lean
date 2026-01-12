import LeanTest
import RunLengthEncoding

open LeanTest

def runLengthEncodingTests : TestSuite :=
  (TestSuite.empty "RunLengthEncoding")
  |>.addTest "run-length encode a string - empty string" (do
      return assertEqual "" (RunLengthEncoding.encode ""))
  |>.addTest "run-length encode a string - single characters only are encoded without count" (do
      return assertEqual "XYZ" (RunLengthEncoding.encode "XYZ"))
  |>.addTest "run-length encode a string - string with no single characters" (do
      return assertEqual "2A3B4C" (RunLengthEncoding.encode "AABBBCCCC"))
  |>.addTest "run-length encode a string - single characters mixed with repeated characters" (do
      return assertEqual "12WB12W3B24WB" (RunLengthEncoding.encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"))
  |>.addTest "run-length encode a string - multiple whitespace mixed in string" (do
      return assertEqual "2 hs2q q2w2 " (RunLengthEncoding.encode "  hsqq qww  "))
  |>.addTest "run-length encode a string - lowercase characters" (do
      return assertEqual "2a3b4c" (RunLengthEncoding.encode "aabbbcccc"))
  |>.addTest "run-length decode a string - empty string" (do
      return assertEqual "" (RunLengthEncoding.decode ""))
  |>.addTest "run-length decode a string - single characters only" (do
      return assertEqual "XYZ" (RunLengthEncoding.decode "XYZ"))
  |>.addTest "run-length decode a string - string with no single characters" (do
      return assertEqual "AABBBCCCC" (RunLengthEncoding.decode "2A3B4C"))
  |>.addTest "run-length decode a string - single characters with repeated characters" (do
      return assertEqual "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" (RunLengthEncoding.decode "12WB12W3B24WB"))
  |>.addTest "run-length decode a string - multiple whitespace mixed in string" (do
      return assertEqual "  hsqq qww  " (RunLengthEncoding.decode "2 hs2q q2w2 "))
  |>.addTest "run-length decode a string - lowercase string" (do
      return assertEqual "aabbbcccc" (RunLengthEncoding.decode "2a3b4c"))
  |>.addTest "encode and then decode - encode followed by decode gives original string" (do
      return assertEqual "zzz ZZ  zZ" (RunLengthEncoding.decode (RunLengthEncoding.encode "zzz ZZ  zZ")))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [runLengthEncodingTests]
