# A Gaussian counterexample and a Riesz bound for alternating particle chains

**Codex (OpenAI AI model)** · Corresponding author / 通讯作者 **guowei jiang**  
Research draft / 研究手稿

| Manuscript / 手稿 | PDF | LaTeX |
| --- | --- | --- |
| English | [Read the paper](en/paper.pdf) | [Source](en/paper.tex) |
| 中文 | [阅读中文稿](zh/paper.pdf) | [源文件](zh/paper.tex) |

## Results

Must a periodic chain of two alternating species have equally spaced particles to minimize its energy? Bétermin, Knüpfer and Nolte proposed this for pair potentials completely monotone in the **squared distance**, with attraction between like species and repulsion between unlike species. The paper gives a four-particle counterexample to Conjecture 2.7 as stated in the published article. [Original conjecture](https://doi.org/10.1007/s10955-020-02603-2)

For the Gaussian potential $f(r)=\exp(-r^2/4)$, moving the two particles of one species inward lowers the energy while keeping the other two fixed. Both cells repeat with period four. The table uses the original paper's energy per particle, counting each pair in both directions.

| Positions in one cell / 周期内位置 | Energy per particle / 每粒子能量 |
| --- | ---: |
| $(0,1,2,3)$ | 0.999633292158 |
| $(0,1.5,2,2.5)$ | 0.924751872822 |

The Fourier proof gives a strict inequality and shows that arbitrarily small displacements in this direction also lower the energy. For positive mixtures of exponentials in the **distance**, the paper gives a direct proof that equal spacing uniquely minimizes energy. This includes every inverse power $r^{-p}$ with $p>0$, the range proposed in Remark 2.6. The inverse-power result also follows from earlier bounds for one-dimensional spin domains. [Earlier bound, Eqs. (2.4)–(2.6)](https://doi.org/10.1007/s00220-013-1740-z)

## 中文摘要

一维周期链上有两类交替排列的粒子，同类相吸，异类相斥。Bétermin、Knüpfer 和 Nolte 在期刊版猜想 2.7 中提出，当势函数关于**距离的平方**完全单调时，等间距排列在任意密度下都唯一地使能量最低。上表中的高斯势反例保持周期、密度和粒子顺序，仅移动同一类的两个粒子，每粒子能量就下降约 0.0748814。手稿用傅里叶级数严格证明能量下降，并证明沿同一方向任意小的位移也能降低能量。[原猜想](https://doi.org/10.1007/s10955-020-02603-2)

对于关于**距离本身**的衰减指数函数的正混合，手稿直接从粒子间距出发证明等间距排列是唯一最优解。结论覆盖原文评注 2.6 所问的全部反幂势 $r^{-p}$（$p>0$），也可由此前对一维自旋畴的估计推出。[已有估计，式 (2.4)–(2.6)](https://doi.org/10.1007/s00220-013-1740-z)

## Lean proof / 形式化证明

Lean 4.28.0 verifies the four-site Gaussian counterexample in two ways. The Fourier argument proves the strict inequality for the specified sites and the Gaussian satisfies the conjecture’s squared-distance hypothesis. A direct real-space proof also gives $E(U)-E(X)>1/36$. Both proofs include every periodic image. [Four-site theorems / 四粒子反例](lean/Counterexample.lean)

Lean also verifies Proposition 2 of this manuscript. For $f_a(r)=e^{-ar^2}$ and $0<q=e^{-\pi^2/(16a)}\le 1/4$, moving the two negative sites to $1+s$ and $3-s$ strictly lowers the full energy for every $0<|s|<1$. The case $a=1/4$ uses the original energy definition. [Fixed scale](lean/FourPointCounterexample.lean) · [Full parameter range](lean/GaussianDisplacementEnergy.lean)

Lean 已验证四粒子高斯反例和手稿命题 2。对上述全部高斯参数，两个负号粒子沿指定方向移动时，任意 $0<|s|<1$ 都保持四个粒子的顺序，并严格降低完整无穷链的每粒子能量。实空间证明还给出 $a=1/4$、$s=1/2$ 时能量差大于 $1/36$。指数混合势和里斯势的结论仍待形式化。[证明覆盖与复现说明](lean/README.md)

## Numerical verification / 数值复核

Run from the repository root with Python 3. The script uses only the standard library. 在仓库根目录运行下列命令即可，只需 Python 3 标准库。

```sh
python3 code/verify_chains.py
```

The script compares direct and Fourier energy sums for both cells, checks four sample displacements, and evaluates the exponential bound on a six-site cell. 脚本用实空间和傅里叶空间两种算法核对上表，再检查四组位移，并在一个六粒子周期上检验指数势的能量界。[Verification code / 验证脚本](code/verify_chains.py)

## Follow-up note / 后续研究

A contributed [stability note](notes/chain-stability.md) derives the all-density exponent boundary for exponential-power potentials and the Gaussian long-wave instability threshold. It includes a six-site comparison at a density where equal spacing is a strict local minimum in every finite cell. [Verification script](code/verify_stability.py)

这份附注研究哪些指数保证等距排列在所有密度下都最优，并给出高斯链局部稳定、却有更低能排列的参数区间。[中文推导](https://github.com/gamehhh7/alternating-chain-stability/blob/3a7012e285a7482a9caadc5130cc21bbe8057172/paper-zh.md)

## Relation to BKN Proposition 2.9 / 与 BKN 命题 2.9 的关系

For potentials satisfying the hypotheses of Proposition 2.9, the sign pattern $\mathcal F=(-f,-f,f)$ makes its Fourier expression zero at every frequency. The Gaussian in the four-site counterexample satisfies these hypotheses. [Derivation and scope](notes/prop-2.9-degeneracy.md) · [Original proposition](https://doi.org/10.1007/s10955-020-02603-2)

对满足命题 2.9 假设的势，符号组合 $\mathcal F=(-f,-f,f)$ 使其傅里叶表达式在每个波数处都等于零。四粒子反例中的高斯势满足这些假设。

Questions and corrections are welcome through this repository’s Issues tab. 欢迎在本仓库的 Issues 中提出问题或勘误。

## Dilute Gaussian chains / 低密度交替高斯链

For the Gaussian interaction, equal spacing uniquely minimizes the energy whenever the dimensionless squared mean spacing satisfies $ah^2\ge4$, for every even period and without an imposed minimum gap. Near minimizers at fixed density converge to uniform spacing in mean absolute gap deviation. [English proof](en/dilute-crystallization.md) · [English PDF](en/dilute-crystallization.pdf) · [中文证明](zh/dilute-crystallization.md) · [中文 PDF](zh/dilute-crystallization.pdf) · [Verification script](code/verify_dilute_crystallization.py)

## Exact Gaussian ground-state energy / 交替高斯链的精确基态能量

The pair-insertion threshold from the stability note is the sharp global crystallization threshold. The new note gives the infimum over all even periods on both sides of the transition and characterizes the minimizing residual particle count in sufficiently large finite cells. [English manuscript](en/gaussian-ground-state.md) · [English PDF](en/gaussian-ground-state.pdf) · [中文手稿](zh/gaussian-ground-state.md) · [中文 PDF](zh/gaussian-ground-state.pdf) · [Certificates](code/verify_gaussian_ground_state.py)

## Minimum-spacing study / 最小間距研究

A separately maintained bilingual study classifies six-site minimizers on $7.99\le s\le9$ for every feasible positive minimum spacing, and at the separate point $(s,h)=(22,1/1000)$. The papers, analytic derivations and executable certificates are available in the [independent repository](https://github.com/yuri77521/alternating-gaussian-chains) and its [v1.0.1 release](https://github.com/yuri77521/alternating-gaussian-chains/releases/tag/v1.0.1).

中英文手稿列明一般偶數粒子精確鎖定的充分條件，並逐項說明六粒子全域分類的證明及復現方法。
