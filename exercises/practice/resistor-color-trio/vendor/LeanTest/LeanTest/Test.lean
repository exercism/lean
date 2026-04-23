/-
Test case and test suite management.
-/

import LeanTest.Assertions

namespace LeanTest

/-- A single test case -/
structure TestCase where
  description : String
  test : IO AssertionResult
  deriving Inhabited

/-- Result of running a test -/
structure TestResult where
  description : String
  result : AssertionResult
  deriving Repr

/-- A collection of tests (test suite) -/
structure TestSuite where
  name : String
  tests : List TestCase
  deriving Inhabited

namespace TestSuite

/-- Create an empty test suite -/
def empty (name : String) : TestSuite :=
  { name := name, tests := [] }

/-- Add a test to the suite -/
def addTest (suite : TestSuite) (description : String) (test : IO AssertionResult) : TestSuite :=
  { suite with tests := suite.tests ++ [{ description := description, test := test }] }

end TestSuite

/-- Test statistics -/
structure TestStats where
  total : Nat
  passed : Nat
  failed : Nat
  deriving Repr

namespace TestStats

def empty : TestStats :=
  { total := 0, passed := 0, failed := 0 }

def addResult (stats : TestStats) (result : AssertionResult) : TestStats :=
  { total := stats.total + 1
  , passed := if result.isSuccess then stats.passed + 1 else stats.passed
  , failed := if result.isSuccess then stats.failed else stats.failed + 1
  }

end TestStats

/-- ANSI color codes for terminal output -/
def greenColor : String := "\x1b[32m"
def redColor : String := "\x1b[31m"
def yellowColor : String := "\x1b[33m"
def resetColor : String := "\x1b[0m"
def boldColor : String := "\x1b[1m"

/-- Run a single test and print the result -/
def runTest (testCase : TestCase) : IO TestResult := do
  let result ← testCase.test
  match result with
  | .success =>
    IO.println s!"  {greenColor}✓{resetColor} {testCase.description}"
  | .failure msg =>
    IO.println s!"  {redColor}✗{resetColor} {testCase.description}"
    IO.println s!"    {redColor}{msg}{resetColor}"
  return { description := testCase.description, result := result }

/-- Run all tests in a test suite -/
def runTestSuite (suite : TestSuite) : IO TestStats := do
  IO.println s!"\n{boldColor}{suite.name}{resetColor}"
  let mut stats := TestStats.empty

  for testCase in suite.tests do
    let result ← runTest testCase
    stats := stats.addResult result.result

  return stats

/-- Print test summary -/
def printSummary (stats : TestStats) : IO Unit := do
  IO.println ""
  IO.println s!"{boldColor}Test Summary:{resetColor}"
  IO.println s!"  Total:  {stats.total}"
  IO.println s!"  {greenColor}Passed: {stats.passed}{resetColor}"

  if stats.failed > 0 then
    IO.println s!"  {redColor}Failed: {stats.failed}{resetColor}"
    IO.println s!"\n{redColor}FAILED{resetColor}"
  else
    IO.println s!"\n{greenColor}ALL TESTS PASSED{resetColor}"

/-- Run multiple test suites -/
def runTestSuites (suites : List TestSuite) : IO Unit := do
  let mut totalStats := TestStats.empty

  for suite in suites do
    let stats ← runTestSuite suite
    totalStats := {
      total := totalStats.total + stats.total,
      passed := totalStats.passed + stats.passed,
      failed := totalStats.failed + stats.failed
    }

  printSummary totalStats

/-- Run multiple test suites and return exit code (0 = all passed, 1 = some failed) -/
def runTestSuitesWithExitCode (suites : List TestSuite) : IO UInt32 := do
  let mut totalStats := TestStats.empty

  for suite in suites do
    let stats ← runTestSuite suite
    totalStats := {
      total := totalStats.total + stats.total,
      passed := totalStats.passed + stats.passed,
      failed := totalStats.failed + stats.failed
    }

  printSummary totalStats
  return if totalStats.failed > 0 then 1 else 0

end LeanTest
