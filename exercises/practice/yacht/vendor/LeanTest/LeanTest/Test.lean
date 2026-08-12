/-
Test case and test suite management.
-/

import LeanTest.Assertions
import LeanTest.Json
import LeanTest.SourceParser

namespace LeanTest

/-- A single test case -/
structure TestCase where
  description : String
  test : IO AssertionResult
  taskId : Option Nat := none -- set for concept exercises
  deriving Inhabited

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
def addTest (suite : TestSuite) (description : String) (test : IO AssertionResult)
    (taskId : Option Nat := none) : TestSuite :=
  { suite with tests := suite.tests ++ [{ description := description, test := test, taskId := taskId }] }

end TestSuite

/-- Per-test outcome, matching the v3 interface's `pass` / `fail` / `error`. -/
inductive TestStatus where
  | pass
  | fail
  | error
  deriving Repr, BEq

def TestStatus.toReportString : TestStatus → String
  | .pass => "pass"
  | .fail => "fail"
  | .error => "error"

/-- Result of running a test -/
structure TestResult where
  description : String
  status : TestStatus
  message : Option String -- `none` when `status = .pass`
  taskId : Option Nat
  deriving Repr

/-- Test statistics -/
structure TestStats where
  total : Nat := 0
  passed : Nat := 0
  failed : Nat := 0
  errored : Nat := 0

namespace TestStats

def empty : TestStats := {}

def addResult (stats : TestStats) (status : TestStatus) : TestStats :=
  { stats with
    total := stats.total + 1
    passed := stats.passed + (if status == .pass then 1 else 0)
    failed := stats.failed + (if status == .fail then 1 else 0)
    errored := stats.errored + (if status == .error then 1 else 0) }

end TestStats

/-- ANSI color codes for terminal output -/
def greenColor : String := "\x1b[32m"
def redColor : String := "\x1b[31m"
def yellowColor : String := "\x1b[33m"
def resetColor : String := "\x1b[0m"
def boldColor : String := "\x1b[1m"

/-- Run a single test, printing a colored result line, and returning a structured `TestResult`.
    Exceptions are caught and returned as a per-test `error`. -/
def runTest (testCase : TestCase) : IO TestResult := do
  try
    let result ← testCase.test
    match result with
    | .success =>
      IO.println s!"  {greenColor}✓{resetColor} {testCase.description}"
      return { description := testCase.description, status := .pass, message := none, taskId := testCase.taskId }
    | .failure msg =>
      IO.println s!"  {redColor}✗{resetColor} {testCase.description}"
      IO.println s!"    {redColor}{msg}{resetColor}"
      return { description := testCase.description, status := .fail, message := some msg, taskId := testCase.taskId }
  catch e =>
    let msg := toString e
    IO.println s!"  {redColor}✗{resetColor} {testCase.description}"
    IO.println s!"    {redColor}{msg}{resetColor}"
    return { description := testCase.description, status := .error, message := some msg, taskId := testCase.taskId }

/-- Run all tests in a test suite -/
def runTestSuite (suite : TestSuite) : IO (List TestResult) := do
  IO.println s!"\n{boldColor}{suite.name}{resetColor}"
  let mut results : List TestResult := []
  for testCase in suite.tests do
    let result ← runTest testCase
    results := results ++ [result]
  return results

/-- Print test summary -/
def printSummary (stats : TestStats) : IO Unit := do
  IO.println ""
  IO.println s!"{boldColor}Test Summary:{resetColor}"
  IO.println s!"  Total:  {stats.total}"
  IO.println s!"  {greenColor}Passed: {stats.passed}{resetColor}"

  if stats.failed > 0 then
    IO.println s!"  {redColor}Failed: {stats.failed}{resetColor}"
  if stats.errored > 0 then
    IO.println s!"  {redColor}Errored: {stats.errored}{resetColor}"

  if stats.failed > 0 || stats.errored > 0 then
    IO.println s!"\n{redColor}FAILED{resetColor}"
  else
    IO.println s!"\n{greenColor}ALL TESTS PASSED{resetColor}"

/-- Build the v3 `results.json` payload for a full run's `TestResult`s.
    `testCode` maps each test's description to its captured source.
    `results` may be empty if an exercise is compile-time only (theorem proving, etc.). -/
def buildResultsJson (results : List TestResult) (testCode : List (String × String)) : String :=
  open Json in
  let overall : TestStatus :=
    if results.all (fun t => t.status == .pass) then .pass
    else if !results.isEmpty && results.all (fun t => t.status == .error) then .error
    else .fail
  let testJson (t : TestResult) : String :=
    let code := SourceParser.lookup t.description testCode
    let fields :=
      [ s!"\"name\": {str t.description}"
      , s!"\"status\": {str t.status.toReportString}"
      , s!"\"message\": {strOrNull t.message}"
      , s!"\"test_code\": {str code}"
      ] ++ (match t.taskId with
            | none => []
            | some n => [s!"\"task_id\": {n}"])
    object fields
  let topMessage : Option String :=
    match overall with
    | .error =>
      let firstMsg := results.head?.bind (·.message)
      some (truncate (firstMsg.getD "All tests failed with an error.") 65535)
    | _ => none
  object [
    s!"\"version\": 3",
    s!"\"status\": {str overall.toReportString}",
    s!"\"message\": {strOrNull topMessage}",
    s!"\"tests\": {array (results.map testJson)}"
  ]

/-- If the runner set `EXERCISM_OUTPUT_DIR`, write `results.json` there.
    Reads `EXERCISM_TEST_FILE` (if set) to source `test_code` from the test file.
    Silently does nothing when `EXERCISM_OUTPUT_DIR` is unset. -/
def writeResultsIfRequested (results : List TestResult) : IO Unit := do
  match (← IO.getEnv "EXERCISM_OUTPUT_DIR") with
  | none => pure ()
  | some outputDir =>
    let testCode ←
      match (← IO.getEnv "EXERCISM_TEST_FILE") with
      | none => pure []
      | some path =>
        try
          let source ← IO.FS.readFile path
          pure (SourceParser.extractTestBodies source)
        catch _ => pure []
    IO.FS.createDirAll outputDir
    IO.FS.writeFile s!"{outputDir}/results.json" (buildResultsJson results testCode)

/-- Run multiple test suites, print a summary.
    If the proper env vars are set, write `results.json`. -/
def runTestSuites (suites : List TestSuite) : IO (List TestResult) := do
  let mut allResults : List TestResult := []
  for suite in suites do
    let results ← runTestSuite suite
    allResults := allResults ++ results

  let stats := allResults.foldl (fun s r => s.addResult r.status) TestStats.empty
  printSummary stats
  writeResultsIfRequested allResults
  return allResults

/-- Run multiple test suites and return exit code (0 = all passed, 1 = some failed/errored) -/
def runTestSuitesWithExitCode (suites : List TestSuite) : IO UInt32 := do
  let results ← runTestSuites suites
  return if results.any (fun r => r.status != .pass) then 1 else 0

end LeanTest
