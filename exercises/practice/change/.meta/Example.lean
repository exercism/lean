namespace Change

inductive Result where
  | ok : Array Nat -> Result
  | error : String -> Result
  deriving BEq, Repr

def findFewestCoins (coins : Array Nat) (target : Int) : Result := Id.run do
  match target.toNat? with
  | none => return .error "target can't be negative"
  | some targetNat =>
    let mut memo : Array (Option (Array Nat)) := Array.replicate (targetNat + 1) none
    let mut assigned := true

    memo := memo.set! 0 (some #[])

    while assigned do
      assigned := false
      for i in [:memo.size] do
        let crtResult := memo[i]!
        if hasResult : crtResult.isSome then
          let crtResultValue := crtResult.get hasResult
          for coin in coins do
            let sum := i + coin
            if validSum : sum < memo.size then
              let sumResult := memo[sum]
              if sumResult.isNone || crtResultValue.size + 1 < sumResult.get!.size then
                memo := memo.set sum (crtResultValue.push coin)
                assigned := true

    match memo.back! with
    | some result => return .ok result
    | none => return .error "can't make target with given coins"

end Change
