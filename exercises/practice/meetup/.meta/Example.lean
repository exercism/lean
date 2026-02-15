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

def leapYear (year : Nat) : Bool :=
  (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0))

def daysInMonth (month : Month) (year : Nat) : Nat :=
  match month with
  | ⟨1, _⟩ => 31
  | ⟨2, _⟩ => if leapYear year then 29 else 28
  | ⟨3, _⟩ => 31
  | ⟨4, _⟩ => 30
  | ⟨5, _⟩ => 31
  | ⟨6, _⟩ => 30
  | ⟨7, _⟩ => 31
  | ⟨8, _⟩ => 31
  | ⟨9, _⟩ => 30
  | ⟨10, _⟩ => 31
  | ⟨11, _⟩ => 30
  | ⟨12, _⟩ => 31

def monthOffset (month : Month) : Nat :=
  match month with
  | ⟨1, _⟩ => 307  -- offset from the end of February
  | ⟨2, _⟩ => 338
  | ⟨3, _⟩ => 1
  | ⟨4, _⟩ => 32
  | ⟨5, _⟩ => 62
  | ⟨6, _⟩ => 93
  | ⟨7, _⟩ => 123
  | ⟨8, _⟩ => 154
  | ⟨9, _⟩ => 185
  | ⟨10, _⟩ => 215
  | ⟨11, _⟩ => 246
  | ⟨12, _⟩ => 276

def weekConcludes (month : Month) (week : Week) (year : Nat) : Nat :=
  match week with
  | .first => 7
  | .second => 14
  | .third => 21
  | .fourth => 28
  | .teenth => 19
  | .last => daysInMonth month year

def dayOfWeekIndex (dayOfWeek : DayOfWeek) : Nat :=
  match dayOfWeek with
  | .Monday => 1
  | .Tuesday => 2
  | .Wednesday => 3
  | .Thursday => 4
  | .Friday => 5
  | .Saturday => 6
  | .Sunday => 7

def dayOfWeekIndexCalculated (dayInMonth : Nat) (month : Month) (year : Nat) : Nat :=
  let year1 := if month.val < 3 then year - 1 else year
  ((year1 + (year1 / 400) + (year1 / 4) - (year1 / 100)) + (monthOffset month) + dayInMonth) % 7 + 1

def meetupDay (dayOfWeek : DayOfWeek) (month : Month) (week : Week) (year : Nat) : Nat :=
  let dayWeekConcludes := weekConcludes month week year
  let concludingDayIndex := dayOfWeekIndexCalculated dayWeekConcludes month year
  let requiredDayIndex := dayOfWeekIndex dayOfWeek
  let adjustment := if concludingDayIndex < requiredDayIndex then 7 else 0
  (dayWeekConcludes + requiredDayIndex) - (concludingDayIndex + adjustment)

def twoDigit (n : Nat) : String :=
  if n >= 10 then s!"{n}" else s!"0{n}"

def meetup (dayOfWeek : DayOfWeek) (month : Month) (week : Week) (year : Nat) : String :=
  let day := meetupDay dayOfWeek month week year
  s!"{year}-{twoDigit month.val}-{twoDigit day}"

end Meetup
