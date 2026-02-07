# Instructions append

## Subtypes

This exercise defines a Subtype called `Book`, for natural numbers 1 through 5.
A Subtype can be thought of as a pair `⟨x, h⟩`, where x is the value and h is the proof of its validity.

The value inside a Subtype (x, in this case) can be accessed by using .val, for example, `x.val`.
Its proof can be accessed by using .property, for example, `x.property`.
Both can also be accessed by pattern matching, as usual.
