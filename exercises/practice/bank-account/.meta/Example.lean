import Std

namespace BankAccount

/-
  The main primitive for synchronization between threads is Std.BaseMutex.
  It is basically C++'s std::mutex.

  There is a higher-level version called Std.Mutex, which is a wrapper around a IO.Ref with a lock.

  In many situations, a IO.Ref may also be used without a mutex.
  The API for IO.Ref guarantees that some operations are atomic, using CAS over the pointer to the value.
  Examples of atomic ops include swap, modify and modifyGet, but _not_ get and set.

  The implementation below uses IO.Ref and atomic operations.
-/

-- private means that it is accessible only in the current module/file
-- it is how encapsulation is represented in Lean
private structure State where
  _open    : Bool
  _balance : Nat

structure Account where
  private state : IO.Ref State

def Account.create : IO Account :=
  return {
    state := ← IO.mkRef {
      _open    := false,
      _balance := 0
    }
  }

def Account.open (account : Account) : IO Unit := do
  match ← account.state.modifyGet λ s => (s, { s with _open := true }) with
  | ⟨true, _⟩ => throw <| IO.userError "account already open"
  | _         => pure ()

def Account.close (account : Account) : IO Unit := do
  match ← account.state.modifyGet λ s => (s, { s with _open := false, _balance := 0 }) with
  | ⟨false, _⟩ => throw <| IO.userError "account not open"
  | _          => pure ()

def Account.deposit (amount : Nat) (account : Account) : IO Unit := do
  match ← account.state.modifyGet λ s => (s, { s with _balance := s._balance + amount }) with
  | ⟨false, _⟩ => throw <| IO.userError "account not open"
  | _          => pure ()

def Account.withdraw (amount : Nat) (account : Account) : IO Unit := do
  match ← account.state.modifyGet λ s => (s, { s with  _balance := s._balance - amount }) with
  | ⟨false, _⟩ => throw <| IO.userError "account not open"
  | ⟨_, balance⟩ =>
    if balance < amount then
      throw <| IO.userError "amount must be less than balance"

def Account.balance (account : Account) : IO Nat := do
  match ← account.state.modifyGet λ s => (s, s) with
  | ⟨false, _⟩   => throw <| IO.userError "account not open"
  | ⟨_, balance⟩ => pure balance

end BankAccount
