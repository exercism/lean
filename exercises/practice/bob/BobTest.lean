import LeanTest
import Bob

open LeanTest

def bobTests : TestSuite :=
  (TestSuite.empty "Bob")
  |>.addTest "stating something" (do
      return assertEqual "Whatever." (Bob.response "Tom-ay-to, tom-aaaah-to."))
  |>.addTest "shouting" (do
      return assertEqual "Whoa, chill out!" (Bob.response "WATCH OUT!"))
  |>.addTest "shouting gibberish" (do
      return assertEqual "Whoa, chill out!" (Bob.response "FCECDFCAAB"))
  |>.addTest "asking a question" (do
      return assertEqual "Sure." (Bob.response "Does this cryogenic chamber make me look fat?"))
  |>.addTest "asking a numeric question" (do
      return assertEqual "Sure." (Bob.response "You are, what, like 15?"))
  |>.addTest "asking gibberish" (do
      return assertEqual "Sure." (Bob.response "fffbbcbeab?"))
  |>.addTest "talking forcefully" (do
      return assertEqual "Whatever." (Bob.response "Hi there!"))
  |>.addTest "using acronyms in regular speech" (do
      return assertEqual "Whatever." (Bob.response "It's OK if you don't want to go work for NASA."))
  |>.addTest "forceful question" (do
      return assertEqual "Calm down, I know what I'm doing!" (Bob.response "WHAT'S GOING ON?"))
  |>.addTest "shouting numbers" (do
      return assertEqual "Whoa, chill out!" (Bob.response "1, 2, 3 GO!"))
  |>.addTest "no letters" (do
      return assertEqual "Whatever." (Bob.response "1, 2, 3"))
  |>.addTest "question with no letters" (do
      return assertEqual "Sure." (Bob.response "4?"))
  |>.addTest "shouting with special characters" (do
      return assertEqual "Whoa, chill out!" (Bob.response "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"))
  |>.addTest "shouting with no exclamation mark" (do
      return assertEqual "Whoa, chill out!" (Bob.response "I HATE THE DENTIST"))
  |>.addTest "statement containing question mark" (do
      return assertEqual "Whatever." (Bob.response "Ending with ? means a question."))
  |>.addTest "non-letters with question" (do
      return assertEqual "Sure." (Bob.response ":) ?"))
  |>.addTest "prattling on" (do
      return assertEqual "Sure." (Bob.response "Wait! Hang on. Are you going to be OK?"))
  |>.addTest "silence" (do
      return assertEqual "Fine. Be that way!" (Bob.response ""))
  |>.addTest "prolonged silence" (do
      return assertEqual "Fine. Be that way!" (Bob.response "          "))
  |>.addTest "alternate silence" (do
      return assertEqual "Fine. Be that way!" (Bob.response "\t\t\t\t\t\t\t\t\t\t"))
  |>.addTest "starting with whitespace" (do
      return assertEqual "Whatever." (Bob.response "         hmmmmmmm..."))
  |>.addTest "ending with whitespace" (do
      return assertEqual "Sure." (Bob.response "Okay if like my  spacebar  quite a bit?   "))
  |>.addTest "other whitespace" (do
      return assertEqual "Fine. Be that way!" (Bob.response "\n\r \t"))
  |>.addTest "non-question ending with whitespace" (do
      return assertEqual "Whatever." (Bob.response "This is a statement ending with whitespace      "))
  |>.addTest "multiple line question" (do
      return assertEqual "Sure." (Bob.response "\nDoes this cryogenic chamber make\n me look fat?"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [bobTests]
