import GaussianClass
import GaussianMargin
import GaussianDisplacementEnergy

/-! The Gaussian satisfies the squared-distance hypothesis and an explicit
admissible period-four cell improves on the equally spaced cell. -/

namespace AlternatingParticleChains

open AlternatingGaussian.PhysicalCell
open AlternatingChains.Fourier

/-- Gaussian admissibility and strict energy comparison in the paper's
coordinates. In `cellEnergy b d` the four ordered positions are 0, b, 2, d. -/
theorem admissible_gaussian_counterexample :
    (∃ F : ℝ → ℝ, (∀ r : ℝ, Real.exp (-(r ^ 2) / 4) = F (r ^ 2)) ∧
      ∀ (n : ℕ) (s : ℝ), 0 ≤ s → 0 < (-1 : ℝ)^n * iteratedDeriv n F s) ∧
    cellEnergy (3/2) (5/2) < cellEnergy 1 3 :=
  ⟨gaussian_has_admissible_profile, four_site_gaussian_in_original_coordinates⟩

/-- A second, real-space proof controls the complete infinite sum quantitatively.
Both cells obey the ordering and anchoring requirements. -/
theorem admissible_cells_and_energy_gap :
    (ordered uniform ∧ uniform 0 = 0) ∧
    (ordered shifted ∧ shifted 0 = 0) ∧
    (1/36 : ℝ) < gaussianEnergy uniform - gaussianEnergy shifted :=
  ⟨uniform_admissible, shifted_admissible, gaussian_energy_gap⟩

#print axioms admissible_gaussian_counterexample
#print axioms admissible_cells_and_energy_gap

end AlternatingParticleChains
