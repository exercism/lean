import LeanTest
import Transpose

open LeanTest

def transposeTests : TestSuite :=
  (TestSuite.empty "Transpose")
  |>.addTest "empty string" (do
      return assertEqual "" (Transpose.transpose ""))
  |>.addTest "two characters in a row" (do
      return assertEqual "A\n1" (Transpose.transpose "A1"))
  |>.addTest "two characters in a column" (do
      return assertEqual "A1" (Transpose.transpose "A\n1"))
  |>.addTest "simple" (do
      return assertEqual "A1\nB2\nC3" (Transpose.transpose "ABC\n123"))
  |>.addTest "single line" (do
      return assertEqual "S\ni\nn\ng\nl\ne\n \nl\ni\nn\ne\n." (Transpose.transpose "Single line."))
  |>.addTest "first line longer than second line" (do
      return assertEqual "TT\nhh\nee\n  \nff\noi\nuf\nrt\nth\nh \n l\nli\nin\nne\ne.\n." (Transpose.transpose "The fourth line.\nThe fifth line."))
  |>.addTest "second line longer than first line" (do
      return assertEqual "TT\nhh\nee\n  \nfs\nie\nrc\nso\ntn\n d\nl \nil\nni\nen\n.e\n ." (Transpose.transpose "The first line.\nThe second line."))
  |>.addTest "mixed line length" (do
      return assertEqual "TAAA\nh   \nelll\n ooi\nlnnn\nogge\nn e.\nglr\nei \nsnl\ntei\n .n\nl e\ni .\nn\ne\n." (Transpose.transpose "The longest line.\nA long line.\nA longer line.\nA line."))
  |>.addTest "square" (do
      return assertEqual "HEART\nEMBER\nABUSE\nRESIN\nTREND" (Transpose.transpose "HEART\nEMBER\nABUSE\nRESIN\nTREND"))
  |>.addTest "rectangle" (do
      return assertEqual "FOBS\nRULE\nATOP\nCLOT\nTIME\nUNIT\nRENT\nEDGE" (Transpose.transpose "FRACTURE\nOUTLINED\nBLOOMING\nSEPTETTE"))
  |>.addTest "triangle" (do
      return assertEqual "TEASER\n EASER\n  ASER\n   SER\n    ER\n     R" (Transpose.transpose "T\nEE\nAAA\nSSSS\nEEEEE\nRRRRRR"))
  |>.addTest "jagged triangle" (do
      return assertEqual "123456\n1 3456\n  3456\n  3 56\n    56\n    5" (Transpose.transpose "11\n2\n3333\n444\n555555\n66666"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [transposeTests]
