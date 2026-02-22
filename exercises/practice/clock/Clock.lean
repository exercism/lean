namespace Clock

structure Clock where
-- define a Clock type here

-- define equality between Clocks
instance : BEq Clock where
  beq clock1 clock2 :=
    sorry --remove this line and implement the function

-- define how a Clock should be converted to a String
instance : ToString Clock where
  toString clock :=
    sorry --remove this line and implement the function

def create (hour : Int) (minute : Int) : Clock :=
  sorry --remove this line and implement the function

def add (clock : Clock) (minute : Int) : Clock :=
  sorry --remove this line and implement the function

def subtract (clock : Clock) (minute : Int) : Clock :=
  sorry --remove this line and implement the function

end Clock
