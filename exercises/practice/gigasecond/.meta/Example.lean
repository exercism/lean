import Std.Time

namespace Gigasecond

def add (moment : Std.Time.PlainDateTime) : Std.Time.PlainDateTime :=
  moment.addSeconds 1_000_000_000

end Gigasecond
