import LeanTest
import Acronym

open LeanTest

def acronymTests : TestSuite :=
  (TestSuite.empty "Acronym")
  |>.addTest "basic" (do
      return assertEqual "PNG" (Acronym.abbreviate "Portable Network Graphics"))
  |>.addTest "lowercase words" (do
      return assertEqual "ROR" (Acronym.abbreviate "Ruby on Rails"))
  |>.addTest "punctuation" (do
      return assertEqual "FIFO" (Acronym.abbreviate "First In, First Out"))
  |>.addTest "all caps word" (do
      return assertEqual "GIMP" (Acronym.abbreviate "GNU Image Manipulation Program"))
  |>.addTest "punctuation without whitespace" (do
      return assertEqual "CMOS" (Acronym.abbreviate "Complementary metal-oxide semiconductor"))
  |>.addTest "very long abbreviation" (do
      return assertEqual "ROTFLSHTMDCOALM" (Acronym.abbreviate "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"))
  |>.addTest "consecutive delimiters" (do
      return assertEqual "SIMUFTA" (Acronym.abbreviate "Something - I made up from thin air"))
  |>.addTest "apostrophes" (do
      return assertEqual "HC" (Acronym.abbreviate "Halley's Comet"))
  |>.addTest "underscore emphasis" (do
      return assertEqual "TRNT" (Acronym.abbreviate "The Road _Not_ Taken"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [acronymTests]
