import LeanTest
import TwelveDays

open LeanTest

def twelveDaysTests : TestSuite :=
  (TestSuite.empty "TwelveDays")
  |>.addTest "verse -> first day a partridge in a pear tree" (do
      return assertEqual [
        "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨1, by decide⟩ ⟨1, by decide⟩))
  |>.addTest "verse -> second day two turtle doves" (do
      return assertEqual [
        "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨2, by decide⟩ ⟨2, by decide⟩))
  |>.addTest "verse -> third day three french hens" (do
      return assertEqual [
        "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨3, by decide⟩ ⟨3, by decide⟩))
  |>.addTest "verse -> fourth day four calling birds" (do
      return assertEqual [
        "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨4, by decide⟩ ⟨4, by decide⟩))
  |>.addTest "verse -> fifth day five gold rings" (do
      return assertEqual [
        "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨5, by decide⟩ ⟨5, by decide⟩))
  |>.addTest "verse -> sixth day six geese-a-laying" (do
      return assertEqual [
        "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨6, by decide⟩ ⟨6, by decide⟩))
  |>.addTest "verse -> seventh day seven swans-a-swimming" (do
      return assertEqual [
        "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨7, by decide⟩ ⟨7, by decide⟩))
  |>.addTest "verse -> eighth day eight maids-a-milking" (do
      return assertEqual [
        "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨8, by decide⟩ ⟨8, by decide⟩))
  |>.addTest "verse -> ninth day nine ladies dancing" (do
      return assertEqual [
        "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨9, by decide⟩ ⟨9, by decide⟩))
  |>.addTest "verse -> tenth day ten lords-a-leaping" (do
      return assertEqual [
        "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨10, by decide⟩ ⟨10, by decide⟩))
  |>.addTest "verse -> eleventh day eleven pipers piping" (do
      return assertEqual [
        "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨11, by decide⟩ ⟨11, by decide⟩))
  |>.addTest "verse -> twelfth day twelve drummers drumming" (do
      return assertEqual [
        "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨12, by decide⟩ ⟨12, by decide⟩))
  |>.addTest "lyrics -> recites first three verses of the song" (do
      return assertEqual [
        "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.",
        "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨1, by decide⟩ ⟨3, by decide⟩))
  |>.addTest "lyrics -> recites three verses from the middle of the song" (do
      return assertEqual [
        "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨4, by decide⟩ ⟨6, by decide⟩))
  |>.addTest "lyrics -> recites the whole song" (do
      return assertEqual [
        "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.",
        "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.",
        "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
      ] (TwelveDays.recite ⟨1, by decide⟩ ⟨12, by decide⟩))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [twelveDaysTests]
