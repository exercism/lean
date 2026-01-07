import LeanTest
import RotationalCipher

open LeanTest

def rotationalCipherTests : TestSuite :=
  (TestSuite.empty "RotationalCipher")
  |>.addTest "rotate a by 0, same output as input" (do
      return assertEqual "a" (RotationalCipher.rotate 0 "a"))
  |>.addTest "rotate a by 1" (do
      return assertEqual "b" (RotationalCipher.rotate 1 "a"))
  |>.addTest "rotate a by 26, same output as input" (do
      return assertEqual "a" (RotationalCipher.rotate 26 "a"))
  |>.addTest "rotate m by 13" (do
      return assertEqual "z" (RotationalCipher.rotate 13 "m"))
  |>.addTest "rotate n by 13 with wrap around alphabet" (do
      return assertEqual "a" (RotationalCipher.rotate 13 "n"))
  |>.addTest "rotate capital letters" (do
      return assertEqual "TRL" (RotationalCipher.rotate 5 "OMG"))
  |>.addTest "rotate spaces" (do
      return assertEqual "T R L" (RotationalCipher.rotate 5 "O M G"))
  |>.addTest "rotate numbers" (do
      return assertEqual "Xiwxmrk 1 2 3 xiwxmrk" (RotationalCipher.rotate 4 "Testing 1 2 3 testing"))
  |>.addTest "rotate punctuation" (do
      return assertEqual "Gzo'n zvo, Bmviyhv!" (RotationalCipher.rotate 21 "Let's eat, Grandma!"))
  |>.addTest "rotate all letters" (do
      return assertEqual "Gur dhvpx oebja sbk whzcf bire gur ynml qbt." (RotationalCipher.rotate 13 "The quick brown fox jumps over the lazy dog."))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [rotationalCipherTests]
