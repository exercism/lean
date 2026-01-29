# Instructions append

## Dates and Times

Lean has support for Dates and Times in the [Time][time] module of the standard library.
It must be imported at the beginning of the file:

```lean
import Std.Time
```

Dates and times in Lean are strongly typed, each component (year, month, day, hour, etc.) has its own type and must be explicitly constructed.
In order to make this task easier, a number of macros are already defined in the `Time` module.

The test file makes use of the `datetime` macro, which must be called with a string literal of the format `"uuuu-MM-ddTHH:mm:ss.sssssssss"` inside parentheses:

```lean
datetime("uuuu-MM-ddTHH:mm:ss.sssssssss")
```

Note that the nanosecond part (`.sssssssss`) is optional, but the rest is not.

A new macro, `adjusteddatetime`, is defined that accepts either a date-only literal `"YYYY-MM-DD"` or a full datetime literal `"YYYY-MM-DDTHH:mm:ss"`. 
For a date-only literal, `"T00:00:00"` is appended, and in both cases the macro calls `datetime`.

[time]: https://lean-lang.org/doc/api/Std/Time.html
