import LeanTest
import KindergartenGarden

open LeanTest

def kindergartenGardenTests : TestSuite :=
  (TestSuite.empty "KindergartenGarden")
  |>.addTest "partial garden -> garden with single student" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.grass], by decide⟩ (KindergartenGarden.plants "RC\nGG" "Alice"))
  |>.addTest "partial garden -> different garden with single student" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VC\nRC" "Alice"))
  |>.addTest "partial garden -> garden with two students" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VVCG\nVVRC" "Bob"))
  |>.addTest "partial garden -> multiple students for the same garden with three students -> second student's garden" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.clover, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VVCCGG\nVVCCGG" "Bob"))
  |>.addTest "partial garden -> multiple students for the same garden with three students -> third student's garden" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.grass, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.grass], by decide⟩ (KindergartenGarden.plants "VVCCGG\nVVCCGG" "Charlie"))
  |>.addTest "full garden -> for Alice, first student's garden" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.violets, KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.radishes], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Alice"))
  |>.addTest "full garden -> for Bob, second student's garden" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Bob"))
  |>.addTest "full garden -> for Charlie" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.violets, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Charlie"))
  |>.addTest "full garden -> for David" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.radishes], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "David"))
  |>.addTest "full garden -> for Eve" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.grass], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Eve"))
  |>.addTest "full garden -> for Fred" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.grass, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Fred"))
  |>.addTest "full garden -> for Ginny" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.grass, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Ginny"))
  |>.addTest "full garden -> for Harriet" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.violets, KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.radishes, KindergartenGarden.Plant.violets], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Harriet"))
  |>.addTest "full garden -> for Ileana" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.grass, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Ileana"))
  |>.addTest "full garden -> for Joseph" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.grass], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Joseph"))
  |>.addTest "full garden -> for Kincaid, second to last student's garden" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.grass, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.grass], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Kincaid"))
  |>.addTest "full garden -> for Larry, last student's garden" (do
      return assertEqual ⟨#[KindergartenGarden.Plant.grass, KindergartenGarden.Plant.violets, KindergartenGarden.Plant.clover, KindergartenGarden.Plant.violets], by decide⟩ (KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" "Larry"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [kindergartenGardenTests]
