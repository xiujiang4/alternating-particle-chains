import FourPointCounterexample

/-! Proposition 2 for the period-four Gaussian exp(-a r²), with a variable
positive scale. All period images remain in the site-by-site energy. -/

namespace AlternatingChains.Fourier

open Real
noncomputable section

def gaussianNome (a : ℝ) : ℝ := exp (-(π^2 / (16*a)))

private def imageTerm (a d : ℝ) (k : ℤ) : ℝ := exp (-a*(d + 4*(k:ℝ))^2)

private def cosineTerm (a d : ℝ) (n : ℕ) : ℝ :=
  cos (((n+1:ℕ):ℝ)*π*d/2) * (gaussianNome a)^((n+1)^2)

private theorem image_hasSum (a d : ℝ) (ha : 0 < a) :
    HasSum (imageTerm a d) (HurwitzZeta.evenKernel (d/4 : ℝ) (16*a/π)) := by
  apply (HurwitzZeta.hasSum_int_evenKernel (d/4) (show 0 < 16*a/π by positivity)).congr_fun
  intro k
  unfold imageTerm
  congr 1
  field_simp
  ring

private theorem cosine_hasSum (a d : ℝ) (ha : 0 < a) :
    HasSum (cosineTerm a d) ((1/2:ℝ) *
      (HurwitzZeta.cosKernel (d/4 : ℝ) (1/(16*a/π)) - 1)) := by
  apply ((HurwitzZeta.hasSum_nat_cosKernel₀ (d/4)
    (show 0 < 1/(16*a/π) by positivity)).mul_left (1/2:ℝ)).congr_fun
  intro n
  unfold cosineTerm gaussianNome
  rw [← exp_nat_mul]
  push_cast
  rw [show -π * ((n:ℝ)+1)^2 * (1/(16*a/π)) = ((n:ℝ)+1)^2 * -(π^2/(16*a)) by
    field_simp]
  ring_nf

/-- The original period-four image series is summable at every pair displacement. -/
theorem gaussian_images_summable (a d : ℝ) (ha : 0 < a) :
    Summable (fun k : ℤ => exp (-a*(d + 4*(k:ℝ))^2)) :=
  (image_hasSum a d ha).summable

/-- Summability also holds for the literal sum with the central self term removed. -/
theorem gaussian_images_without_self_hasSum (a d : ℝ) (ha : 0 < a) :
    HasSum (fun k : ℤ => if d = 0 ∧ k = 0 then 0 else exp (-a*(d + 4*(k:ℝ))^2))
      ((∑' k : ℤ, exp (-a*(d + 4*(k:ℝ))^2)) - if d = 0 then 1 else 0) := by
  change HasSum _ ((∑' k : ℤ, imageTerm a d k) - _)
  have h := (image_hasSum a d ha).summable.hasSum
  by_cases hd : d = 0
  · subst d
    rw [if_pos rfl]
    apply (h.sub (hasSum_ite_eq (0:ℤ) (1:ℝ))).congr_fun
    intro k
    by_cases hk : k = 0
    · simp [hk, imageTerm]
    · simp [hk, imageTerm]
  · simp only [hd, false_and, if_false, sub_zero]
    exact h

/-- Per-particle directed energy for the literal sites (0,b,2,d).
For ordered distinct sites, x=y means that the two labels coincide. -/
def cellEnergyAt (a b d : ℝ) : ℝ :=
  -(signedCell b d (fun x => signedCell b d (fun y =>
    ∑' k : ℤ, if x-y = 0 ∧ k = 0 then 0 else exp (-a*(x-y + 4*(k:ℝ))^2)))) / 4

/-- The variable-scale energy agrees exactly with the repository's fixed energy. -/
theorem cellEnergyAt_quarter (b d : ℝ) : cellEnergyAt (1/4) b d = cellEnergy b d := by
  simp only [cellEnergyAt, cellEnergy, kernelWithoutSelf]
  ring_nf

private theorem scaled_pairs_eq (a t : ℝ) (ha : 0 < a) (hq : gaussianNome a ≤ 1/4) :
    cellPairs t (fun d => ∑' k, imageTerm a d k) =
      (1/(16*a/π)^(1/2:ℝ)) * fourierMass (π*t/2) (gaussianNome a) := by
  let c := 1/(16*a/π)^(1/2:ℝ)
  have hK (d : ℝ) : (∑' k, imageTerm a d k) =
      c * (1 + 2 * ∑' n, cosineTerm a d n) := by
    rw [(image_hasSum a d ha).tsum_eq, HurwitzZeta.evenKernel_functional_equation,
      (cosine_hasSum a d ha).tsum_eq]
    dsimp [c]
    ring
  have hsum : HasSum (fun n => cellPairs t (fun d => cosineTerm a d n))
      (cellPairs t (fun d => ∑' n, cosineTerm a d n)) := by
    apply signedSites_hasSum
    intro x
    apply signedSites_hasSum
    intro y
    exact (cosine_hasSum a (x-y) ha).summable.hasSum
  have hm (n : ℕ) : cellPairs t (fun d => cosineTerm a d n) =
      weight (π*t/2) (n+1) * (gaussianNome a)^((n+1)^2) := by
    simp_rw [cosineTerm, show ∀ d : ℝ, ((n+1:ℕ):ℝ)*π*d/2 = (((n+1:ℕ):ℝ)*π/2)*d
      from fun _ => by ring]
    rw [← cellPairs_cos t (n+1)]
    simp only [cellPairs, signedSites]
    ring
  have hmass := hsum.tsum_eq
  simp_rw [hm] at hmass
  simp_rw [hK]
  rw [fourierMass_eq_tsum _ (gaussianNome a) (exp_pos _).le hq, hmass]
  change cellPairs t _ = c * (2 * cellPairs t _)
  simp only [cellPairs, signedSites]
  ring

private theorem displacement_energy_formula (a s : ℝ) (ha : 0 < a)
    (hq : gaussianNome a ≤ 1/4) (hs : |s| < 1) :
    cellEnergyAt a (1+s) (3-s) =
      1 - (1/(16*a/π)^(1/2:ℝ)) * fourierMass (π*(1-s)/2) (gaussianNome a) / 4 := by
  unfold cellEnergyAt
  simp_rw [(gaussian_images_without_self_hasSum a _ ha).tsum_eq]
  rw [signedCell_displacement_pairs s (fun d =>
    (∑' k : ℤ, exp (-a*(d + 4*(k:ℝ))^2)) - if d = 0 then 1 else 0)]
  change -(cellPairs (1-s) (fun d => (∑' k, imageTerm a d k) - if d = 0 then 1 else 0)) / 4 = _
  have hlin (K H : ℝ → ℝ) : cellPairs (1-s) (fun d => K d - H d) =
      cellPairs (1-s) K - cellPairs (1-s) H := by simp only [cellPairs, signedSites]; ring
  rw [hlin (fun d => ∑' k, imageTerm a d k) (fun d => if d = 0 then 1 else 0),
    displacement_diagonal s hs, scaled_pairs_eq a (1-s) ha hq]
  ring

/-- Proposition 2: for any positive Gaussian scale in the stated nome range,
every nonzero allowed displacement strictly lowers the full ordered-pair energy. -/
theorem displacement_energy_lt (a s : ℝ) (ha : 0 < a) (hq : gaussianNome a ≤ 1/4)
    (hs₀ : 0 < |s|) (hs₁ : |s| < 1) :
    cellEnergyAt a (1+s) (3-s) < cellEnergyAt a 1 3 := by
  have hu := displacement_energy_formula a 0 ha hq (by norm_num)
  simp only [add_zero, sub_zero, mul_one] at hu
  rw [displacement_energy_formula a s ha hq hs₁, hu]
  have hm := displacement_mass_strict s (gaussianNome a) hs₀ hs₁ (exp_pos _) hq
  have hc : 0 < 1/(16*a/π)^(1/2:ℝ) := by positivity
  linarith only [mul_lt_mul_of_pos_left hm hc]

/-- Every nome in (0,1/4] occurs: the inverse parametrization gives a positive
Gaussian scale and the strict comparison at the literal four sites. -/
theorem displacement_energy_lt_of_nome (q s : ℝ) (hq₀ : 0 < q) (hq₁ : q ≤ 1/4)
    (hs₀ : 0 < |s|) (hs₁ : |s| < 1) :
    let a := -(π^2)/(16*log q)
    0 < a ∧ gaussianNome a = q ∧ cellEnergyAt a (1+s) (3-s) < cellEnergyAt a 1 3 := by
  let a := -(π^2)/(16*log q)
  have hl := log_neg hq₀ (show q < 1 by linarith)
  have ha : 0 < a := div_pos_of_neg_of_neg (neg_lt_zero.mpr (by positivity)) (by linarith)
  have hn : gaussianNome a = q := by
    unfold gaussianNome a
    rw [show -(π^2/(16*(-(π^2)/(16*log q)))) = log q by
      field_simp [hl.ne, pi_ne_zero]]
    exact exp_log hq₀
  exact ⟨ha, hn, displacement_energy_lt a s ha (hn ▸ hq₁) hs₀ hs₁⟩

#print axioms displacement_energy_lt
#print axioms displacement_energy_lt_of_nome

end
end AlternatingChains.Fourier
