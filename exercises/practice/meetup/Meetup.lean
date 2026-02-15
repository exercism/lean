namespace Meetup

inductive DayOfWeek where
  | Monday : DayOfWeek
  | Tuesday : DayOfWeek
  | Wednesday : DayOfWeek
  | Thursday : DayOfWeek
  | Friday : DayOfWeek
  | Saturday : DayOfWeek
  | Sunday : DayOfWeek
  deriving BEq, Repr

def Month := { m : Nat // m ≥ 1 ∧ m ≤ 12 }

inductive Week where
  | first : Week
  | second : Week
  | third : Week
  | fourth : Week
  | teenth : Week
  | last : Week
  deriving BEq, Repr

def meetup (dayOfWeek : DayOfWeek) (month : Month) (week : Week) (year : Nat) : String :=
  sorry

end Meetup
