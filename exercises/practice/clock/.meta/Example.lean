namespace Clock

structure Clock where
  hour   : Fin 24
  minute : Fin 60

instance : BEq Clock where
  beq clock1 clock2 := clock1.hour == clock2.hour && clock1.minute == clock2.minute

def padDigit (n : Nat) : String :=
  if n < 10
  then s!"0{n}"
  else s!"{n}"

instance : ToString Clock where
  toString clock := s!"{padDigit clock.hour.val}:{padDigit clock.minute.val}"

/-
  division and remainder in Lean are in the mathematical sense:
  - the remainder is always positive, even if the number is negative
  - consequently, the division might be negative
-/
def create (hour : Int) (minute : Int) : Clock :=
  let extraHour := minute / 60
  let modMinute := Int.toNat $ minute % 60
  let modHour := Int.toNat $ (hour + extraHour) % 24
  { hour := ⟨modHour, by grind⟩, minute := ⟨modMinute, by grind⟩ }

def add (clock : Clock) (minute : Int) : Clock :=
  let totalMinute := Int.ofNat clock.minute.val + minute
  create (Int.ofNat clock.hour.val) totalMinute

def subtract (clock : Clock) (minute : Int) : Clock :=
  add clock (-minute)

end Clock
