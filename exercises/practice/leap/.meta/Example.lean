namespace Leap

def leapYear (year : UInt16) : Bool :=
  year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

end Leap
