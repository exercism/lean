import LeanTest
import BankAccount
import Std

open LeanTest

def bankAccountTests : TestSuite :=
  (TestSuite.empty "BankAccount")
    |>.addTest "Newly opened account has zero balance" (do
        let account ← BankAccount.Account.create
        try
          account.open
          let balance ← account.balance
          return assertEqual 0 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Single deposit" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 100
          let balance ← account.balance
          return assertEqual 100 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Multiple deposits" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 100
          account.deposit 50
          let balance ← account.balance
          return assertEqual 150 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Withdraw once" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 100
          account.withdraw 75
          let balance ← account.balance
          return assertEqual 25 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Withdraw twice" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 100
          account.withdraw 80
          account.withdraw 20
          let balance ← account.balance
          return assertEqual 0 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Can do multiple operations sequentially" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 100
          account.deposit 110
          account.withdraw 200
          account.deposit 60
          account.withdraw 50
          let balance ← account.balance
          return assertEqual 20 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Cannot check balance of closed account" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.close
          let _ ← account.balance
          return (AssertionResult.failure "Expected error: account not open but operation succeeded.")
        catch msg =>
          return assertEqual "account not open" msg.toString)
    |>.addTest "Cannot deposit into closed account" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.close
          account.deposit 50
          return (AssertionResult.failure "Expected error: account not open but operation succeeded.")
        catch msg =>
          return assertEqual "account not open" msg.toString)
    |>.addTest "Cannot deposit into unopened account" (do
        let account ← BankAccount.Account.create
        try
          account.deposit 50
          return (AssertionResult.failure "Expected error: account not open but operation succeeded.")
        catch msg =>
          return assertEqual "account not open" msg.toString)
    |>.addTest "Cannot withdraw from closed account" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.close
          account.withdraw 50
          return (AssertionResult.failure "Expected error: account not open but operation succeeded.")
        catch msg =>
          return assertEqual "account not open" msg.toString)
    |>.addTest "Cannot close an account that was not opened" (do
        let account ← BankAccount.Account.create
        try
          account.close
          return (AssertionResult.failure "Expected error: account not open but operation succeeded.")
        catch msg =>
          return assertEqual "account not open" msg.toString)
    |>.addTest "Cannot open an already opened account" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.open
          return (AssertionResult.failure "Expected error: account already open but operation succeeded.")
        catch msg =>
          return assertEqual "account already open" msg.toString)
    |>.addTest "Reopened account does not retain balance" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 50
          account.close
          account.open
          let balance ← account.balance
          return assertEqual 0 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))
    |>.addTest "Cannot withdraw more than deposited" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 25
          account.withdraw 50
          return (AssertionResult.failure "Expected error: amount must be less than balance but operation succeeded.")
        catch msg =>
          return assertEqual "amount must be less than balance" msg.toString)
    |>.addTest "Can handle concurrent transactions" (do
        let account ← BankAccount.Account.create
        try
          account.open
          account.deposit 100_000
          let mutex ← Std.BaseMutex.new
          mutex.lock
          let mut tasks := #[]
          for _ in [:100_000] do
            let task ← IO.asTask <| do
              mutex.lock
              mutex.unlock
              account.deposit 1
            tasks := tasks.push task
            let task ← IO.asTask <| do
              mutex.lock
              mutex.unlock
              account.withdraw 1
            tasks := tasks.push task
          IO.sleep 100
          mutex.unlock
          for task in tasks do
            match task.get with
            | .ok ()     => pure ()
            | .error msg => throw msg
          account.withdraw 100_000
          let balance ← account.balance
          return assertEqual 0 balance
        catch msg =>
          return (AssertionResult.failure s!"Expected operation to succeed, but it threw: {msg}."))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [bankAccountTests]
