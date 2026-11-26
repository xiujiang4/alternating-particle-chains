# Nonlinear instability at the infinite Gaussian chain's spectral threshold

**Research contributor:** [bowen-rgb](https://github.com/bowen-rgb). ChatGPT and OpenAI Codex assisted with the mathematical development, verification and exposition.

## Summary

At the long-wave spectral threshold of the infinite alternating Gaussian chain, the displacement Hessian is nonnegative and the dispersion is quartic at zero wave number. Nevertheless, asymmetric long-wave strains give strictly energy-decreasing, compactly supported perturbations of arbitrarily small displacement norm. The negative cubic contribution dominates the nonnegative quadratic part.

## 中文摘要

无限交替高斯粒子链在长波谱临界值处，位移 Hessian 非负，零波数附近的色散为四阶。但可构造非对称的长波应变，使紧支撑位移的范数趋于零且总能量严格下降。负的三阶应变贡献压过非负的二次能量。

## Main statement

Measure length in units of the mean gap and write $t=\alpha\ell^2$ for the Gaussian $e^{-\alpha r^2}$. Let $t_\infty\approx1.08182608715$ be the infinite-chain spectral threshold. For each $\varepsilon>0$, at $t=t_\infty$ there is a real finitely supported displacement $u$ on $\mathbb{Z}$ with $0<\lVert u\rVert_{\ell^2}<\varepsilon$ such that $i+u_i$ remains strictly ordered and the total directed-pair energy change $\mathcal E_{t_\infty}(u)$ is strictly negative.

For $u_i=a_M\phi(i/M)$ with $a_M=M^{-3/4}$ and a smooth compactly supported profile satisfying $\int(\phi')^3<0$, the quadratic term is $O(a_M^2M^{-3})$. The cubic term has a strictly negative leading coefficient at scale $a_M^3M^{-2}$, and the fourth-order remainder is $O(a_M^4M^{-3})$. The proof controls the infinite pair sums before taking the limit. [Proof](https://github.com/bowen-rgb/alternating-gaussian-chain-stability-public/blob/6b58a5c14086f2f6760d4dde25ed74fdea6ca190/proofs/infinite-chain.md#nonlinear-instability-at-the-infinite-threshold)

## Relationship to previous results

Upstream [PR #4](https://github.com/xiujiang4/alternating-particle-chains/pull/4) identifies the same long-wave threshold, quartic critical dispersion and the inverse-square correction for large even periods. It also exhibits a six-site lower-energy competitor in a locally stable regime. The conclusion above concerns the nonlinear energy at the infinite threshold itself. [PR #9](https://github.com/xiujiang4/alternating-particle-chains/pull/9) addresses global energy comparisons over periodic configurations.

## Verification and reproduction

The independent artifacts and proofs are in the [research repository](https://github.com/bowen-rgb/alternating-gaussian-chain-stability-public). The [Lean coverage table](https://github.com/bowen-rgb/alternating-gaussian-chain-stability-public/blob/6b58a5c14086f2f6760d4dde25ed74fdea6ca190/verification/lean-coverage.md) records the four-site stability and metastability results, dispersion monotonicities and threshold-ordering lemmas. The infinite-chain nonlinear argument is analytical. [Arb output](https://github.com/bowen-rgb/alternating-gaussian-chain-stability-public/blob/6b58a5c14086f2f6760d4dde25ed74fdea6ca190/verification/arb-output.txt) certifies selected descending profiles and the numerical threshold and coefficients.

Run in the research repository with Python 3.12:

    python -m pip install -r requirements-verification.txt
    python -m unittest discover -s tests -v
    python -m src.verify_arb

Run from the research repository's lean directory with its pinned toolchain:

    lake exe cache get
    lake build
    lake env lean Audit.lean > axiom-audit.log
    python ../src/check_lean_audit.py audit-expected.txt axiom-audit.log
