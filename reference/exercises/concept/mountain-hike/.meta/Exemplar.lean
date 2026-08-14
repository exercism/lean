namespace MountainHike

def totalMinutes (hours minutes : Nat) : Nat :=
  hours * 60 + minutes

def fullHours (totalMinutes : Nat) : Nat :=
  totalMinutes / 60

def remainingMinutes (totalMinutes : Nat) : Nat :=
  totalMinutes % 60

def waterLeft (capacity used : Nat) : Nat :=
  capacity - used

def elevationChange (beginAlt endAlt : Int) : Int :=
  endAlt - beginAlt

end MountainHike
