# Instructions append

## Dates and Times

Lean has support for Dates and Times in the [Time][time] module of the standard library.
It must be imported at the beginning of the file:

```lean
import Std.Time
```

Dates and times in Lean are strongly typed, each component (year, month, day, hour, etc.) has its own type and must be explicitly constructed.
There are a number of macros in the `Time` module that can help with this task.

[time]: https://lean-lang.org/doc/api/Std/Time.html
