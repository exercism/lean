import LeanTest
import CryptoSquare

open LeanTest

def cryptoSquareTests : TestSuite :=
  (TestSuite.empty "CryptoSquare")
  |>.addTest "empty plaintext results in an empty ciphertext" (do
      return assertEqual "" (CryptoSquare.ciphertext ""))
  |>.addTest "normalization results in empty plaintext" (do
      return assertEqual "" (CryptoSquare.ciphertext "... --- ..."))
  |>.addTest "Lowercase" (do
      return assertEqual "a" (CryptoSquare.ciphertext "A"))
  |>.addTest "Remove spaces" (do
      return assertEqual "b" (CryptoSquare.ciphertext "  b "))
  |>.addTest "Remove punctuation" (do
      return assertEqual "1" (CryptoSquare.ciphertext "@1,%!"))
  |>.addTest "9 character plaintext results in 3 chunks of 3 characters" (do
      return assertEqual "tsf hiu isn" (CryptoSquare.ciphertext "This is fun!"))
  |>.addTest "8 character plaintext results in 3 chunks, the last one with a trailing space" (do
      return assertEqual "clu hlt io " (CryptoSquare.ciphertext "Chill out."))
  |>.addTest "54 character plaintext results in 8 chunks, the last two with trailing spaces" (do
      return assertEqual "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau " (CryptoSquare.ciphertext "If man was meant to stay on the ground, god would have given us roots."))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [cryptoSquareTests]
