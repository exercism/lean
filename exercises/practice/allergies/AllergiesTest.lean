import LeanTest
import Allergies

open LeanTest

def allergiesTests : TestSuite :=
  (TestSuite.empty "Allergies")
    |>.addTest "testing for eggs allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .eggs 0))
    |>.addTest "testing for eggs allergy -> allergic only to eggs" (do
        return assertEqual true (Allergies.allergicTo .eggs 1))
    |>.addTest "testing for eggs allergy -> allergic to eggs and something else" (do
        return assertEqual true (Allergies.allergicTo .eggs 3))
    |>.addTest "testing for eggs allergy -> allergic to something, but not eggs" (do
        return assertEqual false (Allergies.allergicTo .eggs 2))
    |>.addTest "testing for eggs allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .eggs 255))
    |>.addTest "testing for peanuts allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .peanuts 0))
    |>.addTest "testing for peanuts allergy -> allergic only to peanuts" (do
        return assertEqual true (Allergies.allergicTo .peanuts 2))
    |>.addTest "testing for peanuts allergy -> allergic to peanuts and something else" (do
        return assertEqual true (Allergies.allergicTo .peanuts 7))
    |>.addTest "testing for peanuts allergy -> allergic to something, but not peanuts" (do
        return assertEqual false (Allergies.allergicTo .peanuts 5))
    |>.addTest "testing for peanuts allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .peanuts 255))
    |>.addTest "testing for shellfish allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .shellfish 0))
    |>.addTest "testing for shellfish allergy -> allergic only to shellfish" (do
        return assertEqual true (Allergies.allergicTo .shellfish 4))
    |>.addTest "testing for shellfish allergy -> allergic to shellfish and something else" (do
        return assertEqual true (Allergies.allergicTo .shellfish 14))
    |>.addTest "testing for shellfish allergy -> allergic to something, but not shellfish" (do
        return assertEqual false (Allergies.allergicTo .shellfish 10))
    |>.addTest "testing for shellfish allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .shellfish 255))
    |>.addTest "testing for strawberries allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .strawberries 0))
    |>.addTest "testing for strawberries allergy -> allergic only to strawberries" (do
        return assertEqual true (Allergies.allergicTo .strawberries 8))
    |>.addTest "testing for strawberries allergy -> allergic to strawberries and something else" (do
        return assertEqual true (Allergies.allergicTo .strawberries 28))
    |>.addTest "testing for strawberries allergy -> allergic to something, but not strawberries" (do
        return assertEqual false (Allergies.allergicTo .strawberries 20))
    |>.addTest "testing for strawberries allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .strawberries 255))
    |>.addTest "testing for tomatoes allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .tomatoes 0))
    |>.addTest "testing for tomatoes allergy -> allergic only to tomatoes" (do
        return assertEqual true (Allergies.allergicTo .tomatoes 16))
    |>.addTest "testing for tomatoes allergy -> allergic to tomatoes and something else" (do
        return assertEqual true (Allergies.allergicTo .tomatoes 56))
    |>.addTest "testing for tomatoes allergy -> allergic to something, but not tomatoes" (do
        return assertEqual false (Allergies.allergicTo .tomatoes 40))
    |>.addTest "testing for tomatoes allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .tomatoes 255))
    |>.addTest "testing for chocolate allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .chocolate 0))
    |>.addTest "testing for chocolate allergy -> allergic only to chocolate" (do
        return assertEqual true (Allergies.allergicTo .chocolate 32))
    |>.addTest "testing for chocolate allergy -> allergic to chocolate and something else" (do
        return assertEqual true (Allergies.allergicTo .chocolate 112))
    |>.addTest "testing for chocolate allergy -> allergic to something, but not chocolate" (do
        return assertEqual false (Allergies.allergicTo .chocolate 80))
    |>.addTest "testing for chocolate allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .chocolate 255))
    |>.addTest "testing for pollen allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .pollen 0))
    |>.addTest "testing for pollen allergy -> allergic only to pollen" (do
        return assertEqual true (Allergies.allergicTo .pollen 64))
    |>.addTest "testing for pollen allergy -> allergic to pollen and something else" (do
        return assertEqual true (Allergies.allergicTo .pollen 224))
    |>.addTest "testing for pollen allergy -> allergic to something, but not pollen" (do
        return assertEqual false (Allergies.allergicTo .pollen 160))
    |>.addTest "testing for pollen allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .pollen 255))
    |>.addTest "testing for cats allergy -> not allergic to anything" (do
        return assertEqual false (Allergies.allergicTo .cats 0))
    |>.addTest "testing for cats allergy -> allergic only to cats" (do
        return assertEqual true (Allergies.allergicTo .cats 128))
    |>.addTest "testing for cats allergy -> allergic to cats and something else" (do
        return assertEqual true (Allergies.allergicTo .cats 192))
    |>.addTest "testing for cats allergy -> allergic to something, but not cats" (do
        return assertEqual false (Allergies.allergicTo .cats 64))
    |>.addTest "testing for cats allergy -> allergic to everything" (do
        return assertEqual true (Allergies.allergicTo .cats 255))
    |>.addTest "list when: -> no allergies" (do
        return assertEqual [] (Allergies.list 0))
    |>.addTest "list when: -> just eggs" (do
        return assertEqual [.eggs] (Allergies.list 1))
    |>.addTest "list when: -> just peanuts" (do
        return assertEqual [.peanuts] (Allergies.list 2))
    |>.addTest "list when: -> just strawberries" (do
        return assertEqual [.strawberries] (Allergies.list 8))
    |>.addTest "list when: -> eggs and peanuts" (do
        return assertEqual [.eggs, .peanuts] (Allergies.list 3))
    |>.addTest "list when: -> more than eggs but not peanuts" (do
        return assertEqual [.eggs, .shellfish] (Allergies.list 5))
    |>.addTest "list when: -> lots of stuff" (do
        return assertEqual [.strawberries, .tomatoes, .chocolate, .pollen, .cats] (Allergies.list 248))
    |>.addTest "list when: -> everything" (do
        return assertEqual [.eggs, .peanuts, .shellfish, .strawberries, .tomatoes, .chocolate, .pollen, .cats] (Allergies.list 255))
    |>.addTest "list when: -> no allergen score parts" (do
        return assertEqual [.eggs, .shellfish, .strawberries, .tomatoes, .chocolate, .pollen, .cats] (Allergies.list 509))
    |>.addTest "list when: -> no allergen score parts without highest valid score" (do
        return assertEqual [.eggs] (Allergies.list 257))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [allergiesTests]
