import LeanTest
import Forth

instance {α β} [BEq α] [BEq β] : BEq (Except α β)  where
  beq
    | .ok a, .ok b => a == b
    | .error e1, .error e2 => e1 == e2
    | _, _ => false

open LeanTest

def forthTests : TestSuite :=
  (TestSuite.empty "Forth")
  |>.addTest "parsing and numbers -> numbers just get pushed onto the stack" (do
      return assertEqual (.ok [1, 2, 3, 4, 5]) (Forth.evaluate ["1 2 3 4 5"]))
  |>.addTest "parsing and numbers -> pushes negative numbers onto the stack" (do
      return assertEqual (.ok [-1, -2, -3, -4, -5]) (Forth.evaluate ["-1 -2 -3 -4 -5"]))
  |>.addTest "addition -> can add two numbers" (do
      return assertEqual (.ok [3]) (Forth.evaluate ["1 2 +"]))
  |>.addTest "addition -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["+"]))
  |>.addTest "addition -> errors if there is only one value on the stack" (do
      return assertEqual (.error "only one value on the stack") (Forth.evaluate ["1 +"]))
  |>.addTest "addition -> more than two values on the stack" (do
      return assertEqual (.ok [1, 5]) (Forth.evaluate ["1 2 3 +"]))
  |>.addTest "subtraction -> can subtract two numbers" (do
      return assertEqual (.ok [-1]) (Forth.evaluate ["3 4 -"]))
  |>.addTest "subtraction -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["-"]))
  |>.addTest "subtraction -> errors if there is only one value on the stack" (do
      return assertEqual (.error "only one value on the stack") (Forth.evaluate ["1 -"]))
  |>.addTest "subtraction -> more than two values on the stack" (do
      return assertEqual (.ok [1, 9]) (Forth.evaluate ["1 12 3 -"]))
  |>.addTest "multiplication -> can multiply two numbers" (do
      return assertEqual (.ok [8]) (Forth.evaluate ["2 4 *"]))
  |>.addTest "multiplication -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["*"]))
  |>.addTest "multiplication -> errors if there is only one value on the stack" (do
      return assertEqual (.error "only one value on the stack") (Forth.evaluate ["1 *"]))
  |>.addTest "multiplication -> more than two values on the stack" (do
      return assertEqual (.ok [1, 6]) (Forth.evaluate ["1 2 3 *"]))
  |>.addTest "division -> can divide two numbers" (do
      return assertEqual (.ok [4]) (Forth.evaluate ["12 3 /"]))
  |>.addTest "division -> performs integer division" (do
      return assertEqual (.ok [2]) (Forth.evaluate ["8 3 /"]))
  |>.addTest "division -> errors if dividing by zero" (do
      return assertEqual (.error "divide by zero") (Forth.evaluate ["4 0 /"]))
  |>.addTest "division -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["/"]))
  |>.addTest "division -> errors if there is only one value on the stack" (do
      return assertEqual (.error "only one value on the stack") (Forth.evaluate ["1 /"]))
  |>.addTest "division -> more than two values on the stack" (do
      return assertEqual (.ok [1, 4]) (Forth.evaluate ["1 12 3 /"]))
  |>.addTest "combined arithmetic -> addition and subtraction" (do
      return assertEqual (.ok [-1]) (Forth.evaluate ["1 2 + 4 -"]))
  |>.addTest "combined arithmetic -> multiplication and division" (do
      return assertEqual (.ok [2]) (Forth.evaluate ["2 4 * 3 /"]))
  |>.addTest "combined arithmetic -> multiplication and addition" (do
      return assertEqual (.ok [13]) (Forth.evaluate ["1 3 4 * +"]))
  |>.addTest "combined arithmetic -> addition and multiplication" (do
      return assertEqual (.ok [7]) (Forth.evaluate ["1 3 4 + *"]))
  |>.addTest "dup -> copies a value on the stack" (do
      return assertEqual (.ok [1, 1]) (Forth.evaluate ["1 dup"]))
  |>.addTest "dup -> copies the top value on the stack" (do
      return assertEqual (.ok [1, 2, 2]) (Forth.evaluate ["1 2 dup"]))
  |>.addTest "dup -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["dup"]))
  |>.addTest "drop -> removes the top value on the stack if it is the only one" (do
      return assertEqual (.ok []) (Forth.evaluate ["1 drop"]))
  |>.addTest "drop -> removes the top value on the stack if it is not the only one" (do
      return assertEqual (.ok [1]) (Forth.evaluate ["1 2 drop"]))
  |>.addTest "drop -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["drop"]))
  |>.addTest "swap -> swaps the top two values on the stack if they are the only ones" (do
      return assertEqual (.ok [2, 1]) (Forth.evaluate ["1 2 swap"]))
  |>.addTest "swap -> swaps the top two values on the stack if they are not the only ones" (do
      return assertEqual (.ok [1, 3, 2]) (Forth.evaluate ["1 2 3 swap"]))
  |>.addTest "swap -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["swap"]))
  |>.addTest "swap -> errors if there is only one value on the stack" (do
      return assertEqual (.error "only one value on the stack") (Forth.evaluate ["1 swap"]))
  |>.addTest "over -> copies the second element if there are only two" (do
      return assertEqual (.ok [1, 2, 1]) (Forth.evaluate ["1 2 over"]))
  |>.addTest "over -> copies the second element if there are more than two" (do
      return assertEqual (.ok [1, 2, 3, 2]) (Forth.evaluate ["1 2 3 over"]))
  |>.addTest "over -> errors if there is nothing on the stack" (do
      return assertEqual (.error "empty stack") (Forth.evaluate ["over"]))
  |>.addTest "over -> errors if there is only one value on the stack" (do
      return assertEqual (.error "only one value on the stack") (Forth.evaluate ["1 over"]))
  |>.addTest "user-defined words -> can consist of built-in words" (do
      return assertEqual (.ok [1, 1, 1]) (Forth.evaluate [": dup-twice dup dup ;","1 dup-twice"]))
  |>.addTest "user-defined words -> execute in the right order" (do
      return assertEqual (.ok [1, 2, 3]) (Forth.evaluate [": countup 1 2 3 ;","countup"]))
  |>.addTest "user-defined words -> can override other user-defined words" (do
      return assertEqual (.ok [1, 1, 1]) (Forth.evaluate [": foo dup ;",": foo dup dup ;","1 foo"]))
  |>.addTest "user-defined words -> can override built-in words" (do
      return assertEqual (.ok [1, 1]) (Forth.evaluate [": swap dup ;","1 swap"]))
  |>.addTest "user-defined words -> can override built-in operators" (do
      return assertEqual (.ok [12]) (Forth.evaluate [": + * ;","3 4 +"]))
  |>.addTest "user-defined words -> can use different words with the same name" (do
      return assertEqual (.ok [5, 6]) (Forth.evaluate [": foo 5 ;",": bar foo ;",": foo 6 ;","bar foo"]))
  |>.addTest "user-defined words -> can define word that uses word with the same name" (do
      return assertEqual (.ok [11]) (Forth.evaluate [": foo 10 ;",": foo foo 1 + ;","foo"]))
  |>.addTest "user-defined words -> cannot redefine non-negative numbers" (do
      return assertEqual (.error "illegal operation") (Forth.evaluate [": 1 2 ;"]))
  |>.addTest "user-defined words -> cannot redefine negative numbers" (do
      return assertEqual (.error "illegal operation") (Forth.evaluate [": -1 2 ;"]))
  |>.addTest "user-defined words -> errors if executing a non-existent word" (do
      return assertEqual (.error "undefined operation") (Forth.evaluate ["foo"]))
  |>.addTest "case-insensitivity -> DUP is case-insensitive" (do
      return assertEqual (.ok [1, 1, 1, 1]) (Forth.evaluate ["1 DUP Dup dup"]))
  |>.addTest "case-insensitivity -> DROP is case-insensitive" (do
      return assertEqual (.ok [1]) (Forth.evaluate ["1 2 3 4 DROP Drop drop"]))
  |>.addTest "case-insensitivity -> SWAP is case-insensitive" (do
      return assertEqual (.ok [2, 3, 4, 1]) (Forth.evaluate ["1 2 SWAP 3 Swap 4 swap"]))
  |>.addTest "case-insensitivity -> OVER is case-insensitive" (do
      return assertEqual (.ok [1, 2, 1, 2, 1]) (Forth.evaluate ["1 2 OVER Over over"]))
  |>.addTest "case-insensitivity -> user-defined words are case-insensitive" (do
      return assertEqual (.ok [1, 1, 1, 1]) (Forth.evaluate [": foo dup ;","1 FOO Foo foo"]))
  |>.addTest "case-insensitivity -> definitions are case-insensitive" (do
      return assertEqual (.ok [1, 1, 1, 1]) (Forth.evaluate [": SWAP DUP Dup dup ;","1 swap"]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [forthTests]
