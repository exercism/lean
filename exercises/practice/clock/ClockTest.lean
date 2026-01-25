import LeanTest
import Clock

open LeanTest

def clockTests : TestSuite :=
  (TestSuite.empty "Clock")
    |>.addTest "Create a new clock with an initial time -> on the hour" (do
      let clock := Clock.create 8 0
      return assertEqual "08:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> past the hour" (do
      let clock := Clock.create 11 9
      return assertEqual "11:09" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> midnight is zero hours" (do
      let clock := Clock.create 24 0
      return assertEqual "00:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> hour rolls over" (do
      let clock := Clock.create 25 0
      return assertEqual "01:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> hour rolls over continuously" (do
      let clock := Clock.create 100 0
      return assertEqual "04:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> sixty minutes is next hour" (do
      let clock := Clock.create 1 60
      return assertEqual "02:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> minutes roll over" (do
      let clock := Clock.create 0 160
      return assertEqual "02:40" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> minutes roll over continuously" (do
      let clock := Clock.create 0 1723
      return assertEqual "04:43" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> hour and minutes roll over" (do
      let clock := Clock.create 25 160
      return assertEqual "03:40" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> hour and minutes roll over continuously" (do
      let clock := Clock.create 201 3001
      return assertEqual "11:01" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> hour and minutes roll over to exactly midnight" (do
      let clock := Clock.create 72 8640
      return assertEqual "00:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative hour" (do
      let clock := Clock.create (-1) 15
      return assertEqual "23:15" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative hour rolls over" (do
      let clock := Clock.create (-25) 0
      return assertEqual "23:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative hour rolls over continuously" (do
      let clock := Clock.create (-91) 0
      return assertEqual "05:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative minutes" (do
      let clock := Clock.create 1 (-40)
      return assertEqual "00:20" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative minutes roll over" (do
      let clock := Clock.create 1 (-160)
      return assertEqual "22:20" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative minutes roll over continuously" (do
      let clock := Clock.create 1 (-4820)
      return assertEqual "16:40" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative sixty minutes is previous hour" (do
      let clock := Clock.create 2 (-60)
      return assertEqual "01:00" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative hour and minutes both roll over" (do
      let clock := Clock.create (-25) (-160)
      return assertEqual "20:20" (s!"{clock}"))
    |>.addTest "Create a new clock with an initial time -> negative hour and minutes both roll over continuously" (do
      let clock := Clock.create (-121) (-5810)
      return assertEqual "22:10" (s!"{clock}"))
    |>.addTest "Add minutes -> add minutes" (do
      let original := Clock.create 10 0
      let transformed := Clock.add original 3
      return assertEqual "10:03" (s!"{transformed}"))
    |>.addTest "Add minutes -> add no minutes" (do
      let original := Clock.create 6 41
      let transformed := Clock.add original 0
      return assertEqual "06:41" (s!"{transformed}"))
    |>.addTest "Add minutes -> add to next hour" (do
      let original := Clock.create 0 45
      let transformed := Clock.add original 40
      return assertEqual "01:25" (s!"{transformed}"))
    |>.addTest "Add minutes -> add more than one hour" (do
      let original := Clock.create 10 0
      let transformed := Clock.add original 61
      return assertEqual "11:01" (s!"{transformed}"))
    |>.addTest "Add minutes -> add more than two hours with carry" (do
      let original := Clock.create 0 45
      let transformed := Clock.add original 160
      return assertEqual "03:25" (s!"{transformed}"))
    |>.addTest "Add minutes -> add across midnight" (do
      let original := Clock.create 23 59
      let transformed := Clock.add original 2
      return assertEqual "00:01" (s!"{transformed}"))
    |>.addTest "Add minutes -> add more than one day (1500 min = 25 hrs)" (do
      let original := Clock.create 5 32
      let transformed := Clock.add original 1500
      return assertEqual "06:32" (s!"{transformed}"))
    |>.addTest "Add minutes -> add more than two days" (do
      let original := Clock.create 1 1
      let transformed := Clock.add original 3500
      return assertEqual "11:21" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract minutes" (do
      let original := Clock.create 10 3
      let transformed := Clock.subtract original 3
      return assertEqual "10:00" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract to previous hour" (do
      let original := Clock.create 10 3
      let transformed := Clock.subtract original 30
      return assertEqual "09:33" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract more than an hour" (do
      let original := Clock.create 10 3
      let transformed := Clock.subtract original 70
      return assertEqual "08:53" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract across midnight" (do
      let original := Clock.create 0 3
      let transformed := Clock.subtract original 4
      return assertEqual "23:59" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract more than two hours" (do
      let original := Clock.create 0 0
      let transformed := Clock.subtract original 160
      return assertEqual "21:20" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract more than two hours with borrow" (do
      let original := Clock.create 6 15
      let transformed := Clock.subtract original 160
      return assertEqual "03:35" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract more than one day (1500 min = 25 hrs)" (do
      let original := Clock.create 5 32
      let transformed := Clock.subtract original 1500
      return assertEqual "04:32" (s!"{transformed}"))
    |>.addTest "Subtract minutes -> subtract more than two days" (do
      let original := Clock.create 2 20
      let transformed := Clock.subtract original 3000
      return assertEqual "00:20" (s!"{transformed}"))
    |>.addTest "Compare two clocks for equality -> clocks with same time" (do
      let clock1 := Clock.create 15 37
      let clock2 := Clock.create 15 37
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks a minute apart" (do
      let clock1 := Clock.create 15 36
      let clock2 := Clock.create 15 37
      return assertEqual false (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks an hour apart" (do
      let clock1 := Clock.create 14 37
      let clock2 := Clock.create 15 37
      return assertEqual false (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with hour overflow" (do
      let clock1 := Clock.create 10 37
      let clock2 := Clock.create 34 37
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with hour overflow by several days" (do
      let clock1 := Clock.create 3 11
      let clock2 := Clock.create 99 11
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative hour" (do
      let clock1 := Clock.create 22 40
      let clock2 := Clock.create (-2) 40
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative hour that wraps" (do
      let clock1 := Clock.create 17 3
      let clock2 := Clock.create (-31) 3
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative hour that wraps multiple times" (do
      let clock1 := Clock.create 13 49
      let clock2 := Clock.create (-83) 49
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with minute overflow" (do
      let clock1 := Clock.create 0 1
      let clock2 := Clock.create 0 1441
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with minute overflow by several days" (do
      let clock1 := Clock.create 2 2
      let clock2 := Clock.create 2 4322
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative minute" (do
      let clock1 := Clock.create 2 40
      let clock2 := Clock.create 3 (-20)
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative minute that wraps" (do
      let clock1 := Clock.create 4 10
      let clock2 := Clock.create 5 (-1490)
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative minute that wraps multiple times" (do
      let clock1 := Clock.create 6 15
      let clock2 := Clock.create 6 (-4305)
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative hours and minutes" (do
      let clock1 := Clock.create 7 32
      let clock2 := Clock.create (-12) (-268)
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> clocks with negative hours and minutes that wrap" (do
      let clock1 := Clock.create 18 7
      let clock2 := Clock.create (-54) (-11513)
      return assertEqual true (clock1 == clock2))
    |>.addTest "Compare two clocks for equality -> full clock and zeroed clock" (do
      let clock1 := Clock.create 24 0
      let clock2 := Clock.create 0 0
      return assertEqual true (clock1 == clock2))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [clockTests]
