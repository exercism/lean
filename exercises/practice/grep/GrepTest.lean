import LeanTest
import Grep

open LeanTest

def grepTests : TestSuite :=
  (TestSuite.empty "Grep")
    |>.addTest "Test grepping a single file -> One file, one match, no flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Agamemnon", "iliad.txt"])
        let expected := "Of Atreus, Agamemnon, King of men.\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, one match, print line numbers flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Forbidden", "-n", "paradise-lost.txt"])
        let expected := "2:Of that Forbidden Tree, whose mortal tast\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, one match, case-insensitive flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["FORBIDDEN", "-i", "paradise-lost.txt"])
        let expected := "Of that Forbidden Tree, whose mortal tast\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, one match, print file names flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Forbidden", "-l", "paradise-lost.txt"])
        let expected := "paradise-lost.txt\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, one match, match entire lines flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["With loss of Eden, till one greater Man", "-x", "paradise-lost.txt"])
        let expected := "With loss of Eden, till one greater Man\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, one match, multiple flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["OF ATREUS, Agamemnon, KIng of MEN.", "-n", "-i", "-x", "iliad.txt"])
        let expected := "9:Of Atreus, Agamemnon, King of men.\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, several matches, no flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["may", "midsummer-night.txt"])
        let expected := "Nor how it may concern my modesty,\nBut I beseech your grace that I may know\nThe worst that may befall me in this case,\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, several matches, print line numbers flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["may", "-n", "midsummer-night.txt"])
        let expected := "3:Nor how it may concern my modesty,\n5:But I beseech your grace that I may know\n6:The worst that may befall me in this case,\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, several matches, match entire lines flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["may", "-x", "midsummer-night.txt"])
        let expected := ""
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, several matches, case-insensitive flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["ACHILLES", "-i", "iliad.txt"])
        let expected := "Achilles sing, O Goddess! Peleus' son;\nThe noble Chief Achilles from the son\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, several matches, inverted flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Of", "-v", "paradise-lost.txt"])
        let expected := "Brought Death into the World, and all our woe,\nWith loss of Eden, till one greater Man\nRestore us, and regain the blissful Seat,\nSing Heav'nly Muse, that on the secret top\nThat Shepherd, who first taught the chosen Seed\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, no matches, various flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Gandalf", "-n", "-l", "-x", "-i", "iliad.txt"])
        let expected := ""
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, one match, file flag takes precedence over line flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["ten", "-n", "-l", "iliad.txt"])
        let expected := "iliad.txt\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping a single file -> One file, several matches, inverted and match entire lines flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Illustrious into Ades premature,", "-x", "-v", "iliad.txt"])
        let expected := "Achilles sing, O Goddess! Peleus' son;\nHis wrath pernicious, who ten thousand woes\nCaused to Achaia's host, sent many a soul\nAnd Heroes gave (so stood the will of Jove)\nTo dogs and to all ravening fowls a prey,\nWhen fierce dispute had separated once\nThe noble Chief Achilles from the son\nOf Atreus, Agamemnon, King of men.\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, one match, no flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Agamemnon", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "iliad.txt:Of Atreus, Agamemnon, King of men.\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, several matches, no flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["may", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "midsummer-night.txt:Nor how it may concern my modesty,\nmidsummer-night.txt:But I beseech your grace that I may know\nmidsummer-night.txt:The worst that may befall me in this case,\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, several matches, print line numbers flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["that", "-n", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "midsummer-night.txt:5:But I beseech your grace that I may know\nmidsummer-night.txt:6:The worst that may befall me in this case,\nparadise-lost.txt:2:Of that Forbidden Tree, whose mortal tast\nparadise-lost.txt:6:Sing Heav'nly Muse, that on the secret top\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, one match, print file names flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["who", "-l", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "iliad.txt\nparadise-lost.txt\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, several matches, case-insensitive flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["TO", "-i", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "iliad.txt:Caused to Achaia's host, sent many a soul\niliad.txt:Illustrious into Ades premature,\niliad.txt:And Heroes gave (so stood the will of Jove)\niliad.txt:To dogs and to all ravening fowls a prey,\nmidsummer-night.txt:I do entreat your grace to pardon me.\nmidsummer-night.txt:In such a presence here to plead my thoughts;\nmidsummer-night.txt:If I refuse to wed Demetrius.\nparadise-lost.txt:Brought Death into the World, and all our woe,\nparadise-lost.txt:Restore us, and regain the blissful Seat,\nparadise-lost.txt:Sing Heav'nly Muse, that on the secret top\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, several matches, inverted flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["a", "-v", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "iliad.txt:Achilles sing, O Goddess! Peleus' son;\niliad.txt:The noble Chief Achilles from the son\nmidsummer-night.txt:If I refuse to wed Demetrius.\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, one match, match entire lines flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["But I beseech your grace that I may know", "-x", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "midsummer-night.txt:But I beseech your grace that I may know\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, one match, multiple flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["WITH LOSS OF EDEN, TILL ONE GREATER MAN", "-n", "-i", "-x", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "paradise-lost.txt:4:With loss of Eden, till one greater Man\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, no matches, various flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Frodo", "-n", "-l", "-x", "-i", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := ""
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, several matches, file flag takes precedence over line number flag" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["who", "-n", "-l", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "iliad.txt\nparadise-lost.txt\n"
        return assertEqual expected actual)
    |>.addTest "Test grepping multiples files at once -> Multiple files, several matches, inverted and match entire lines flags" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Illustrious into Ades premature,", "-x", "-v", "iliad.txt", "midsummer-night.txt", "paradise-lost.txt"])
        let expected := "iliad.txt:Achilles sing, O Goddess! Peleus' son;\niliad.txt:His wrath pernicious, who ten thousand woes\niliad.txt:Caused to Achaia's host, sent many a soul\niliad.txt:And Heroes gave (so stood the will of Jove)\niliad.txt:To dogs and to all ravening fowls a prey,\niliad.txt:When fierce dispute had separated once\niliad.txt:The noble Chief Achilles from the son\niliad.txt:Of Atreus, Agamemnon, King of men.\nmidsummer-night.txt:I do entreat your grace to pardon me.\nmidsummer-night.txt:I know not by what power I am made bold,\nmidsummer-night.txt:Nor how it may concern my modesty,\nmidsummer-night.txt:In such a presence here to plead my thoughts;\nmidsummer-night.txt:But I beseech your grace that I may know\nmidsummer-night.txt:The worst that may befall me in this case,\nmidsummer-night.txt:If I refuse to wed Demetrius.\nparadise-lost.txt:Of Mans First Disobedience, and the Fruit\nparadise-lost.txt:Of that Forbidden Tree, whose mortal tast\nparadise-lost.txt:Brought Death into the World, and all our woe,\nparadise-lost.txt:With loss of Eden, till one greater Man\nparadise-lost.txt:Restore us, and regain the blissful Seat,\nparadise-lost.txt:Sing Heav'nly Muse, that on the secret top\nparadise-lost.txt:Of Oreb, or of Sinai, didst inspire\nparadise-lost.txt:That Shepherd, who first taught the chosen Seed\n"
        return assertEqual expected actual)
    |>.addTest "Test error -> Called without arguments" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep [])
        let expected := "Called without arguments\n"
        return assertEqual expected actual)
    |>.addTest "Test error -> Called without a file" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["who"])
        let expected := "Called without a file name\n"
        return assertEqual expected actual)
    |>.addTest "Test error -> File not found" (do
        let (actual, _) <- IO.FS.withIsolatedStreams (Grep.grep ["Agamemnon", "odyssey.txt"])
        let expected := "File not found\n"
        return assertEqual expected actual)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [grepTests]
