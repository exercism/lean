import LeanTest
import HelloWorld

open LeanTest

def helloWorldTests : TestSuite :=
  (TestSuite.empty "HelloWorld")
  |>.addTest "Say Hi!" (do
      return assertEqual "Hello, World!" HelloWorld.hello)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [helloWorldTests]
