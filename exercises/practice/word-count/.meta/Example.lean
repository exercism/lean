import Std.Data.HashMap

namespace WordCount

abbrev Map := Std.HashMap String Nat

inductive State where
  | word        : String → Map → State
  | contraction : String → Map → State
  | delim       : Map → State

def addWord (word : String) (map : Map) : Map :=
  map.alter word.toLower fun
    | some n => some (n + 1)
    | none   => some 1

def countWords (sentence : String) : Std.HashMap String Nat :=
  sentence.foldl (init := State.delim {}) (fun
    | .word ws ms, ch =>
      if ch == '\'' then .contraction ws ms
      else if ch.isAlphanum then .word (ws.push ch) ms
      else .delim (addWord ws ms)
    | .contraction ws ms, ch =>
      if ch.isAlphanum then .word (ws ++ s!"'{ch}") ms
      else .delim (addWord ws ms)
    | .delim ms, ch =>
      if ch.isAlphanum then .word s!"{ch}" ms
      else .delim ms)
  |> fun
      | .word ws ms => addWord ws ms
      | .contraction ws ms => addWord ws ms
      | .delim ms => ms

end WordCount
