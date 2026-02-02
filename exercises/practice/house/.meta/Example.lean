namespace House

abbrev VerseIndex := { x : Nat // 1 ≤ x ∧ x ≤ 12 }

def protagonists : List String := [
  "house that Jack built.",
  "malt",
  "rat",
  "cat",
  "dog",
  "cow with the crumpled horn",
  "maiden all forlorn",
  "man all tattered and torn",
  "priest all shaven and shorn",
  "rooster that crowed in the morn",
  "farmer sowing his corn",
  "horse and the hound and the horn",
]

def actions : List String := [
  "lay in",
  "ate",
  "killed",
  "worried",
  "tossed",
  "milked",
  "kissed",
  "married",
  "woke",
  "kept",
  "belonged to",
]

def allVerses : List String := protagonists.mapIdx (λ i p =>
    s!"This is the {p} " ++
    String.intercalate " " (actions.take i |>.mapIdx (λ j a =>
      s!"that {a} the {protagonists[j]!}"
    ) |>.reverse)
    |>.trimRight
  )


def recite (startVerse endVerse : VerseIndex) : String :=
  let start := startVerse.val
  let length := endVerse.val - start + 1
  String.intercalate "\n" (allVerses.drop (start - 1) |>.take length)

end House
