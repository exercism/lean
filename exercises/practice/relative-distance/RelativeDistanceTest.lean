import LeanTest
import RelativeDistance

open LeanTest

def relativeDistanceTests : TestSuite :=
  (TestSuite.empty "RelativeDistance")
  |>.addTest "Direct parent-child relation" (do
      return assertEqual (some 1) (RelativeDistance.degreeOfSeparation [
        ("Tomoko", ["Aditi"]),
        ("Vera", ["Tomoko"])
      ] "Vera" "Tomoko"))
  |>.addTest "Sibling relationship" (do
      return assertEqual (some 1) (RelativeDistance.degreeOfSeparation [
        ("Dalia", ["Olga", "Yassin"])
      ] "Olga" "Yassin"))
  |>.addTest "Two degrees of separation, grandchild" (do
      return assertEqual (some 2) (RelativeDistance.degreeOfSeparation [
        ("Khadija", ["Mateo"]),
        ("Mateo", ["Rami"])
      ] "Khadija" "Rami"))
  |>.addTest "Unrelated individuals" (do
      return assertEqual none (RelativeDistance.degreeOfSeparation [
        ("Kaito", ["Elif"]),
        ("Priya", ["Rami"])
      ] "Priya" "Kaito"))
  |>.addTest "Complex graph, cousins" (do
      return assertEqual (some 9) (RelativeDistance.degreeOfSeparation [
        ("Aditi", ["Nia"]),
        ("Aiko", ["Bao", "Carlos"]),
        ("Bao", ["Dalia", "Elias"]),
        ("Boris", ["Oscar"]),
        ("Carlos", ["Fatima", "Gustavo"]),
        ("Celine", ["Priya"]),
        ("Dalia", ["Hassan", "Isla"]),
        ("Diego", ["Qi"]),
        ("Elias", ["Javier"]),
        ("Elif", ["Rami"]),
        ("Farah", ["Sven"]),
        ("Fatima", ["Khadija", "Liam"]),
        ("Giorgio", ["Tomoko"]),
        ("Gustavo", ["Mina"]),
        ("Hana", ["Umar"]),
        ("Hassan", ["Noah", "Olga"]),
        ("Ian", ["Vera"]),
        ("Isla", ["Pedro"]),
        ("Javier", ["Quynh", "Ravi"]),
        ("Jing", ["Wyatt"]),
        ("Kaito", ["Xia"]),
        ("Khadija", ["Sofia"]),
        ("Leila", ["Yassin"]),
        ("Liam", ["Tariq", "Uma"]),
        ("Mateo", ["Zara"]),
        ("Mina", ["Viktor", "Wang"]),
        ("Nia", ["Antonio"]),
        ("Noah", ["Xiomara"]),
        ("Olga", ["Yuki"]),
        ("Oscar", ["Bianca"]),
        ("Pedro", ["Zane", "Aditi"]),
        ("Priya", ["Cai"]),
        ("Qi", ["Dimitri"]),
        ("Quynh", ["Boris"]),
        ("Rami", ["Ewa"]),
        ("Ravi", ["Celine"]),
        ("Sofia", ["Diego", "Elif"]),
        ("Sven", ["Fabio"]),
        ("Tariq", ["Farah"]),
        ("Tomoko", ["Gabriela"]),
        ("Uma", ["Giorgio"]),
        ("Umar", ["Helena"]),
        ("Vera", ["Igor"]),
        ("Viktor", ["Hana", "Ian"]),
        ("Wang", ["Jing"]),
        ("Wyatt", ["Jun"]),
        ("Xia", ["Kim"]),
        ("Xiomara", ["Kaito"]),
        ("Yassin", ["Lucia"]),
        ("Yuki", ["Leila"]),
        ("Zane", ["Mateo"]),
        ("Zara", ["Mohammed"])
      ] "Dimitri" "Fabio"))
  |>.addTest "Complex graph, no shortcut, far removed nephew" (do
      return assertEqual (some 14) (RelativeDistance.degreeOfSeparation [
        ("Aditi", ["Nia"]),
        ("Aiko", ["Bao", "Carlos"]),
        ("Bao", ["Dalia", "Elias"]),
        ("Boris", ["Oscar"]),
        ("Carlos", ["Fatima", "Gustavo"]),
        ("Celine", ["Priya"]),
        ("Dalia", ["Hassan", "Isla"]),
        ("Diego", ["Qi"]),
        ("Elias", ["Javier"]),
        ("Elif", ["Rami"]),
        ("Farah", ["Sven"]),
        ("Fatima", ["Khadija", "Liam"]),
        ("Giorgio", ["Tomoko"]),
        ("Gustavo", ["Mina"]),
        ("Hana", ["Umar"]),
        ("Hassan", ["Noah", "Olga"]),
        ("Ian", ["Vera"]),
        ("Isla", ["Pedro"]),
        ("Javier", ["Quynh", "Ravi"]),
        ("Jing", ["Wyatt"]),
        ("Kaito", ["Xia"]),
        ("Khadija", ["Sofia"]),
        ("Leila", ["Yassin"]),
        ("Liam", ["Tariq", "Uma"]),
        ("Mateo", ["Zara"]),
        ("Mina", ["Viktor", "Wang"]),
        ("Nia", ["Antonio"]),
        ("Noah", ["Xiomara"]),
        ("Olga", ["Yuki"]),
        ("Oscar", ["Bianca"]),
        ("Pedro", ["Zane", "Aditi"]),
        ("Priya", ["Cai"]),
        ("Qi", ["Dimitri"]),
        ("Quynh", ["Boris"]),
        ("Rami", ["Ewa"]),
        ("Ravi", ["Celine"]),
        ("Sofia", ["Diego", "Elif"]),
        ("Sven", ["Fabio"]),
        ("Tariq", ["Farah"]),
        ("Tomoko", ["Gabriela"]),
        ("Uma", ["Giorgio"]),
        ("Umar", ["Helena"]),
        ("Vera", ["Igor"]),
        ("Viktor", ["Hana", "Ian"]),
        ("Wang", ["Jing"]),
        ("Wyatt", ["Jun"]),
        ("Xia", ["Kim"]),
        ("Xiomara", ["Kaito"]),
        ("Yassin", ["Lucia"]),
        ("Yuki", ["Leila"]),
        ("Zane", ["Mateo"]),
        ("Zara", ["Mohammed"])
      ] "Lucia" "Jun"))
  |>.addTest "Complex graph, some shortcuts, cross-down and cross-up, cousins several times removed, with unrelated family tree" (do
      return assertEqual (some 12) (RelativeDistance.degreeOfSeparation [
        ("Aditi", ["Nia"]),
        ("Aiko", ["Bao", "Carlos"]),
        ("Bao", ["Dalia"]),
        ("Boris", ["Oscar"]),
        ("Carlos", ["Fatima", "Gustavo"]),
        ("Celine", ["Priya"]),
        ("Dalia", ["Hassan", "Isla"]),
        ("Diego", ["Qi"]),
        ("Elif", ["Rami"]),
        ("Farah", ["Sven"]),
        ("Fatima", ["Khadija", "Liam"]),
        ("Giorgio", ["Tomoko"]),
        ("Gustavo", ["Mina"]),
        ("Hana", ["Umar"]),
        ("Hassan", ["Noah", "Olga"]),
        ("Ian", ["Vera"]),
        ("Isla", ["Pedro"]),
        ("Javier", ["Quynh", "Ravi"]),
        ("Jing", ["Wyatt"]),
        ("Kaito", ["Xia"]),
        ("Khadija", ["Sofia"]),
        ("Leila", ["Yassin"]),
        ("Liam", ["Tariq", "Uma"]),
        ("Mateo", ["Zara"]),
        ("Mina", ["Viktor", "Wang"]),
        ("Nia", ["Antonio"]),
        ("Noah", ["Xiomara"]),
        ("Olga", ["Yuki"]),
        ("Oscar", ["Bianca"]),
        ("Pedro", ["Zane", "Aditi"]),
        ("Priya", ["Cai"]),
        ("Qi", ["Dimitri"]),
        ("Quynh", ["Boris"]),
        ("Rami", ["Ewa"]),
        ("Ravi", ["Celine"]),
        ("Sofia", ["Diego", "Elif"]),
        ("Sven", ["Fabio"]),
        ("Tariq", ["Farah"]),
        ("Tomoko", ["Gabriela"]),
        ("Uma", ["Giorgio"]),
        ("Umar", ["Helena"]),
        ("Vera", ["Igor"]),
        ("Viktor", ["Hana", "Ian"]),
        ("Wang", ["Jing"]),
        ("Wyatt", ["Jun"]),
        ("Xia", ["Kim"]),
        ("Xiomara", ["Kaito"]),
        ("Yassin", ["Lucia"]),
        ("Yuki", ["Leila"]),
        ("Zane", ["Mateo"]),
        ("Zara", ["Mohammed"])
      ] "Wyatt" "Xia"))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [relativeDistanceTests]
