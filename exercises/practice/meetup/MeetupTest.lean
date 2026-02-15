import LeanTest
import Meetup

open LeanTest

def meetupTests : TestSuite :=
  (TestSuite.empty "Meetup")
  |>.addTest "when teenth Monday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-05-13" (Meetup.meetup .Monday ⟨5, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Monday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-08-19" (Meetup.meetup .Monday ⟨8, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Monday is some day in the middle of the teenth week" (do
      return assertEqual "2013-09-16" (Meetup.meetup .Monday ⟨9, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Tuesday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-03-19" (Meetup.meetup .Tuesday ⟨3, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Tuesday is some day in the middle of the teenth week" (do
      return assertEqual "2013-04-16" (Meetup.meetup .Tuesday ⟨4, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Tuesday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-08-13" (Meetup.meetup .Tuesday ⟨8, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Wednesday is some day in the middle of the teenth week" (do
      return assertEqual "2013-01-16" (Meetup.meetup .Wednesday ⟨1, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Wednesday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-02-13" (Meetup.meetup .Wednesday ⟨2, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Wednesday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-06-19" (Meetup.meetup .Wednesday ⟨6, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Thursday is some day in the middle of the teenth week" (do
      return assertEqual "2013-05-16" (Meetup.meetup .Thursday ⟨5, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Thursday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-06-13" (Meetup.meetup .Thursday ⟨6, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Thursday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-09-19" (Meetup.meetup .Thursday ⟨9, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Friday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-04-19" (Meetup.meetup .Friday ⟨4, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Friday is some day in the middle of the teenth week" (do
      return assertEqual "2013-08-16" (Meetup.meetup .Friday ⟨8, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Friday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-09-13" (Meetup.meetup .Friday ⟨9, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Saturday is some day in the middle of the teenth week" (do
      return assertEqual "2013-02-16" (Meetup.meetup .Saturday ⟨2, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Saturday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-04-13" (Meetup.meetup .Saturday ⟨4, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Saturday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-10-19" (Meetup.meetup .Saturday ⟨10, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Sunday is the 19th, the last day of the teenth week" (do
      return assertEqual "2013-05-19" (Meetup.meetup .Sunday ⟨5, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Sunday is some day in the middle of the teenth week" (do
      return assertEqual "2013-06-16" (Meetup.meetup .Sunday ⟨6, by decide⟩ .teenth 2013))
  |>.addTest "when teenth Sunday is the 13th, the first day of the teenth week" (do
      return assertEqual "2013-10-13" (Meetup.meetup .Sunday ⟨10, by decide⟩ .teenth 2013))
  |>.addTest "when first Monday is some day in the middle of the first week" (do
      return assertEqual "2013-03-04" (Meetup.meetup .Monday ⟨3, by decide⟩ .first 2013))
  |>.addTest "when first Monday is the 1st, the first day of the first week" (do
      return assertEqual "2013-04-01" (Meetup.meetup .Monday ⟨4, by decide⟩ .first 2013))
  |>.addTest "when first Tuesday is the 7th, the last day of the first week" (do
      return assertEqual "2013-05-07" (Meetup.meetup .Tuesday ⟨5, by decide⟩ .first 2013))
  |>.addTest "when first Tuesday is some day in the middle of the first week" (do
      return assertEqual "2013-06-04" (Meetup.meetup .Tuesday ⟨6, by decide⟩ .first 2013))
  |>.addTest "when first Wednesday is some day in the middle of the first week" (do
      return assertEqual "2013-07-03" (Meetup.meetup .Wednesday ⟨7, by decide⟩ .first 2013))
  |>.addTest "when first Wednesday is the 7th, the last day of the first week" (do
      return assertEqual "2013-08-07" (Meetup.meetup .Wednesday ⟨8, by decide⟩ .first 2013))
  |>.addTest "when first Thursday is some day in the middle of the first week" (do
      return assertEqual "2013-09-05" (Meetup.meetup .Thursday ⟨9, by decide⟩ .first 2013))
  |>.addTest "when first Thursday is another day in the middle of the first week" (do
      return assertEqual "2013-10-03" (Meetup.meetup .Thursday ⟨10, by decide⟩ .first 2013))
  |>.addTest "when first Friday is the 1st, the first day of the first week" (do
      return assertEqual "2013-11-01" (Meetup.meetup .Friday ⟨11, by decide⟩ .first 2013))
  |>.addTest "when first Friday is some day in the middle of the first week" (do
      return assertEqual "2013-12-06" (Meetup.meetup .Friday ⟨12, by decide⟩ .first 2013))
  |>.addTest "when first Saturday is some day in the middle of the first week" (do
      return assertEqual "2013-01-05" (Meetup.meetup .Saturday ⟨1, by decide⟩ .first 2013))
  |>.addTest "when first Saturday is another day in the middle of the first week" (do
      return assertEqual "2013-02-02" (Meetup.meetup .Saturday ⟨2, by decide⟩ .first 2013))
  |>.addTest "when first Sunday is some day in the middle of the first week" (do
      return assertEqual "2013-03-03" (Meetup.meetup .Sunday ⟨3, by decide⟩ .first 2013))
  |>.addTest "when first Sunday is the 7th, the last day of the first week" (do
      return assertEqual "2013-04-07" (Meetup.meetup .Sunday ⟨4, by decide⟩ .first 2013))
  |>.addTest "when second Monday is some day in the middle of the second week" (do
      return assertEqual "2013-03-11" (Meetup.meetup .Monday ⟨3, by decide⟩ .second 2013))
  |>.addTest "when second Monday is the 8th, the first day of the second week" (do
      return assertEqual "2013-04-08" (Meetup.meetup .Monday ⟨4, by decide⟩ .second 2013))
  |>.addTest "when second Tuesday is the 14th, the last day of the second week" (do
      return assertEqual "2013-05-14" (Meetup.meetup .Tuesday ⟨5, by decide⟩ .second 2013))
  |>.addTest "when second Tuesday is some day in the middle of the second week" (do
      return assertEqual "2013-06-11" (Meetup.meetup .Tuesday ⟨6, by decide⟩ .second 2013))
  |>.addTest "when second Wednesday is some day in the middle of the second week" (do
      return assertEqual "2013-07-10" (Meetup.meetup .Wednesday ⟨7, by decide⟩ .second 2013))
  |>.addTest "when second Wednesday is the 14th, the last day of the second week" (do
      return assertEqual "2013-08-14" (Meetup.meetup .Wednesday ⟨8, by decide⟩ .second 2013))
  |>.addTest "when second Thursday is some day in the middle of the second week" (do
      return assertEqual "2013-09-12" (Meetup.meetup .Thursday ⟨9, by decide⟩ .second 2013))
  |>.addTest "when second Thursday is another day in the middle of the second week" (do
      return assertEqual "2013-10-10" (Meetup.meetup .Thursday ⟨10, by decide⟩ .second 2013))
  |>.addTest "when second Friday is the 8th, the first day of the second week" (do
      return assertEqual "2013-11-08" (Meetup.meetup .Friday ⟨11, by decide⟩ .second 2013))
  |>.addTest "when second Friday is some day in the middle of the second week" (do
      return assertEqual "2013-12-13" (Meetup.meetup .Friday ⟨12, by decide⟩ .second 2013))
  |>.addTest "when second Saturday is some day in the middle of the second week" (do
      return assertEqual "2013-01-12" (Meetup.meetup .Saturday ⟨1, by decide⟩ .second 2013))
  |>.addTest "when second Saturday is another day in the middle of the second week" (do
      return assertEqual "2013-02-09" (Meetup.meetup .Saturday ⟨2, by decide⟩ .second 2013))
  |>.addTest "when second Sunday is some day in the middle of the second week" (do
      return assertEqual "2013-03-10" (Meetup.meetup .Sunday ⟨3, by decide⟩ .second 2013))
  |>.addTest "when second Sunday is the 14th, the last day of the second week" (do
      return assertEqual "2013-04-14" (Meetup.meetup .Sunday ⟨4, by decide⟩ .second 2013))
  |>.addTest "when third Monday is some day in the middle of the third week" (do
      return assertEqual "2013-03-18" (Meetup.meetup .Monday ⟨3, by decide⟩ .third 2013))
  |>.addTest "when third Monday is the 15th, the first day of the third week" (do
      return assertEqual "2013-04-15" (Meetup.meetup .Monday ⟨4, by decide⟩ .third 2013))
  |>.addTest "when third Tuesday is the 21st, the last day of the third week" (do
      return assertEqual "2013-05-21" (Meetup.meetup .Tuesday ⟨5, by decide⟩ .third 2013))
  |>.addTest "when third Tuesday is some day in the middle of the third week" (do
      return assertEqual "2013-06-18" (Meetup.meetup .Tuesday ⟨6, by decide⟩ .third 2013))
  |>.addTest "when third Wednesday is some day in the middle of the third week" (do
      return assertEqual "2013-07-17" (Meetup.meetup .Wednesday ⟨7, by decide⟩ .third 2013))
  |>.addTest "when third Wednesday is the 21st, the last day of the third week" (do
      return assertEqual "2013-08-21" (Meetup.meetup .Wednesday ⟨8, by decide⟩ .third 2013))
  |>.addTest "when third Thursday is some day in the middle of the third week" (do
      return assertEqual "2013-09-19" (Meetup.meetup .Thursday ⟨9, by decide⟩ .third 2013))
  |>.addTest "when third Thursday is another day in the middle of the third week" (do
      return assertEqual "2013-10-17" (Meetup.meetup .Thursday ⟨10, by decide⟩ .third 2013))
  |>.addTest "when third Friday is the 15th, the first day of the third week" (do
      return assertEqual "2013-11-15" (Meetup.meetup .Friday ⟨11, by decide⟩ .third 2013))
  |>.addTest "when third Friday is some day in the middle of the third week" (do
      return assertEqual "2013-12-20" (Meetup.meetup .Friday ⟨12, by decide⟩ .third 2013))
  |>.addTest "when third Saturday is some day in the middle of the third week" (do
      return assertEqual "2013-01-19" (Meetup.meetup .Saturday ⟨1, by decide⟩ .third 2013))
  |>.addTest "when third Saturday is another day in the middle of the third week" (do
      return assertEqual "2013-02-16" (Meetup.meetup .Saturday ⟨2, by decide⟩ .third 2013))
  |>.addTest "when third Sunday is some day in the middle of the third week" (do
      return assertEqual "2013-03-17" (Meetup.meetup .Sunday ⟨3, by decide⟩ .third 2013))
  |>.addTest "when third Sunday is the 21st, the last day of the third week" (do
      return assertEqual "2013-04-21" (Meetup.meetup .Sunday ⟨4, by decide⟩ .third 2013))
  |>.addTest "when fourth Monday is some day in the middle of the fourth week" (do
      return assertEqual "2013-03-25" (Meetup.meetup .Monday ⟨3, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Monday is the 22nd, the first day of the fourth week" (do
      return assertEqual "2013-04-22" (Meetup.meetup .Monday ⟨4, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Tuesday is the 28th, the last day of the fourth week" (do
      return assertEqual "2013-05-28" (Meetup.meetup .Tuesday ⟨5, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Tuesday is some day in the middle of the fourth week" (do
      return assertEqual "2013-06-25" (Meetup.meetup .Tuesday ⟨6, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Wednesday is some day in the middle of the fourth week" (do
      return assertEqual "2013-07-24" (Meetup.meetup .Wednesday ⟨7, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Wednesday is the 28th, the last day of the fourth week" (do
      return assertEqual "2013-08-28" (Meetup.meetup .Wednesday ⟨8, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Thursday is some day in the middle of the fourth week" (do
      return assertEqual "2013-09-26" (Meetup.meetup .Thursday ⟨9, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Thursday is another day in the middle of the fourth week" (do
      return assertEqual "2013-10-24" (Meetup.meetup .Thursday ⟨10, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Friday is the 22nd, the first day of the fourth week" (do
      return assertEqual "2013-11-22" (Meetup.meetup .Friday ⟨11, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Friday is some day in the middle of the fourth week" (do
      return assertEqual "2013-12-27" (Meetup.meetup .Friday ⟨12, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Saturday is some day in the middle of the fourth week" (do
      return assertEqual "2013-01-26" (Meetup.meetup .Saturday ⟨1, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Saturday is another day in the middle of the fourth week" (do
      return assertEqual "2013-02-23" (Meetup.meetup .Saturday ⟨2, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Sunday is some day in the middle of the fourth week" (do
      return assertEqual "2013-03-24" (Meetup.meetup .Sunday ⟨3, by decide⟩ .fourth 2013))
  |>.addTest "when fourth Sunday is the 28th, the last day of the fourth week" (do
      return assertEqual "2013-04-28" (Meetup.meetup .Sunday ⟨4, by decide⟩ .fourth 2013))
  |>.addTest "last Monday in a month with four Mondays" (do
      return assertEqual "2013-03-25" (Meetup.meetup .Monday ⟨3, by decide⟩ .last 2013))
  |>.addTest "last Monday in a month with five Mondays" (do
      return assertEqual "2013-04-29" (Meetup.meetup .Monday ⟨4, by decide⟩ .last 2013))
  |>.addTest "last Tuesday in a month with four Tuesdays" (do
      return assertEqual "2013-05-28" (Meetup.meetup .Tuesday ⟨5, by decide⟩ .last 2013))
  |>.addTest "last Tuesday in another month with four Tuesdays" (do
      return assertEqual "2013-06-25" (Meetup.meetup .Tuesday ⟨6, by decide⟩ .last 2013))
  |>.addTest "last Wednesday in a month with five Wednesdays" (do
      return assertEqual "2013-07-31" (Meetup.meetup .Wednesday ⟨7, by decide⟩ .last 2013))
  |>.addTest "last Wednesday in a month with four Wednesdays" (do
      return assertEqual "2013-08-28" (Meetup.meetup .Wednesday ⟨8, by decide⟩ .last 2013))
  |>.addTest "last Thursday in a month with four Thursdays" (do
      return assertEqual "2013-09-26" (Meetup.meetup .Thursday ⟨9, by decide⟩ .last 2013))
  |>.addTest "last Thursday in a month with five Thursdays" (do
      return assertEqual "2013-10-31" (Meetup.meetup .Thursday ⟨10, by decide⟩ .last 2013))
  |>.addTest "last Friday in a month with five Fridays" (do
      return assertEqual "2013-11-29" (Meetup.meetup .Friday ⟨11, by decide⟩ .last 2013))
  |>.addTest "last Friday in a month with four Fridays" (do
      return assertEqual "2013-12-27" (Meetup.meetup .Friday ⟨12, by decide⟩ .last 2013))
  |>.addTest "last Saturday in a month with four Saturdays" (do
      return assertEqual "2013-01-26" (Meetup.meetup .Saturday ⟨1, by decide⟩ .last 2013))
  |>.addTest "last Saturday in another month with four Saturdays" (do
      return assertEqual "2013-02-23" (Meetup.meetup .Saturday ⟨2, by decide⟩ .last 2013))
  |>.addTest "last Sunday in a month with five Sundays" (do
      return assertEqual "2013-03-31" (Meetup.meetup .Sunday ⟨3, by decide⟩ .last 2013))
  |>.addTest "last Sunday in a month with four Sundays" (do
      return assertEqual "2013-04-28" (Meetup.meetup .Sunday ⟨4, by decide⟩ .last 2013))
  |>.addTest "when last Wednesday in February in a leap year is the 29th" (do
      return assertEqual "2012-02-29" (Meetup.meetup .Wednesday ⟨2, by decide⟩ .last 2012))
  |>.addTest "last Wednesday in December that is also the last day of the year" (do
      return assertEqual "2014-12-31" (Meetup.meetup .Wednesday ⟨12, by decide⟩ .last 2014))
  |>.addTest "when last Sunday in February in a non-leap year is not the 29th" (do
      return assertEqual "2015-02-22" (Meetup.meetup .Sunday ⟨2, by decide⟩ .last 2015))
  |>.addTest "when first Friday is the 7th, the last day of the first week" (do
      return assertEqual "2012-12-07" (Meetup.meetup .Friday ⟨12, by decide⟩ .first 2012))
  |>.addTest "when last Thursday in February in a non-leap year is not the 29th" (do
      return assertEqual "2300-02-22" (Meetup.meetup .Thursday ⟨2, by decide⟩ .last 2300))
  |>.addTest "when fourth Monday is the 23nd, the second day of the fourth week" (do
      return assertEqual "2468-01-23" (Meetup.meetup .Monday ⟨1, by decide⟩ .fourth 2468))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [meetupTests]
