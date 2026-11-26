import GaussianDisplacement
import PeriodFourGaussian

namespace AlternatingChains.Fourier

noncomputable section

theorem signedSites_hasSum (t : ℝ) (f : ℝ → ℕ → ℝ) (g : ℝ → ℝ)
    (h : ∀ x, HasSum (f x) (g x)) :
    HasSum (fun n => signedSites t (fun x => f x n)) (signedSites t g) :=
  ((((h (-2)).sub (h (-t))).add (h 0)).sub (h t))

private theorem pairs_hasSum (t : ℝ) :
    HasSum (fun n => cellPairs t (fun d => Poisson.pairTerm d n))
      (cellPairs t (fun d => ∑' n, Poisson.pairTerm d n)) := by
  apply signedSites_hasSum
  intro x
  apply signedSites_hasSum
  intro y
  exact (Poisson.pairTerm_summable (x - y)).hasSum

private theorem pairTerm_weight (t : ℝ) (n : ℕ) :
    cellPairs t (fun d => Poisson.pairTerm d n) =
      weight (Real.pi * t / 2) (n+1) * (Real.exp (-(Real.pi^2 / 4)))^((n+1)^2) := by
  have angle (d : ℝ) : ((n+1 : ℕ) : ℝ) * Real.pi * d / 2 =
      (((n+1 : ℕ) : ℝ) * Real.pi / 2) * d := by ring
  simp_rw [Poisson.pairTerm, angle]
  rw [← cellPairs_cos t (n+1)]
  simp only [cellPairs, signedSites]
  ring

/-- The period-four sum of the real-space Gaussian potential exp(-r²/4). -/
def latticeKernel (d : ℝ) : ℝ := ∑' k : ℤ, Real.exp (-((d + 4*(k:ℝ))^2)/4)

private theorem spatialPairs_eq (t : ℝ) :
    cellPairs t latticeKernel = Real.sqrt Real.pi / 2 *
      fourierMass (Real.pi*t/2) (Real.exp (-(Real.pi^2/4))) := by
  let c := Real.sqrt Real.pi / 2
  have hK : latticeKernel = fun d =>
      c * (1 + 2 * ∑' n : ℕ, Poisson.pairTerm d n) := by
    funext d
    exact Poisson.period_four_gaussian d
  have hsum := (pairs_hasSum t).tsum_eq
  simp_rw [pairTerm_weight] at hsum
  rw [hK, fourierMass_eq_tsum _ _ gaussian_scale.1.le gaussian_scale.2, hsum]
  change cellPairs t (fun d => c * (1 + 2 * ∑' n : ℕ, Poisson.pairTerm d n)) =
    c * (2 * cellPairs t (fun d => ∑' n : ℕ, Poisson.pairTerm d n))
  simp only [cellPairs, signedSites]
  ring

/-- Energy per particle after excluding the four zero-distance self terms.
The signed sites, in cyclic order, are -2, -t, 0, t. Adding 2 gives the
ordinary period representatives 0, 2-t, 2, 2+t. -/
def spatialEnergy (t : ℝ) : ℝ := 1 - cellPairs t latticeKernel / 4

theorem displaced_spatial_energy_lt_uniform : spatialEnergy (1/2) < spatialEnergy 1 := by
  have hm := mass_strict _ gaussian_scale.1 gaussian_scale.2
  have cpos : 0 < Real.sqrt Real.pi / 2 := by positivity
  have hp := mul_lt_mul_of_pos_left hm cpos
  unfold spatialEnergy
  rw [spatialPairs_eq, spatialPairs_eq]
  rw [show Real.pi * (1/2) / 2 = Real.pi / 4 by ring, mul_one]
  linarith only [hp]

/-- Omit the zero-distance term in the central image, leaving every other
periodic image of a particle's own site in the energy. -/
def kernelWithoutSelf (d : ℝ) : ℝ :=
  ∑' k : ℤ, if d = 0 ∧ k = 0 then 0 else Real.exp (-((d + 4*(k:ℝ))^2)/4)

private theorem remove_self (d : ℝ) :
    kernelWithoutSelf d = latticeKernel d - (if d = 0 then 1 else 0) := by
  by_cases hd : d = 0
  · subst d
    simp only [if_true]
    have hs := (Poisson.period_images_summable 0).hasSum.sub (hasSum_ite_eq (0 : ℤ) (1 : ℝ))
    apply HasSum.tsum_eq
    apply hs.congr_fun
    intro k
    by_cases hk : k = 0
    · subst k
      norm_num
    · simp [hk]
  · simp [kernelWithoutSelf, latticeKernel, hd]

/-- Signed energy with the particle self term excluded inside the infinite sum. -/
def particleEnergy (t : ℝ) : ℝ := -(cellPairs t kernelWithoutSelf) / 4

private theorem particleEnergy_eq_spatial (t : ℝ)
    (hdiag : cellPairs t (fun d => if d = 0 then 1 else 0) = 4) :
    particleEnergy t = spatialEnergy t := by
  have hr : kernelWithoutSelf = fun d => latticeKernel d - (if d = 0 then 1 else 0) :=
    funext remove_self
  have hlin (K H : ℝ → ℝ) :
      cellPairs t (fun d => K d - H d) = cellPairs t K - cellPairs t H := by
    simp only [cellPairs, signedSites]
    ring
  unfold particleEnergy spatialEnergy
  rw [hr, hlin, hdiag]
  ring

theorem four_site_gaussian_counterexample : particleEnergy (1/2) < particleEnergy 1 := by
  rw [particleEnergy_eq_spatial (1/2) (by norm_num [cellPairs, signedSites]),
      particleEnergy_eq_spatial 1 (by norm_num [cellPairs, signedSites])]
  exact displaced_spatial_energy_lt_uniform

/-- The four alternating charges at the literal coordinates 0, b, 2, d used
in the statement of the paper. -/
def signedCell (b d : ℝ) (f : ℝ → ℝ) : ℝ := f 0 - f b + f 2 - f d

def cellEnergy (b d : ℝ) : ℝ :=
  -(signedCell b d (fun x => signedCell b d (fun y => kernelWithoutSelf (x-y)))) / 4

theorem four_site_gaussian_in_original_coordinates :
    cellEnergy (3/2) (5/2) < cellEnergy 1 3 := by
  convert four_site_gaussian_counterexample using 1 <;>
    norm_num [particleEnergy, cellPairs, signedSites, cellEnergy, signedCell]

/-- The four gaps, including the wraparound gap to the next period, are positive. -/
theorem displacement_ordered (s : ℝ) (hs : |s| < 1) :
    0 < 1+s ∧ 1+s < 2 ∧ 2 < 3-s ∧ 3-s < 4 := by
  obtain ⟨hl, hr⟩ := abs_lt.mp hs
  exact ⟨by linarith, by linarith, by linarith, by linarith⟩

/-- Translating both endpoints of every pair by two preserves all differences. -/
theorem signedCell_displacement_pairs (s : ℝ) (K : ℝ → ℝ) :
    signedCell (1+s) (3-s) (fun x => signedCell (1+s) (3-s) (fun y => K (x-y))) =
      cellPairs (1-s) K := by
  simp only [signedCell, cellPairs, signedSites]
  ring_nf

theorem displacement_diagonal (s : ℝ) (hs : |s| < 1) :
    cellPairs (1-s) (fun d => if d = 0 then (1:ℝ) else 0) = 4 := by
  obtain ⟨hl, hr⟩ := abs_lt.mp hs
  simp [cellPairs, signedSites, sub_eq_zero, show s ≠ 1 by linarith]
  split_ifs <;> linarith

/-- Proposition 2 at a = 1/4, in the original infinite-sum energy and coordinates. -/
theorem displacement_fixed_energy_lt (s : ℝ) (hs₀ : 0 < |s|) (hs₁ : |s| < 1) :
    cellEnergy (1+s) (3-s) < cellEnergy 1 3 := by
  have bridge (u : ℝ) (hu : |u| < 1) :
      cellEnergy (1+u) (3-u) = spatialEnergy (1-u) := by
    unfold cellEnergy
    rw [signedCell_displacement_pairs]
    exact particleEnergy_eq_spatial _ (displacement_diagonal u hu)
  rw [bridge s hs₁, show cellEnergy 1 3 = spatialEnergy 1 by
    simpa using bridge 0 (by norm_num)]
  unfold spatialEnergy
  rw [spatialPairs_eq, spatialPairs_eq, mul_one]
  have h := displacement_mass_strict s _ hs₀ hs₁ gaussian_scale.1 gaussian_scale.2
  linarith only [mul_lt_mul_of_pos_left h (show 0 < Real.sqrt Real.pi / 2 by positivity)]

#print axioms displacement_fixed_energy_lt

end

end AlternatingChains.Fourier
