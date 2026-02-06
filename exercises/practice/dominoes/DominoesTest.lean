import LeanTest
import Dominoes

open LeanTest

def dominoesTests : TestSuite :=
  (TestSuite.empty "Dominoes")
  |>.addTest "empty input = empty output" (do
      return assertTrue (Dominoes.canChain []))
  |>.addTest "singleton input = singleton output" (do
      return assertTrue (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨1, by decide⟩)
      ]))
  |>.addTest "singleton that can't be chained" (do
      return assertFalse (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩)
      ]))
  |>.addTest "three elements" (do
      return assertTrue (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨3, by decide⟩, ⟨1, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩)
      ]))
  |>.addTest "can reverse dominoes" (do
      return assertTrue (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨1, by decide⟩, ⟨3, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩)
      ]))
  |>.addTest "can't be chained" (do
      return assertFalse (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨4, by decide⟩, ⟨1, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩)
      ]))
  |>.addTest "disconnected - simple" (do
      return assertFalse (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨1, by decide⟩),
        (⟨2, by decide⟩, ⟨2, by decide⟩)
      ]))
  |>.addTest "disconnected - double loop" (do
      return assertFalse (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨2, by decide⟩, ⟨1, by decide⟩),
        (⟨3, by decide⟩, ⟨4, by decide⟩),
        (⟨4, by decide⟩, ⟨3, by decide⟩)
      ]))
  |>.addTest "disconnected - single isolated" (do
      return assertFalse (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩),
        (⟨3, by decide⟩, ⟨1, by decide⟩),
        (⟨4, by decide⟩, ⟨4, by decide⟩)
      ]))
  |>.addTest "need backtrack" (do
      return assertTrue (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩),
        (⟨3, by decide⟩, ⟨1, by decide⟩),
        (⟨2, by decide⟩, ⟨4, by decide⟩),
        (⟨2, by decide⟩, ⟨4, by decide⟩)
      ]))
  |>.addTest "separate loops" (do
      return assertTrue (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩),
        (⟨3, by decide⟩, ⟨1, by decide⟩),
        (⟨1, by decide⟩, ⟨1, by decide⟩),
        (⟨2, by decide⟩, ⟨2, by decide⟩),
        (⟨3, by decide⟩, ⟨3, by decide⟩)
      ]))
  |>.addTest "nine elements" (do
      return assertTrue (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨5, by decide⟩, ⟨3, by decide⟩),
        (⟨3, by decide⟩, ⟨1, by decide⟩),
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨2, by decide⟩, ⟨4, by decide⟩),
        (⟨1, by decide⟩, ⟨6, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩),
        (⟨3, by decide⟩, ⟨4, by decide⟩),
        (⟨5, by decide⟩, ⟨6, by decide⟩)
      ]))
  |>.addTest "separate three-domino loops" (do
      return assertFalse (Dominoes.canChain [
        (⟨1, by decide⟩, ⟨2, by decide⟩),
        (⟨2, by decide⟩, ⟨3, by decide⟩),
        (⟨3, by decide⟩, ⟨1, by decide⟩),
        (⟨4, by decide⟩, ⟨5, by decide⟩),
        (⟨5, by decide⟩, ⟨6, by decide⟩),
        (⟨6, by decide⟩, ⟨4, by decide⟩)
      ]))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [dominoesTests]
