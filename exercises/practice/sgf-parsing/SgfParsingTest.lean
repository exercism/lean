import LeanTest
import SgfParsing

open LeanTest

instance {α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false

instance : BEq (Std.TreeMap String (Array String)) where
  beq a b := a.toList == b.toList

deriving instance BEq for SgfParsing.SgfTree

def sgfParsingTests : TestSuite :=
  (TestSuite.empty "SgfParsing")
  |>.addTest "empty input" (do
      return assertEqual (.error "tree missing") (SgfParsing.parse ""))
  |>.addTest "tree with no nodes" (do
      return assertEqual (.error "tree with no nodes") (SgfParsing.parse "()"))
  |>.addTest "node without tree" (do
      return assertEqual (.error "tree missing") (SgfParsing.parse ";"))
  |>.addTest "node without properties" (do
      return assertEqual (.ok ⟨{}, #[]⟩) (SgfParsing.parse "(;)"))
  |>.addTest "single node tree" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["B"])], #[]⟩) (SgfParsing.parse "(;A[B])"))
  |>.addTest "multiple properties" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["b"]), ("C", #["d"])], #[]⟩) (SgfParsing.parse "(;A[b]C[d])"))
  |>.addTest "properties without delimiter" (do
      return assertEqual (.error "properties without delimiter") (SgfParsing.parse "(;A)"))
  |>.addTest "all lowercase property" (do
      return assertEqual (.error "property must be in uppercase") (SgfParsing.parse "(;a[b])"))
  |>.addTest "upper and lowercase property" (do
      return assertEqual (.error "property must be in uppercase") (SgfParsing.parse "(;Aa[b])"))
  |>.addTest "two nodes" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["B"])], #[
        ⟨.ofArray #[("B", #["C"])], #[]⟩
      ]⟩) (SgfParsing.parse "(;A[B];B[C])"))
  |>.addTest "two child trees" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["B"])], #[
        ⟨.ofArray #[("B", #["C"])], #[]⟩,
        ⟨.ofArray #[("C", #["D"])], #[]⟩
      ]⟩) (SgfParsing.parse "(;A[B](;B[C])(;C[D]))"))
  |>.addTest "multiple property values" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["b", "c", "d"])], #[]⟩) (SgfParsing.parse "(;A[b][c][d])"))
  |>.addTest "within property values, whitespace characters such as tab are converted to spaces" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["hello  world"])], #[]⟩) (SgfParsing.parse "(;A[hello\u0009\u0009world])"))
  |>.addTest "within property values, newlines remain as newlines" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["hello\n\nworld"])], #[]⟩) (SgfParsing.parse "(;A[hello\n\nworld])"))
  |>.addTest "escaped closing bracket within property value becomes just a closing bracket" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["]"])], #[]⟩) (SgfParsing.parse "(;A[\\]])"))
  |>.addTest "escaped backslash in property value becomes just a backslash" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["\\"])], #[]⟩) (SgfParsing.parse "(;A[\\\\])"))
  |>.addTest "opening bracket within property value doesn't need to be escaped" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["x[y]z", "foo"]), ("B", #["bar"])], #[
        ⟨.ofArray #[("C", #["baz"])], #[]⟩
      ]⟩) (SgfParsing.parse "(;A[x[y\\]z][foo]B[bar];C[baz])"))
  |>.addTest "semicolon in property value doesn't need to be escaped" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["a;b", "foo"]), ("B", #["bar"])], #[
        ⟨.ofArray #[("C", #["baz"])], #[]⟩
      ]⟩) (SgfParsing.parse "(;A[a;b][foo]B[bar];C[baz])"))
  |>.addTest "parentheses in property value don't need to be escaped" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["x(y)z", "foo"]), ("B", #["bar"])], #[
        ⟨.ofArray #[("C", #["baz"])], #[]⟩
      ]⟩) (SgfParsing.parse "(;A[x(y)z][foo]B[bar];C[baz])"))
  |>.addTest "escaped tab in property value is converted to space" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["hello world"])], #[]⟩) (SgfParsing.parse "(;A[hello\\\u0009world])"))
  |>.addTest "escaped newline in property value is converted to nothing at all" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["helloworld"])], #[]⟩) (SgfParsing.parse "(;A[hello\\\nworld])"))
  |>.addTest "escaped t and n in property value are just letters, not whitespace" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["t = t and n = n"])], #[]⟩) (SgfParsing.parse "(;A[\\t = t and \\n = n])"))
  |>.addTest "mixing various kinds of whitespace and escaped characters in property value" (do
      return assertEqual (.ok ⟨.ofArray #[("A", #["]b\ncd  e\\ ]"])], #[]⟩) (SgfParsing.parse "(;A[\\]b\nc\\\nd\u0009\u0009e\\\\ \\\n\\]])"))
  |>.addTest "complex child trees" (do
      return assertEqual (.ok ⟨.ofArray #[("FF", #["4"])], #[
        ⟨.ofArray #[("B", #["aa"])], #[
          ⟨.ofArray #[("W", #["ab"])], #[]⟩
        ]⟩,
        ⟨.ofArray #[("B", #["dd"])], #[
          ⟨.ofArray #[("W", #["ee"])], #[]⟩
        ]⟩
      ]⟩) (SgfParsing.parse "(;FF[4](;B[aa];W[ab])(;B[dd];W[ee]))"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [sgfParsingTests]
