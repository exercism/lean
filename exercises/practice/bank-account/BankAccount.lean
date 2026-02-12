namespace BankAccount

structure Account where
  -- define a data structure to represent your Account here
  -- it must be able to handle parallel transactions

def Account.create : IO Account :=
  sorry

def Account.open (account : Account) : IO Unit :=
  sorry

def Account.close (account : Account) : IO Unit :=
  sorry

def Account.deposit (amount : Nat) (account : Account) : IO Unit :=
  sorry

def Account.withdraw (amount : Nat) (account : Account) : IO Unit :=
  sorry

def Account.balance (account : Account) : IO Nat :=
  sorry

end BankAccount
