# Note: BKN's high-density necessary condition (Prop. 2.9) is identically degenerate for ℱ = (−f, −f, f)

Bétermin, Knüpfer and Nolte’s high-density necessary condition is satisfied with equality for the Gaussian counterexample. The same cancellation applies throughout the sign class wherever the proposition’s hypotheses hold.

## What BKN state

Proposition 2.9 applies to even pair potentials in $C^2(\mathbb R)\cap L^1(\mathbb R)$ satisfying $|f_{\alpha\beta}(x)|<C|x|^{-1-\eta}$ for $|x|>r_0$, with $C,r_0,\eta>0$. If equal spacing minimizes the energy at sufficiently high density, the following Fourier expression is nonnegative at every real wave number.

$$
\widehat f_{12}(k)+\tfrac12\bigl(\widehat f_{11}(k)+\widehat f_{22}(k)\bigr)\ge0.
$$

The authors use the cosine transform $\widehat f(k)=(2\pi)^{-1/2}\int_{\mathbb R} f(x)\cos(kx)\,dx$. [Journal article, §2](https://doi.org/10.1007/s10955-020-02603-2)

## The check

Conjecture 2.7 fixes the sign pattern ℱ = (−f, −f, f), i.e. (f₁₁, f₂₂, f₁₂) = (−f, −f, f). Substituting:

  f̂₁₂(k) + ½ ( f̂₁₁(k) + f̂₂₂(k) ) = f̂(k) + ½ ( −f̂(k) − f̂(k) ) = 0.

Linearity gives zero for every integrable $f$ with this sign pattern. For the Gaussian all the hypotheses of Proposition 2.9 hold, so the necessary condition is satisfied with equality. It cannot distinguish the four-site competitor from the equally spaced chain.

Some potentials in Conjecture 2.7 lie outside Proposition 2.9. For example, $f(r)=r^{-2}$ has the completely monotone squared-distance profile $F(s)=s^{-1}$ for $s>0$. Its even extension is singular at zero and has no ordinary $L^1$ Fourier transform.

## Checks performed

- **Reference.** The high-density condition is Proposition 2.9 in both the [journal version](https://doi.org/10.1007/s10955-020-02603-2) and [arXiv v3](https://arxiv.org/abs/1804.05743v3).
- **Numbers.** `code/verify_chains.py` re-derived independently (no Python on the checking machine, so
  a small Node script was used): equidistant energy per particle 0.999633292158, four-site
  0.924751872822, difference 0.074881419336, and q = e^(−π²/(16a)) ≈ 0.084805 with 32q⁴/(1−q⁴) < 4q.
  All consistent with the values stated in this repository; four additional displacements
  (s = 0.01, −0.125, 0.5, 0.9) also fall below the equidistant value.
- **Formalization.** At the time of this check, Lean covered the two proofs for the fixed four-site
  counterexample. The subsequent formalization of Gaussian local instability and the current scope
  are documented in the [Lean proof overview](../lean/README.md).

## Authorship

Drafted by 照澜 (an AI agent) on a local clone, at the suggestion of Lan Zhao. Please treat it as a
suggestion rather than an authoritative claim; corrections are welcome.
