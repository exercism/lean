import LeanTest
import Bob

open LeanTest

def bobTests : TestSuite :=
  (TestSuite.empty "Bob")
  |>.addTest "asking a question" (do
      return assertEqual "Sure." (Bob.response "Does this cryogenic chamber make me look fat?"))
  |>.addTest "shouting" (do
      return assertEqual "Whoa, chill out!" (Bob.response "WATCH OUT!"))
  |>.addTest "forceful question" (do
      return assertEqual "Calm down, I know what I'm doing!" (Bob.response "WHAT'S GOING ON?"))
  |>.addTest "silence" (do
      return assertEqual "Fine. Be that way!" (Bob.response ""))
  |>.addTest "stating something" (do
      return assertEqual "Whatever." (Bob.response "Tom-ay-to, tom-aaaah-to."))
  |>.addTest "asking a numeric question" (do
      return assertEqual "Sure." (Bob.response "You are, what, like 15?"))
  |>.addTest "asking gibberish" (do
      return assertEqual "Sure." (Bob.response "fffbbcbeab?"))
  |>.addTest "question with no letters" (do
      return assertEqual "Sure." (Bob.response "4?"))
  |>.addTest "non-letters with question" (do
      return assertEqual "Sure." (Bob.response ":) ?"))
  |>.addTest "prattling on" (do
      return assertEqual "Sure." (Bob.response "Wait! Hang on. Are you going to be OK?"))
  |>.addTest "ending with whitespace" (do
      return assertEqual "Sure." (Bob.response "Okay if like my  spacebar  quite a bit?   "))
  |>.addTest "multiple line question" (do
      return assertEqual "Sure." (Bob.response "\nDoes this cryogenic chamber make\n me look fat?"))
  |>.addTest "shouting gibberish" (do
      return assertEqual "Whoa, chill out!" (Bob.response "FCECDFCAAB"))
  |>.addTest "shouting a statement containing a question mark" (do
      return assertEqual "Whoa, chill out!" (Bob.response "DO LIONS EAT PEOPLE? AHHHHH."))
  |>.addTest "shouting numbers" (do
      return assertEqual "Whoa, chill out!" (Bob.response "1, 2, 3 GO!"))
  |>.addTest "shouting with special characters" (do
      return assertEqual "Whoa, chill out!" (Bob.response "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"))
  |>.addTest "shouting with no exclamation mark" (do
      return assertEqual "Whoa, chill out!" (Bob.response "I HATE THE DENTIST"))
  |>.addTest "prolonged silence" (do
      return assertEqual "Fine. Be that way!" (Bob.response "          "))
  |>.addTest "alternate silence" (do
      return assertEqual "Fine. Be that way!" (Bob.response "\t\t\t\t\t\t\t\t\t\t"))
  |>.addTest "other whitespace" (do
      return assertEqual "Fine. Be that way!" (Bob.response "\n\r \t"))
  |>.addTest "talking forcefully" (do
      return assertEqual "Whatever." (Bob.response "Hi there!"))
  |>.addTest "using acronyms in regular speech" (do
      return assertEqual "Whatever." (Bob.response "It's OK if you don't want to go work for NASA."))
  |>.addTest "no letters" (do
      return assertEqual "Whatever." (Bob.response "1, 2, 3"))
  |>.addTest "statement containing question mark" (do
      return assertEqual "Whatever." (Bob.response "Ending with ? means a question."))
  |>.addTest "starting with whitespace" (do
      return assertEqual "Whatever." (Bob.response "         hmmmmmmm..."))
  |>.addTest "non-question ending with whitespace" (do
      return assertEqual "Whatever." (Bob.response "This is a statement ending with whitespace      "))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [bobTests]
