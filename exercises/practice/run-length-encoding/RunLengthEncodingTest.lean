import LeanTest
import RunLengthEncoding

open LeanTest

def runLengthEncodingTests : TestSuite :=
  (TestSuite.empty "RunLengthEncoding")
  |>.addTest "run-length encode a string -> empty string" (do
      return assertEqual "" ("" |> RunLengthEncoding.encode))
  |>.addTest "run-length encode a string -> single characters only are encoded without count" (do
      return assertEqual "XYZ" ("XYZ" |> RunLengthEncoding.encode))
  |>.addTest "run-length encode a string -> string with no single characters" (do
      return assertEqual "2A3B4C" ("AABBBCCCC" |> RunLengthEncoding.encode))
  |>.addTest "run-length encode a string -> single characters mixed with repeated characters" (do
      return assertEqual "12WB12W3B24WB" ("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" |> RunLengthEncoding.encode))
  |>.addTest "run-length encode a string -> multiple whitespace mixed in string" (do
      return assertEqual "2 hs2q q2w2 " ("  hsqq qww  " |> RunLengthEncoding.encode))
  |>.addTest "run-length encode a string -> lowercase characters" (do
      return assertEqual "2a3b4c" ("aabbbcccc" |> RunLengthEncoding.encode))
  |>.addTest "run-length decode a string -> empty string" (do
      return assertEqual "" ("" |> RunLengthEncoding.decode))
  |>.addTest "run-length decode a string -> single characters only" (do
      return assertEqual "XYZ" ("XYZ" |> RunLengthEncoding.decode))
  |>.addTest "run-length decode a string -> string with no single characters" (do
      return assertEqual "AABBBCCCC" ("2A3B4C" |> RunLengthEncoding.decode))
  |>.addTest "run-length decode a string -> single characters with repeated characters" (do
      return assertEqual "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB" ("12WB12W3B24WB" |> RunLengthEncoding.decode))
  |>.addTest "run-length decode a string -> multiple whitespace mixed in string" (do
      return assertEqual "  hsqq qww  " ("2 hs2q q2w2 " |> RunLengthEncoding.decode))
  |>.addTest "run-length decode a string -> lowercase string" (do
      return assertEqual "aabbbcccc" ("2a3b4c" |> RunLengthEncoding.decode))
  |>.addTest "encode and then decode -> encode followed by decode gives original string" (do
      return assertEqual "zzz ZZ  zZ" ("zzz ZZ  zZ" |> RunLengthEncoding.encode |> RunLengthEncoding.decode))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [runLengthEncodingTests]
