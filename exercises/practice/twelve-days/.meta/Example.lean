namespace TwelveDays

abbrev VerseIndex := { x : Nat // 1 ≤ x ∧ x ≤ 12 }

def ordinal (verse : Nat) : String :=
  let ordinals := "firstsecondthirdfourthfifthsixthseventheighthninthtentheleventhtwelfth"
  let ordinalsTable := #[0, 0, 5, 11, 16, 22, 27, 32, 39, 45, 50, 55, 63, 70]
  ordinals
      |> (·.toList)
      |> (·.drop ordinalsTable[verse]!)
      |> (·.take (ordinalsTable[verse + 1]! - ordinalsTable[verse]!))
      |> (·.asString)

def gift (verse : Nat) : String :=
  let gifts := "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  let giftsTable := #[262, 235, 213, 194, 174, 157, 137, 113, 90, 69, 48, 26, 0]
  gifts
      |> (·.toList)
      |> (·.drop giftsTable[verse]!)
      |> (·.take (giftsTable[0]! - giftsTable[verse]!))
      |> (·.asString)

def lyrics (verse : Nat) : String :=
  s!"On the {ordinal verse} day of Christmas my true love gave to me: {gift verse}"

def recite (startVerse endVerse : VerseIndex) : List String :=
  List.range' startVerse.val (endVerse.val + 1 - startVerse.val)
      |> (·.map lyrics)

end TwelveDays
