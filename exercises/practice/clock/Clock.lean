namespace Clock

structure Clock where
-- define a Clock type here

-- define equality between Clocks
instance : BEq Clock where
  beq clock1 clock2 := sorry

-- define how a Clock should be converted to a String
instance : ToString Clock where
  toString clock := sorry

def create (hour : Int) (minute : Int) : Clock :=
  sorry

def add (clock : Clock) (minute : Int) : Clock :=
  sorry

def subtract (clock : Clock) (minute : Int) : Clock :=
  sorry

end Clock
