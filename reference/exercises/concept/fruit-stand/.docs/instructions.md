# Instructions

You are helping out at a small fruit stand for the day.
All apples are sold at the same price, and you want a few functions to keep track of the money.

The `#eval` lines below show the value you should get.
You can only see this if you run Lean locally.
The online editor does not show `#eval` output.

## 1. Set the price of one apple

Define the constant `applePrice`, the price of one apple, in cents.
Today, apples cost `50` cents each.

```lean
#eval applePrice -- 50
```

## 2. Calculate the revenue

Define `revenue`, a function that takes the number of apples sold, and returns how much money came in.

```lean
#eval revenue 10 -- 500
#eval revenue 0  -- 0
```

## 3. Calculate the profit

Define `profit`, a function with two parameters, the number of apples sold and the day's expenses.
It returns how much money is left after paying those expenses.

```lean
#eval profit 10 30  -- 470
#eval profit 0 0    -- 0
```
