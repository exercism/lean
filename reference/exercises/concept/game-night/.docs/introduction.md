# Introduction

`Bool` is the type of truth values.
It has two values, `true` and `false`.

```lean
#eval true  -- true
```

## Combining Bool values

`&&` is "and". 
It is `true` only when both sides are `true`.

```lean
#eval true && false -- false
#eval true && true  -- true
```

`||` is "or". 
It is `true` when at least one side is `true`.

```lean
#eval true || false -- true
#eval false || false -- false
```

`!` is "not". 
It flips a `Bool`, so that `true` becomes `false` and `false` becomes `true`.

```lean
#eval !true  -- false
#eval !false -- true
```

`^^` is "xor" (exclusive or). 
It is `true` when exactly one side is `true`.
If both sides are `false` or both are `true`, it is `false`.

```lean
#eval true ^^ false -- true
#eval true ^^ true  -- false
```

## Short-circuit evaluation

`&&` does not look at its right side when the left side is `false`.
`||` does not look at its right side when the left side is `true`.
This is called short-circuit evaluation.

For example, `false && (some slow check)` skips the slow check entirely.
The result is already known to be `false` from the left side alone.

`^^` cannot short-circuit because its result always depends on both sides.

## Comparing Bool values

`Bool` supports `==` and `!=`, like `Nat` and `Int` do.

```lean
#eval true == true   -- true
#eval true == false  -- false
#eval true != false  -- true
```
