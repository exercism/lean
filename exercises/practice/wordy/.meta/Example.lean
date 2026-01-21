namespace Wordy

inductive Expression where
  | sum     : Expression -> Expression
  | minus   : Expression -> Expression
  | mult    : Expression -> Expression
  | div     : Expression -> Expression
  | val     : Int -> Expression
  | bottom  : Expression
  deriving BEq, Repr

def Expression.parseStream? : Expression -> String -> Option Expression
  | .bottom, xs => xs.toInt? >>= (fun x => some (.val x))
  | .val n, "plus" => some (.sum (.val n))
  | .val n, "minus" => some (.minus (.val n))
  | .val n, "multipliedBy" => some (.mult (.val n))
  | .val n, "dividedBy" => some (.div (.val n))
  | .sum (.val n), xs => xs.toInt? >>= (fun x => some (.val (n + x)))
  | .minus (.val n), xs => xs.toInt? >>= (fun x => some (.val (n - x)))
  | .mult (.val n), xs => xs.toInt? >>= (fun x => some (.val (n * x)))
  | .div (.val n), xs => xs.toInt? >>= (fun x => some (.val (n / x)))
  | _, _  => none

def Expression.toInt? : Expression -> Option Int
  | .val n => some n
  | _ => none

def answer (question : String) : Option Int :=
  let normalizedQuestion := question.dropRightWhile (·=='?')
                        |> (·.replace "multiplied by" "multipliedBy")
                        |> (·.replace "divided by" "dividedBy")
  normalizedQuestion.dropPrefix? "What is "      -- (some rest) if prefix was there, none otherwise. The type of "rest" is Substring
  >>= (·.splitOn " " |> (pure ·))                -- splits rest on words and lifts it to an Option to allow chaining
  >>= (·.map (·.toString) |> (pure ·))           -- converts each word (a Substring) into a String, and lifts the list to an Option
  >>= (·.foldlM Expression.parseStream? .bottom) -- monadic folds the list. Short circuits on none, otherwise extracts result from some
  >>= Expression.toInt?                          -- if parse was successful, extracts value from Expression and lifts it to Option

end Wordy
