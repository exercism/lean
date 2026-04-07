namespace Wordy

private inductive State where
  | start : State
  | op    : (Int → Int → Int) → Int → State
  | val   : Int → State

private def State.update : State → String → Option State
  | .start, xs             => val <$> xs.toInt?
  | .val n, "plus"         => op (· + ·) n
  | .val n, "minus"        => op (· - ·) n
  | .val n, "multiplied"   => op (· * ·) n
  | .val n, "divided"      => op (· / ·) n
  | state@(.op ..), "by"   => state
  | .op fn n, xs           => val <$> fn n <$> xs.toInt?
  | _, _                   => none

private def State.toInt? : State → Option Int
  | .val n => some n
  | _      => none

def answer (question : String) : Option Int := do
  let body ← (question.dropSuffix? "?") >>= (·.dropPrefix? "What is ") -- fails right away if any drop is unsuccessful
  let words := body.split " " |>.toStringList                          -- extracts words
  let final ← words.foldlM State.update .start                         -- monadic fold on words. Fails right away on none
  final.toInt?                                                         -- if parse was successful, extracts value from State

end Wordy
