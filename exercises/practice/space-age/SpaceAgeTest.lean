import LeanTest
import SpaceAge

open LeanTest

def spaceAgeTests : TestSuite :=
  (TestSuite.empty "SpaceAge")
  |>.addTest "age on Earth" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Earth 1000000000) 31.680000 31.700000)
  |>.addTest "age on Mercury" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Mercury 2134835688) 280.870000 280.890000)
  |>.addTest "age on Venus" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Venus 189839836) 9.770000 9.790000)
  |>.addTest "age on Mars" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Mars 2129871239) 35.870000 35.890000)
  |>.addTest "age on Jupiter" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Jupiter 901876382) 2.400000 2.420000)
  |>.addTest "age on Saturn" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Saturn 2000000000) 2.140000 2.160000)
  |>.addTest "age on Uranus" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Uranus 1210123456) 0.450000 0.470000)
  |>.addTest "age on Neptune" (do
      return assertInRange (SpaceAge.age SpaceAge.Planet.Neptune 1821023456) 0.340000 0.360000)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [spaceAgeTests]
