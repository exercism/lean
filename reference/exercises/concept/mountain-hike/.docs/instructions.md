# Instructions

You are logging data from a mountain hike.

## 1. Convert hours and minutes to total minutes

Define `totalMinutes`, a function with two `Nat` parameters, hours and minutes.
It returns the total number of minutes.

```lean
#eval totalMinutes 2 30 -- 150
#eval totalMinutes 0 45 -- 45
```

## 2. Split total minutes back into hours and minutes

Define `fullHours`, a function that takes a total number of minutes.
It returns how many full hours that is.

Define `remainingMinutes`, a function that takes a total number of minutes.
It returns the minutes left over after the full hours.

```lean
#eval fullHours 150        -- 2
#eval remainingMinutes 150 -- 30
#eval fullHours 45         -- 0
#eval remainingMinutes 45  -- 45
```

## 3. Calculate the water left in a canteen

Define `waterLeft`, a function with two `Nat` parameters, the canteen's capacity and the water already used, both in milliliters.
It returns how much water is left.

A canteen can never hold less than `0` water.

```lean
#eval waterLeft 2000 500  -- 1500
#eval waterLeft 2000 5000 -- 0
```

## 4. Calculate the elevation change

Define `elevationChange`, a function with two `Int` parameters, the starting and the final altitude, in meters.
It returns the difference between them.
The result is negative when the hike went downhill.

```lean
#eval elevationChange 1200 1450 -- 250
#eval elevationChange 1200 950  -- -250
```
