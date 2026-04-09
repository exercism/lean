/-
Assertion functions for unit testing.
-/

namespace LeanTest

/-- Result of a test assertion -/
inductive AssertionResult where
  | success : AssertionResult
  | failure (message : String) : AssertionResult
  deriving Repr, BEq

namespace AssertionResult

def isSuccess : AssertionResult → Bool
  | success => true
  | failure _ => false

def getMessage : AssertionResult → String
  | success => "Assertion passed"
  | failure msg => msg

end AssertionResult

/-- Assert that a boolean condition is true -/
def assert (condition : Bool) (message : String := "Assertion failed") : AssertionResult :=
  if condition then
    .success
  else
    .failure message

/-- Assert that two values are equal -/
def assertEqual [BEq α] [Repr α] (expected : α) (actual : α) (message : String := "") : AssertionResult :=
  if expected == actual then
    .success
  else
    let msg := if message.isEmpty then
      s!"Expected: {repr expected}\nActual: {repr actual}"
    else
      s!"{message}\nExpected: {repr expected}\nActual: {repr actual}"
    .failure msg

/-- Assert that two values are not equal -/
def assertNotEqual [BEq α] [Repr α] (expected : α) (actual : α) (message : String := "") : AssertionResult :=
  if expected != actual then
    .success
  else
    let msg := if message.isEmpty then
      s!"Expected values to be different, but both were: {repr expected}"
    else
      s!"{message}\nExpected values to be different, but both were: {repr expected}"
    .failure msg

/-- Refute that a boolean condition is true (assert it's false) -/
def refute (condition : Bool) (message : String := "Refute failed - condition was true") : AssertionResult :=
  if !condition then
    .success
  else
    .failure message

/-- Assert that a value is true -/
def assertTrue (value : Bool) (message : String := "Expected true but got false") : AssertionResult :=
  assert value message

/-- Assert that a value is false -/
def assertFalse (value : Bool) (message : String := "Expected false but got true") : AssertionResult :=
  refute value message

/-- Assert that an Option is some -/
def assertSome [Repr α] (opt : Option α) (message : String := "Expected Some but got None") : AssertionResult :=
  match opt with
  | some _ => .success
  | none => .failure message

/-- Assert that an Option is none -/
def assertNone [Repr α] (opt : Option α) (message : String := "") : AssertionResult :=
  match opt with
  | none => .success
  | some val =>
    let msg := if message.isEmpty then
      s!"Expected None but got Some: {repr val}"
    else
      s!"{message}\nExpected None but got Some: {repr val}"
    .failure msg

/-- Assert that a list is empty -/
def assertEmpty [Repr α] (list : List α) (message : String := "") : AssertionResult :=
  match list with
  | [] => .success
  | _ =>
    let msg := if message.isEmpty then
      s!"Expected empty list but got: {repr list}"
    else
      s!"{message}\nExpected empty list but got: {repr list}"
    .failure msg

/-- Assert that a list contains an element -/
def assertContains [BEq α] [Repr α] (list : List α) (element : α) (message : String := "") : AssertionResult :=
  if list.contains element then
    .success
  else
    let msg := if message.isEmpty then
      s!"Expected list to contain {repr element}\nList: {repr list}"
    else
      s!"{message}\nExpected list to contain {repr element}\nList: {repr list}"
    .failure msg

/-- Assert that a value is within a range (inclusive) -/
def assertInRange [LE α] [DecidableRel (· ≤ · : α → α → Prop)] [Repr α]
    (value : α) (min : α) (max : α) (message : String := "") : AssertionResult :=
  if min ≤ value ∧ value ≤ max then
    .success
  else
    let msg := if message.isEmpty then
      s!"Expected {repr value} to be in range [{repr min}, {repr max}]"
    else
      s!"{message}\nExpected {repr value} to be in range [{repr min}, {repr max}]"
    .failure msg

/-- Assert that an Except value is an error -/
def assertError [Repr ε] [Repr α] (result : Except ε α) (message : String := "") : AssertionResult :=
  match result with
  | .error _ => .success
  | .ok val =>
    let msg := if message.isEmpty then
      s!"Expected error but got Ok: {repr val}"
    else
      s!"{message}\nExpected error but got Ok: {repr val}"
    .failure msg

/-- Assert that an Except value is ok -/
def assertOk [Repr ε] [Repr α] (result : Except ε α) (message : String := "") : AssertionResult :=
  match result with
  | .ok _ => .success
  | .error err =>
    let msg := if message.isEmpty then
      s!"Expected Ok but got error: {repr err}"
    else
      s!"{message}\nExpected Ok but got error: {repr err}"
    .failure msg

/-- Assert that an IO action throws an error -/
def assertThrows (action : IO α) (message : String := "") : IO AssertionResult := do
  try
    let _ ← action
    let msg := if message.isEmpty then
      "Expected IO action to throw an error, but it succeeded"
    else
      s!"{message}\nExpected IO action to throw an error, but it succeeded"
    return .failure msg
  catch _ =>
    return .success

/-- Assert that an IO action succeeds (doesn't throw) -/
def assertSucceeds (action : IO α) (message : String := "") : IO AssertionResult := do
  try
    let _ ← action
    return .success
  catch e =>
    let msg := if message.isEmpty then
      s!"Expected IO action to succeed, but it threw: {e}"
    else
      s!"{message}\nExpected IO action to succeed, but it threw: {e}"
    return .failure msg

end LeanTest
