import LeanTest
import Raindrops

open LeanTest

def raindropsTests : TestSuite :=
  (TestSuite.empty "Raindrops")
  |>.addTest "the sound for 1 is 1" (do
      return assertEqual "1" (Raindrops.convert 1))
  |>.addTest "the sound for 3 is Pling" (do
      return assertEqual "Pling" (Raindrops.convert 3))
  |>.addTest "the sound for 5 is Plang" (do
      return assertEqual "Plang" (Raindrops.convert 5))
  |>.addTest "the sound for 7 is Plong" (do
      return assertEqual "Plong" (Raindrops.convert 7))
  |>.addTest "the sound for 6 is Pling as it has a factor 3" (do
      return assertEqual "Pling" (Raindrops.convert 6))
  |>.addTest "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base" (do
      return assertEqual "8" (Raindrops.convert 8))
  |>.addTest "the sound for 9 is Pling as it has a factor 3" (do
      return assertEqual "Pling" (Raindrops.convert 9))
  |>.addTest "the sound for 10 is Plang as it has a factor 5" (do
      return assertEqual "Plang" (Raindrops.convert 10))
  |>.addTest "the sound for 14 is Plong as it has a factor of 7" (do
      return assertEqual "Plong" (Raindrops.convert 14))
  |>.addTest "the sound for 15 is PlingPlang as it has factors 3 and 5" (do
      return assertEqual "PlingPlang" (Raindrops.convert 15))
  |>.addTest "the sound for 21 is PlingPlong as it has factors 3 and 7" (do
      return assertEqual "PlingPlong" (Raindrops.convert 21))
  |>.addTest "the sound for 25 is Plang as it has a factor 5" (do
      return assertEqual "Plang" (Raindrops.convert 25))
  |>.addTest "the sound for 27 is Pling as it has a factor 3" (do
      return assertEqual "Pling" (Raindrops.convert 27))
  |>.addTest "the sound for 35 is PlangPlong as it has factors 5 and 7" (do
      return assertEqual "PlangPlong" (Raindrops.convert 35))
  |>.addTest "the sound for 49 is Plong as it has a factor 7" (do
      return assertEqual "Plong" (Raindrops.convert 49))
  |>.addTest "the sound for 52 is 52" (do
      return assertEqual "52" (Raindrops.convert 52))
  |>.addTest "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7" (do
      return assertEqual "PlingPlangPlong" (Raindrops.convert 105))
  |>.addTest "the sound for 3125 is Plang as it has a factor 5" (do
      return assertEqual "Plang" (Raindrops.convert 3125))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [raindropsTests]
