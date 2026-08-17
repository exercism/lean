# Instructions

You are helping organize a game night with friends.

## 1. Check who can join

Define `canJoin`, a function with two `Bool` parameters, `hasConfirmed` and `isInvited`.
The function returns `true` only when both are `true`.

```lean
#eval canJoin true true   -- true
#eval canJoin true false  -- false
```

## 2. Check who brings snacks

Define `bringsSnacks`, a function with two `Bool` parameters, `isHost` and `volunteered`.
The function returns `true` when at least one of them is `true`.

```lean
#eval bringsSnacks true false  -- true
#eval bringsSnacks false false -- false
```

## 3. Check who is skipping game night

Define `isSkipping`, a function with one `Bool` parameter, `isComing`.
It returns the opposite of `isComing`.

```lean
#eval isSkipping true  -- false
#eval isSkipping false -- true
```

## 4. Check if two friends voted for the same game

Define `votedSame`, a function with two `Bool` parameters, `firstVote` and `secondVote`.
Each vote is `true` for "board game" and `false` for "video game".
It returns `true` when both friends voted for the same kind of game.

```lean
#eval votedSame true true   -- true
#eval votedSame true false  -- false
```

## 5. Check if there's exactly one scorekeeper

Define `hasScorekeeper`, a function with two `Bool` parameters, `aVolunteers` and `bVolunteers`.
It returns `true` only when exactly one of them is `true`.

```lean
#eval hasScorekeeper true false -- true
#eval hasScorekeeper true true  -- false
```
