namespace BankAccount

structure Account where
  -- define a data structure to represent your Account here
  -- it must be able to handle parallel transactions

def Account.create : IO Account :=
  sorry --remove this line and implement the function

def Account.open (account : Account) : IO Unit :=
  sorry --remove this line and implement the function

def Account.close (account : Account) : IO Unit :=
  sorry --remove this line and implement the function

def Account.deposit (amount : Nat) (account : Account) : IO Unit :=
  sorry --remove this line and implement the function

def Account.withdraw (amount : Nat) (account : Account) : IO Unit :=
  sorry --remove this line and implement the function

def Account.balance (account : Account) : IO Nat :=
  sorry --remove this line and implement the function

end BankAccount
