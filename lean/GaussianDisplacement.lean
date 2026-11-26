import GaussianFourier
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds

/-! Positive first-harmonic gain versus the loss of all higher harmonics
for the four-site continuous displacement in Proposition 2. -/

namespace AlternatingChains.Fourier

open Real

private theorem first_mode_gain (s : ℝ) (hs : |s| ≤ 1) :
    4 * s ^ 2 ≤ weight (π * (1-s) / 2) 1 := by
  have h (u : ℝ) (hu : 0 ≤ u) (hu' : u ≤ 1) : u^2 ≤ sin (π/2*u)^2 :=
    pow_le_pow_left₀ hu (le_sin_mul hu hu') 2
  have hsq : s^2 ≤ sin (π/2*s)^2 := by
    rcases le_total 0 s with hp | hn
    · exact h s hp ((le_abs_self s).trans hs)
    · simpa [mul_neg, sin_neg] using h (-s) (neg_nonneg.mpr hn) ((neg_le_abs s).trans hs)
  simp only [weight, Nat.cast_one, one_mul, cos_pi]
  rw [show π * (1-s) / 2 = π/2 - π/2*s by ring, cos_pi_div_two_sub]
  nlinarith

/-- Only modes with cos(mπ/2) = -1 can lose weight. At those modes the
uniform weight is 16 and the perturbed weight is (2+2 cos(mπs/2))². -/
private theorem mode_loss (s : ℝ) (m : ℕ) :
    weight (π/2) m - weight (π*(1-s)/2) m ≤ 8 * ((m : ℝ)*(π/2*s))^2 := by
  let x := (m:ℝ)*(π/2)
  let y := (m:ℝ)*(π/2*s)
  have hd : cos ((m:ℝ)*π) = 2*cos x ^ 2 - 1 := by
    rw [← cos_two_mul, show 2*x = (m:ℝ)*π by dsimp [x]; ring]
  have hxy : (m:ℝ)*(π*(1-s)/2) = x-y := by dsimp [x,y]; ring
  have hu : cos ((m:ℝ)*π) = 1 ∨ cos ((m:ℝ)*π) = -1 := by
    rw [cos_nat_mul_pi]
    exact neg_one_pow_eq_or ℝ m
  change (1 + cos ((m:ℝ)*π) - 2*cos x)^2 -
    (1 + cos ((m:ℝ)*π) - 2*cos ((m:ℝ)*(π*(1-s)/2)))^2 ≤ 8*y^2
  rw [hxy]
  rcases hu with hu | hu
  · have hc : cos x ^ 2 = 1 := by linarith
    have hx := sq_eq_one_iff.mp hc
    rcases hx with hx | hx
    · rw [hu,hx]
      nlinarith only [sq_nonneg (1+1-2*cos (x-y)), sq_nonneg y]
    · have hz : sin x = 0 := by nlinarith [sin_sq_add_cos_sq x, sq_nonneg (sin x)]
      rw [hu, cos_sub, hx, hz]
      nlinarith only [one_sub_sq_div_two_le_cos (x := y), sq_nonneg (1-cos y)]
  · have hx : cos x = 0 := by nlinarith [sq_nonneg (cos x)]
    rw [hu,hx]
    nlinarith only [sq_nonneg (1 + -1 - 2*cos (x-y)), sq_nonneg y]

/-- The weighted second moment from frequency two onwards is dominated
by a geometric series, uniformly down to arbitrarily small displacements. -/
private theorem moment_term_le (q : ℝ) (hq : 0 ≤ q) (hq' : q ≤ 1/4) (n : ℕ) :
    ((n+2:ℕ):ℝ)^2 * q^((n+2)^2) ≤ 4*q^4*(1/2:ℝ)^n := by
  induction n with
  | zero => norm_num
  | succ n ih =>
    let m := n+2
    have hs : ((m+1:ℕ):ℝ)^2 ≤ 4*(m:ℝ)^2 := by
      dsimp [m]; push_cast; nlinarith [sq_nonneg (n:ℝ), Nat.cast_nonneg (α := ℝ) n]
    have he : m^2 + 2 ≤ (m+1)^2 := by dsimp [m]; ring_nf; omega
    have hp := pow_le_pow_of_le_one hq (show q ≤ 1 by linarith) he
    rw [pow_add] at hp
    have hr : 4*q^2 ≤ 1/2 := by
      have := pow_le_pow_left₀ hq hq' 2
      linarith
    change ((m+1:ℕ):ℝ)^2 * q^((m+1)^2) ≤ 4*q^4*(1/2:ℝ)^(n+1)
    calc
      _ ≤ (4*(m:ℝ)^2) * (q^(m^2)*q^2) :=
        mul_le_mul hs hp (pow_nonneg hq _) (by positivity)
      _ = ((m:ℝ)^2*q^(m^2)) * (4*q^2) := by ring
      _ ≤ (4*q^4*(1/2:ℝ)^n) * (1/2) :=
        mul_le_mul ih hr (by positivity) (by positivity)
      _ = _ := by rw [pow_succ]; ring

theorem displacement_mass_strict (s q : ℝ) (hs₀ : 0 < |s|) (hs₁ : |s| < 1)
    (hq₀ : 0 < q) (hq₁ : q ≤ 1/4) :
    fourierMass (π/2) q < fourierMass (π*(1-s)/2) q := by
  let θ := π*(1-s)/2
  let c := 8*(π/2*s)^2
  have hc : 0 ≤ c := by dsimp [c]; positivity
  have hpt (n : ℕ) : tailTerm (π/2) q n - tailTerm θ q n ≤
      (c * (4*q^4)) * (1/2:ℝ)^n := by
    unfold tailTerm
    rw [← sub_mul]
    calc
      _ ≤ (8 * (((n+2:ℕ):ℝ)*(π/2*s))^2) * q^((n+2)^2) :=
        mul_le_mul_of_nonneg_right (mode_loss s (n+2)) (pow_nonneg hq₀.le _)
      _ = c * (((n+2:ℕ):ℝ)^2 * q^((n+2)^2)) := by dsimp [c]; ring
      _ ≤ c * (4*q^4*(1/2:ℝ)^n) := mul_le_mul_of_nonneg_left (moment_term_le q hq₀.le hq₁ n) hc
      _ = _ := by ring
  have hg := hasSum_geometric_two.mul_left (c*(4*q^4))
  have hU := tail_summable (π/2) q hq₀.le hq₁
  have hY := tail_summable θ q hq₀.le hq₁
  have ht := (hU.sub hY).tsum_le_tsum hpt hg.summable
  rw [hU.tsum_sub hY, hg.tsum_eq] at ht
  have hgain := mul_le_mul_of_nonneg_right (first_mode_gain s hs₁.le) hq₀.le
  have hπ : π^2 < 16 := by nlinarith [mul_pos (sub_pos.mpr pi_lt_four) (show 0 < 4+π by positivity)]
  have hq : q^3 ≤ (1/4:ℝ)^3 := pow_le_pow_left₀ hq₀.le hq₁ 3
  have hsmall : 16 * π^2 * q^3 < 4 := by
    have h := mul_le_mul_of_nonneg_left hq (show 0 ≤ 16*π^2 by positivity)
    linarith
  have hs : 0 < s^2*q := mul_pos (sq_pos_of_ne_zero (abs_pos.mp hs₀)) hq₀
  have hstrict := mul_lt_mul_of_pos_right hsmall hs
  change 2 * (weight (π/2) 1 * q + _) < 2 * (weight θ 1 * q + _)
  rw [uniform_first_mode]
  dsimp [c] at ht
  change 4*s^2*q ≤ weight θ 1*q at hgain
  nlinarith only [ht, hgain, hstrict]

end AlternatingChains.Fourier
