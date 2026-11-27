# A machine-checked Gaussian counterexample / 高斯反例的形式化证明

The four sites in each period have signs $(+,-,+,-)$. Both cells have period four. We compare the equally spaced cell $U=(0,1,2,3)$ with $X=(0,3/2,2,5/2)$, using the energy per particle and ordered-pair convention of the manuscript. 两个周期单元各有四个粒子，种类交替、顺序相同。两种构型都沿整条实轴周期延伸。

$$
E(P)=-\frac14\sum_{i,j=0}^3\ \sum_{m\in\mathbb Z}^{\prime}
\sigma_i\sigma_j\exp\!\left[-\frac{(x_j+4m-x_i)^2}{4}\right].
$$

The prime omits the single central self-interaction for each label, $i=j$ and $m=0$. Images of that label in all other periods contribute. 撇号只略去每个粒子与自身在同一周期中的相互作用。下面的定理直接比较完整无穷链的能量。

| Theorem in [Counterexample.lean](Counterexample.lean) | What Lean checks / 验证内容 |
| --- | --- |
| `admissible_gaussian_counterexample` | The Gaussian has a profile $F$ in the squared distance with $(-1)^n F^{(n)}(s)>0$ for every $n\geq 0$ and $s\geq 0$. A Fourier proof in the literal coordinates gives $E(X)<E(U)$. 高斯势满足猜想的完全单调条件，移动后的构型能量严格更低。 |
| `admissible_cells_and_energy_gap` | A direct real-space proof gives $E(U)-E(X)>1/36$. Both cells begin at zero and are strictly ordered. 两个构型满足位置约束，能量差有严格的有理数下界。 |

The Fourier proof periodizes the Gaussian and computes the signed sum over all sixteen ordered pairs. The real-space proof groups all images by their distance and bounds the series tail. 两条证明分别在傅里叶空间和实空间控制无穷级数。

## Continuous Gaussian displacements / 高斯连续位移

Proposition 2 of the manuscript compares $Y_s=(0,1+s,2,3-s)$ with $U=(0,1,2,3)$ at period four. For $f_a(r)=e^{-ar^2}$, with $a>0$ and $q=e^{-\pi^2/(16a)}$, Lean proves

$$
0<|s|<1,\qquad 0<q\le \tfrac14
\quad\Longrightarrow\quad E_{f_a}(Y_s)< E_{f_a}(U).
$$

| Theorem in `AlternatingChains.Fourier` | What Lean checks / 验证内容 |
| --- | --- |
| `displacement_fixed_energy_lt` | All allowed displacements at $a=1/4$, using the original `cellEnergy`. 固定参数下，直接比较原定义的每粒子能量。 |
| `displacement_energy_lt` | All positive scales whose nome satisfies $q\le1/4$. 所有满足该参数界的正高斯尺度。 |
| `displacement_energy_lt_of_nome` | Every $q\in(0,1/4]$ gives a positive $a=-\pi^2/(16\log q)$ with precisely this nome and the strict energy inequality. 参数区间包含右端点。 |
| `cellEnergyAt_quarter` | For all $b,d$, the variable-scale energy at $a=1/4$ equals `cellEnergy b d`. 两种能量定义在固定参数处完全一致。 |

The signed sums include all sixteen ordered pairs and every period image. For each particle only its own central term is removed. `displacement_ordered` proves $0<1+s<2<3-s<4$ for $|s|<1$, including the gap to the next period. `gaussian_images_summable` and `gaussian_images_without_self_hasSum` establish convergence for every $a>0$ and every pair separation. [Fixed scale and ordering](FourPointCounterexample.lean) · [Energy, convergence and variable scale](GaussianDisplacementEnergy.lean)

傅里叶证明沿用仓库的结构因子。只计正频率时，第一频率至少增加 $4qs^2$，其余频率的总损失至多为 $16\pi^2q^4s^2$。在 $q=1/4$ 仍有 $16\pi^2q^3=\pi^2/4<4$，所以对任意接近零的非零位移都能得到严格不等式。实空间级数保留每一项周期像，只去掉四个粒子各自的中心自作用。指数混合势和里斯势的最优性仍待形式化。[Fourier estimates / 傅里叶估计](GaussianDisplacement.lean)

## General Gaussian energy / 一般高斯能量

For an alternating cell of $N=2m>0$ labels, let $L>0$ be the period, $\alpha>0$ the Gaussian parameter and $\sigma_j=(-1)^j$. The ordered energy per particle omits exactly the central image of each label paired with itself. Distinct labels at coincident positions still interact.

With $x_j=X_j/L$, $s=\alpha L^2$, $q=e^{-\pi^2/s}$ and $P_n=\sum_j\sigma_j e^{2\pi i n x_j}$, the general identity is

$$
E=1-\frac{2}{N}\sqrt{\frac{\pi}{s}}\sum_{n=1}^{\infty}q^{n^2}|P_n|^2 .
$$

The leading one cancels the central self terms. Electroneutrality removes the zero mode. 对任意正偶数粒子数、正周期和正高斯参数，该公式也适用于不同标签的位置重合。

| Theorem in `GaussianChains` | Scope |
| --- | --- |
| `physicalEnergy_eq_imageEnergy`, `physicalEnergy_fourier` | The normalized image sum and the convergent Fourier series for the physical energy. [Physical sum](ChainEnergy.lean) · [Gaussian kernel](KernelFourier.lean) · [Fourier energy](ChainFourier.lean) |
| `imageEnergy_four_eq_cellEnergyAt`, `imageEnergy_four_quarter` | For distinct coordinates $(0,b,2,d)$ at $L=4$, the normalized width is $16a$. At $a=1/4$ the identity recovers `cellEnergy b d`. [Four-site specialization](FourBridge.lean) |
| `imageEnergy_four_displacement_lt` | The displacement theorem above in normalized coordinates, with the same nome and displacement hypotheses. [Displacement comparison](FourBridge.lean) |

The distinctness hypothesis matters at collisions. For $(0,0,2,2)$ and $a>0$, `four_collision_conventions` gives `physicalEnergy = 1` and `cellEnergyAt = 0`. The latter identifies central self terms by coordinate equality. 严格有序的四点构型自动满足坐标互异条件。 [Collision example](FourBridge.lean)

## Reproduce / 复现

Install the Lean toolchain manager `elan`, then run the following from the repository root. The toolchain is Lean 4.28.0. The Lake manifest pins mathlib and its dependencies.

```sh
cd lean
lake exe cache get
lake build
lake env lean Counterexample.lean
lake env lean FourPointCounterexample.lean
lake env lean GaussianDisplacementEnergy.lean
```

The three `lake env lean` commands print the axiom dependencies of the two four-site theorems and the three continuous-displacement theorems. Each lists `propext`, `Classical.choice`, and `Quot.sound`. 最后三条命令分别审计原有两个主定理、固定高斯尺度的定理以及全参数范围的两个表述。五份报告均只列出上述三个标准公理。

To audit the general energy and its four-site specialization, run these additional commands from `lean/` after the build.

```sh
lake env lean ChainEnergy.lean
lake env lean ChainFourier.lean
lake env lean FourBridge.lean
```

| Definitions and proofs | Source |
| --- | --- |
| Squared-distance profile and all derivative signs | [GaussianClass.lean](GaussianClass.lean) |
| Periodization, structure factors and literal-coordinate Fourier comparison | [PeriodFourGaussian.lean](PeriodFourGaussian.lean) · [GaussianFourier.lean](GaussianFourier.lean) · [FourPointCounterexample.lean](FourPointCounterexample.lean) |
| Real-space Gaussian bounds and infinite-series estimate | [ArithmeticBounds.lean](ArithmeticBounds.lean) · [Direct.lean](Direct.lean) |
| Labeled cells, periodic images, physical energy and strict gap | [PhysicalCellCore.lean](PhysicalCellCore.lean) · [ImageReindex.lean](ImageReindex.lean) · [ParticleEnergy.lean](ParticleEnergy.lean) · [PeriodicGaussian.lean](PeriodicGaussian.lean) · [GaussianMargin.lean](GaussianMargin.lean) |
