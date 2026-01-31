import LeanTest
import SecretHandshake

open LeanTest

def secretHandshakeTests : TestSuite :=
  (TestSuite.empty "SecretHandshake")
  |>.addTest "wink for 1" (do
      return assertEqual #[.wink] (SecretHandshake.commands 1))
  |>.addTest "double blink for 10" (do
      return assertEqual #[.doubleBlink] (SecretHandshake.commands 2))
  |>.addTest "close your eyes for 100" (do
      return assertEqual #[.closeYourEyes] (SecretHandshake.commands 4))
  |>.addTest "jump for 1000" (do
      return assertEqual #[.jump] (SecretHandshake.commands 8))
  |>.addTest "combine two actions" (do
      return assertEqual #[.wink, .doubleBlink] (SecretHandshake.commands 3))
  |>.addTest "reverse two actions" (do
      return assertEqual #[.doubleBlink, .wink] (SecretHandshake.commands 19))
  |>.addTest "reversing one action gives the same action" (do
      return assertEqual #[.jump] (SecretHandshake.commands 24))
  |>.addTest "reversing no actions still gives no actions" (do
      return assertEqual #[] (SecretHandshake.commands 16))
  |>.addTest "all possible actions" (do
      return assertEqual #[.wink, .doubleBlink, .closeYourEyes, .jump] (SecretHandshake.commands 15))
  |>.addTest "reverse all possible actions" (do
      return assertEqual #[.jump, .closeYourEyes, .doubleBlink, .wink] (SecretHandshake.commands 31))
  |>.addTest "do nothing for zero" (do
      return assertEqual #[] (SecretHandshake.commands 0))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [secretHandshakeTests]
