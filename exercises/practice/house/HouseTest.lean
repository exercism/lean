import LeanTest
import House

open LeanTest

def houseTests : TestSuite :=
  (TestSuite.empty "House")
  |>.addTest "verse one - the house that jack built" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the house that Jack built."
      ]) (House.recite ⟨1, by decide⟩ ⟨1, by decide⟩))
  |>.addTest "verse two - the malt that lay" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the malt that lay in the house that Jack built."
      ]) (House.recite ⟨2, by decide⟩ ⟨2, by decide⟩))
  |>.addTest "verse three - the rat that ate" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨3, by decide⟩ ⟨3, by decide⟩))
  |>.addTest "verse four - the cat that killed" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨4, by decide⟩ ⟨4, by decide⟩))
  |>.addTest "verse five - the dog that worried" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨5, by decide⟩ ⟨5, by decide⟩))
  |>.addTest "verse six - the cow with the crumpled horn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨6, by decide⟩ ⟨6, by decide⟩))
  |>.addTest "verse seven - the maiden all forlorn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨7, by decide⟩ ⟨7, by decide⟩))
  |>.addTest "verse eight - the man all tattered and torn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨8, by decide⟩ ⟨8, by decide⟩))
  |>.addTest "verse nine - the priest all shaven and shorn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨9, by decide⟩ ⟨9, by decide⟩))
  |>.addTest "verse 10 - the rooster that crowed in the morn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨10, by decide⟩ ⟨10, by decide⟩))
  |>.addTest "verse 11 - the farmer sowing his corn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨11, by decide⟩ ⟨11, by decide⟩))
  |>.addTest "verse 12 - the horse and the hound and the horn" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨12, by decide⟩ ⟨12, by decide⟩))
  |>.addTest "multiple verses" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨4, by decide⟩ ⟨8, by decide⟩))
  |>.addTest "full rhyme" (do
      return assertEqual (String.intercalate "\n\n" [
        "This is the house that Jack built.",
        "This is the malt that lay in the house that Jack built.",
        "This is the rat that ate the malt that lay in the house that Jack built.",
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.",
        "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
      ]) (House.recite ⟨1, by decide⟩ ⟨12, by decide⟩))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [houseTests]
