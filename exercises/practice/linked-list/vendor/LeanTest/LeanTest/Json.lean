/-
Minimal, dependency-free JSON string building.

This intentionally avoids `import Lean` (the compiler's own JSON support
lives in the `Lean` library, which is deliberately stripped from the
test-runner image to save ~1.2GB — see the Dockerfile). Everything here is
plain `String`/`Char`/`List` manipulation.
-/

namespace LeanTest.Json

private def hexDigit (n : Nat) : Char :=
  if n < 10 then Char.ofNat (n + 48) else Char.ofNat (n - 10 + 97)

private def toHex4 (n : Nat) : String :=
  let d0 := hexDigit ((n / 4096) % 16)
  let d1 := hexDigit ((n / 256) % 16)
  let d2 := hexDigit ((n / 16) % 16)
  let d3 := hexDigit (n % 16)
  String.ofList [d0, d1, d2, d3]

private def escapeChar (c : Char) : String :=
  match c with
  | '"' => "\\\""
  | '\\' => "\\\\"
  | '\n' => "\\n"
  | '\r' => "\\r"
  | '\t' => "\\t"
  | c => if c.toNat < 0x20 then "\\u" ++ toHex4 c.toNat else String.ofList [c]

/-- Escape a string's contents for embedding between JSON double-quotes. -/
def escape (s : String) : String :=
  String.join (s.toList.map escapeChar)

/-- A JSON string literal, including the surrounding quotes. -/
def str (s : String) : String :=
  "\"" ++ escape s ++ "\""

/-- A JSON string literal, or `null` when absent. -/
def strOrNull : Option String → String
  | none => "null"
  | some s => str s

/-- A JSON number, or `null` when absent. -/
def natOrNull : Option Nat → String
  | none => "null"
  | some n => toString n

/-- Truncate `s` to at most `maxLen` characters, per the interface spec's
hard limit on the top-level `message` field (65535 chars). -/
def truncate (s : String) (maxLen : Nat) : String :=
  if s.length <= maxLen then s
  else String.ofList (s.toList.take (maxLen - 1)) ++ "…"

/-- Build a JSON object from a list of already-encoded `"key": value` pairs. -/
def object (fields : List String) : String :=
  "{" ++ String.intercalate ", " fields ++ "}"

/-- Build a JSON array from a list of already-encoded elements. -/
def array (elems : List String) : String :=
  "[" ++ String.intercalate ", " elems ++ "]"

end LeanTest.Json
