/-
Extracts the literal source text of each `.addTest "<name>" (...)` call from
a test file, for use as the v3 interface's `test_code` field.
-/

namespace LeanTest.SourceParser

private def listStartsWith : List Char → List Char → Bool
  | _, [] => true
  | [], _ :: _ => false
  | x :: xs, p :: ps => x == p && listStartsWith xs ps

private def isSpace (c : Char) : Bool :=
  c == ' ' || c == '\t' || c == '\n' || c == '\r'

/-- Trim leading/trailing whitespace. Implemented over `List Char` rather
than `String.trim` because that function's signature has changed across
recent Lean versions. -/
private def trimStr (s : String) : String :=
  let chars := s.toList.dropWhile isSpace
  String.ofList (chars.reverse.dropWhile isSpace).reverse

/-- Find the first occurrence of `marker`, returning the remainder of the
list just after it, or `none` if `marker` doesn't occur. -/
private partial def findMarker (xs : List Char) (marker : List Char) : Option (List Char) :=
  match xs with
  | [] => none
  | _ :: rest =>
    if listStartsWith xs marker then some (xs.drop marker.length)
    else findMarker rest marker

/-- Read a (possibly-escaped) string literal's contents, given the list
right after the opening quote. Returns `(contents, remainder-after-close)`. -/
private partial def readStringLiteral (xs : List Char) : String × List Char :=
  go xs #[]
where
  go (xs : List Char) (acc : Array Char) : String × List Char :=
    match xs with
    | [] => (String.ofList acc.toList, [])
    | '\\' :: c :: rest => go rest (acc.push '\\' |>.push c)
    | '"' :: rest => (String.ofList acc.toList, rest)
    | c :: rest => go rest (acc.push c)

/-- Given the list starting right at an opening `(`, return
`(body, remainder-after-matching-close-paren)`, where `body` is everything
strictly between the matching parens. Parens and escapes inside string
literals are not counted towards nesting depth. -/
private partial def readParenBody (xs : List Char) : String × List Char :=
  match xs with
  | '(' :: rest => go rest 0 #[] false
  | _ => ("", xs)
where
  go (xs : List Char) (depth : Nat) (acc : Array Char) (inString : Bool) : String × List Char :=
    match xs with
    | [] => (String.ofList acc.toList, [])
    | '\\' :: c :: rest =>
      if inString then go rest depth (acc.push '\\' |>.push c) inString
      else go (c :: rest) depth (acc.push '\\') inString
    | '"' :: rest => go rest depth (acc.push '"') (!inString)
    | '(' :: rest =>
      if inString then go rest depth (acc.push '(') inString
      else go rest (depth + 1) (acc.push '(') inString
    | ')' :: rest =>
      if inString then go rest depth (acc.push ')') inString
      else if depth == 0 then (String.ofList acc.toList, rest)
      else go rest (depth - 1) (acc.push ')') inString
    | c :: rest => go rest depth (acc.push c) inString

/-- Extract `(test name, source body)` pairs for each `.addTest "<name>" (...)`
occurrence in `source`, in source order. The body has its outer `(do ... )`
wrapper stripped down to just the statements, mirroring the interface spec's
own `test_code` example (method body without the `def`/`end` wrapper). -/
partial def extractTestBodies (source : String) : List (String × String) :=
  go source.toList #[]
where
  marker := ".addTest \"".toList
  go (xs : List Char) (acc : Array (String × String)) : List (String × String) :=
    match findMarker xs marker with
    | none => acc.toList
    | some afterMarker =>
      let (name, afterName) := readStringLiteral afterMarker
      let afterWs := afterName.dropWhile isSpace
      let (body, rest) := readParenBody afterWs
      let trimmed := (trimStr body).toList
      let trimmed :=
        if listStartsWith trimmed ['d', 'o'] then
          (trimStr (String.ofList (trimmed.drop 2))).toList
        else trimmed
      go rest (acc.push (name, String.ofList trimmed))

/-- Look up the captured source for `name`, or `""` if extraction found
nothing for it (e.g. parsing failed, or the file couldn't be read). -/
def lookup (name : String) (bodies : List (String × String)) : String :=
  match bodies.find? (fun p => p.1 == name) with
  | some (_, code) => code
  | none => ""

end LeanTest.SourceParser
