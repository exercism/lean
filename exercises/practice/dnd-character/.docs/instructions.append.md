# Instructions append

## Generating pseudorandom values in Lean

In functional languages, most functions are _pure_.
This means that they always return the same output for the same set of arguments, and they do nothing else.
In other words, pure functions are deterministic.

However, by definition, a random value is unpredictable and non-deterministic.
Even [pseudorandomness][pseudorandomness], that is, returning a sequence of numbers that _look_ random, is not so easy to achieve in a pure context.
This is because a [pseudorandom number generator (PRNG)][PRNG] needs to keep track of internal state in order to return the next number in the sequence.

Lean offers two possible approaches to this problem:

1. Use a monad that makes it possible to change the internal state of a PRNG.
There is a readily available function, `IO.rand`, that does exactly this.

2. Use pure functions that take a generator as an argument and return not only the pseudorandom value produced, but also an updated generator "primed" for the next number in the sequence.

This exercise uses the second approach.
A generator is passed to every function that should produce a pseudorandom value, and the function is expected to return both the value and an updated generator.

Note that a given generator is deterministic, i.e, it _always_ produces the same value.
In order to generate the next pseudorandom value in a sequence, it is necessary to use the updated generator.

## Checking randomness

In this exercise, randomness is checked by a [chi-squared test][chi-squared-test] at a [significance level][p-value] of `p < 0.0001`.

This means that if an ability score is generated according to the instructions, there's less than a 0.01% chance that a correct implementation would fail the test by random chance.

Note that, according to the instructions, an ability score is _the sum of the three largest results out of four rolls of an unbiased d6 (six-sided die)_.

[pseudorandomness]: https://en.wikipedia.org/wiki/Pseudorandomness
[PRNG]: https://en.wikipedia.org/wiki/Pseudorandom_number_generator
[chi-squared-test]: https://en.wikipedia.org/wiki/Pearson%27s_chi-squared_test
[p-value]: https://en.wikipedia.org/wiki/P-value
