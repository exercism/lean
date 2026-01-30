namespace RationalNumbers

/--
  Represents a fully reduced rational number.
  It is constructed from a numerator (`num`) and a denominator (`den`), both of type `Int`, and a proof that: `den > 0 ∧ Int.gcd num den = 1`.
-/
structure RationalNumber where
  num : Int
  den : Int
  h : den > 0 ∧ Int.gcd num den = 1  -- ∧ is logical And, which is a type formed of two Prop: `.left` (or `.1`) and `.right` (or `.2`)
  deriving BEq, Repr

-- @[tactic] feeds a theorem to a tactic, so it can be used by the tactic, possibly combined with other preexistent theorems
-- this makes proving new propositions that depend on previous ones much easier and sometimes automatic

@[simp] theorem mul_pos_pos (x y : Int) (xPos: 0 < x) (yPos: 0 < y) : 0 < x * y := Int.mul_pos xPos yPos
@[simp] theorem pos_div_gcd_gt_zero (a b : Int) (h: b > 0) : 0 < b / ↑(Int.gcd a b) := by -- ↑ is used to coerce one type to another. In this case, Int.gcd a b (Nat) is being coerced to Int
  have b_div_gcd: ↑(Int.gcd a b) ∣ b := by -- a ∣ b means "a divides b", i.e., b % a == 0
    exact Int.gcd_dvd_right a b
  exact Int.ediv_pos_of_pos_of_dvd h (by simp) b_div_gcd

@[simp] theorem RationalNumber.gcd_num_den_eq_one (r : RationalNumber) : Int.gcd r.num r.den = 1 := r.h.2
@[simp] theorem RationalNumber.den_pos (r : RationalNumber): r.den > 0 := r.h.1
@[simp] theorem RationalNumber.mul_b1_b2_gt_zero (r1 r2 : RationalNumber) : r1.den * r2.den > 0 := by simp -- r1.den > 0 and r2.den > 0 (by property of RationalNumber); by mul_pos_pos (defined above), r1.den * r2.den > 0
@[simp] theorem RationalNumber.den_div_gcd_gt_zero (r : RationalNumber) : 0 < r.den / Int.gcd r.num r.den := by simp -- consequence of pos_div_gcd_gt_zero (defined above)

def reduceHelper (a : Int) (b : Int) (bpos : b > 0) : RationalNumber :=
  let gcd_ab := Int.gcd a b
  if gcd_one: gcd_ab = 1
  then ⟨a, b, ⟨bpos, gcd_one⟩⟩ -- ⟨bpos, gcd_one⟩ constructs an And with two Prop: b > 0 ∧ gcdAB = 1
  else
    let newA := a / gcd_ab
    let newB := b / gcd_ab
    have gcd_newA_newB_one: Int.gcd newA newB = 1 := by
      exact Int.gcd_ediv_gcd_ediv_gcd_of_ne_zero_right (by omega) -- a b ≠ 0 -> Int.gcd (a / Int.gcd a b) (b / Int.gcd a b) = 1. Omega knows that b > 0 -> b ≠ 0.
    have newB_pos: newB > 0 := by
      exact pos_div_gcd_gt_zero a b bpos
    ⟨newA, newB, ⟨newB_pos, gcd_newA_newB_one⟩⟩

def add (r1 r2 : RationalNumber) : RationalNumber :=
  let den := r1.den * r2.den
  let num := r2.den * r1.num + r1.den * r2.num
  reduceHelper num den (RationalNumber.mul_b1_b2_gt_zero r1 r2)

def sub (r1 r2 : RationalNumber) : RationalNumber :=
  let r3 := { r2 with num := -r2.num, h := by simp }
  add r1 r3

def mul (r1 r2 : RationalNumber) : RationalNumber :=
  reduceHelper (r1.num * r2.num) (r1.den * r2.den) (RationalNumber.mul_b1_b2_gt_zero r1 r2)

def div (r1 r2 : RationalNumber) : RationalNumber :=
  if num_zero: r2.num = 0
  then ⟨0, 1, by decide⟩ -- follows the convention of the language: n / 0 = 0
  else
    if num_pos: r2.num > 0 then
      have prod_pos: r1.den * r2.num > 0 := by simp [r1.h, num_pos] -- simp knows about mul_pos_pos, so it can feed r1.h and num_pos to reach the conclusion
      reduceHelper (r1.num * r2.den) (r1.den * r2.num) prod_pos
    else
      have num_neg: r2.num < 0 := by omega
      have prod_pos: r1.den * (-r2.num) > 0 := by simp [r1.h, by omega] -- simp knows about mul_pos_pos, so it can feed r1.h. (-r2.num > 0) can be concluded from num_neg by omega
      reduceHelper (-(r1.num * r2.den)) (r1.den * (-r2.num)) prod_pos

def abs (r : RationalNumber) : RationalNumber :=
  if r.num < 0 then { r with num := -r.num, h := by simp } -- simp knows that Int.gcd a b = Int.gcd (-a) b
  else r

def exprational (r : RationalNumber) (n : Int) : RationalNumber :=
  if a_zero: r.num = 0
  then ⟨0, 1, by decide⟩
  else
    if n_non_neg: n >= 0
    then
      let num := r.num ^ n.toNat
      let den := r.den ^ n.toNat
      have den_pos : den > 0 := by
        exact Int.pow_pos r.h.left -- n > 0 -> n ^ m > 0
      reduceHelper num den den_pos
    else
      let exponent := (-n).toNat
      let num := r.den ^ exponent
      let den := r.num ^ exponent
      if neg_den: den < 0
      then
        reduceHelper (-num) (-den) (by simp [neg_den]) -- neg_den states that den < 0, so simp knows that (-den) > 0
      else
        have den_pos: den > 0 := by
          have h: den ≠ 0 := by
            exact Int.pow_ne_zero (by simpa) -- n ≠ 0 -> n ^ m ≠ 0. Simpa concludes that r1.den > 0 -> r1.den ≠ 0
          omega -- we are in the else of neg_den, so den >= 0. By h just above, den ≠ 0. So omega concludes that den > 0
        reduceHelper num den den_pos

def expreal (x : Int) (r : RationalNumber) : Float :=
  let n : Float := Float.ofInt r.num / Float.ofInt r.den
  (Float.ofInt x) ^ n

end RationalNumbers
