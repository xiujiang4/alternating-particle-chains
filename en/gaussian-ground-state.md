# The exact ground-state energy of alternating Gaussian chains

OpenAI Codex · Research manuscript · 26 November 2026

**Abstract.** For a one-dimensional chain of strictly alternating species with Gaussian attraction between like species and repulsion between unlike species, we compute the energy infimum at every density over all even periods. There is a sharp transition at the previously known pair-insertion threshold $2.47416700<b_*<2.47416702$. Above and at this threshold the uniform chain is the unique minimizer up to translation and indexing. Below it the energy per particle is affine in mean spacing and is approached by adding almost coincident neutral pairs to a crystal of fixed spacing. We also characterize the optimum in the collision closure for every sufficiently large even cell at fixed supercritical density.

## 1. Model and phase diagram

Rescale positions by $\sqrt a$ for the Gaussian $e^{-ar^2}$ and write $h$ for the resulting mean spacing. For $x_{i+N}=x_i+L$, $L=Nh$, even $N\ge2$, the charges are $\sigma_i=(-1)^i$. Set $f(r)=e^{-r^2}$ and $K_L(z)=\sum_{k\in\mathbb Z}f(z+kL)$. With the double-counting convention of [1], the cell energy is
$$
H_N=N-\sum_{i,j=1}^N\sigma_i\sigma_j K_L(x_i-x_j).
$$
Let $e(h)=1-V(h)$ be the uniform energy per particle, with $V(h)=\sum_{m\in\mathbb Z}(-1)^m f(mh)$. By [2], $V(s)/s$ has a unique maximum at $t_*>0$. It satisfies $t_*V'(t_*)=V(t_*)$ and $b_*=t_*^2$ lies in the bracket above.

**Theorem 1.** Over all strictly ordered cells of prescribed mean spacing, the infimum of $H_N/N$ is
$$
\mathcal E(h)=
\begin{cases}
1-(h/t_*)V(t_*),&0<h<t_*,\\
e(h),&h\ge t_*.
\end{cases}
$$
For $h\ge t_*$, each even cell attains the minimum exactly at equal spacing. For $h<t_*$, every strictly ordered finite cell has energy strictly above $\mathcal E(h)$. Its infimum at fixed even $N$ tends to $\mathcal E(h)$ as $N\to\infty$.

In physical units the transition is at $a h_{\rm phys}^2=b_*$. The pair-insertion construction in [2] provided the upper bound in the dense phase. The dilute theorem in [3] gave global optimality for $a h_{\rm phys}^2\ge4$. The matching lower bound below closes this interval. The proof uses a negative second variation for a closest pair and a global supporting line for separated configurations.

<!-- page -->

## 2. A minimum cannot contain a positive gap of at most one half

For this section let $L\ge6$. Suppose a strictly ordered even cell has shortest gap $0<d\le1/2$. Vary this pair's separation at fixed midpoint, moving its two endpoints with velocities $-1/2$ and $1/2$, together with their period copies. The variation preserves the order in a neighborhood of the original configuration.

**Lemma 2.** In this direction $d^2H_N/dd^2<-7/50$. In particular such a configuration cannot be a local minimum.

Take the left endpoint positive. The pair and its own images contribute $2-2K_L(0)+2K_L(d)$, of second derivative $2K_L''(d)$. Since $f''(d)=(4d^2-2)e^{-d^2}$ is increasing up to $1/2$, $2f''(d)\le-2e^{-1/4}<-3/2$. For $k\ge1$ the arguments $kL\pm d$ are at least $5k$, where $f''$ is positive and decreasing. The image correction is at most $400\sum_{k\ge1}k^2 2^{-25k^2}<800/2^{25}<1/100$.

On either side of the pair, discard the pair's own images, and list the remaining sites by distance $s_1<s_2<\cdots$ from the nearer endpoint. The first sign is opposite to that endpoint and the remaining signs alternate. Under the chosen variation, every $s_j$ has velocity $-1/2$ and every $s_j+d$ has velocity $1/2$. Thus each side's contribution to the second derivative is
$$
\tfrac12\sum_{j\ge1}(-1)^{j+1}w(s_j),\qquad
w(s)=f''(s)-f''(s+d).
$$
There is no cross term in a two-site cell. Otherwise pair consecutive terms; the corresponding intervals are disjoint and $s_1\ge d$. The sum without its factor $1/2$ is at most
$$
\int_d^\infty(-w'(s))_+\,ds
\le d\int_d^\infty(f^{(4)}(x))_+\,dx .
$$
Here $-w'(s)=\int_s^{s+d}f^{(4)}(x)dx$ and each $x$ belongs to a set of $s$ of length at most $d$. Gaussian decay justifies the differentiations and summations.

Write $u,v=\sqrt{(3\mp\sqrt6)/2}$, respectively. The fourth derivative is positive on $[0,u)$ and $(v,\infty)$, negative between them, and $u>1/2$. The last bound is $d[f'''(u)-f'''(d)-f'''(v)]$. Direct enclosures give $f'''(u)<4$, $-f'''(v)<6/5$ and $f'''(1/4)>5/2$. Since $f'''$ increases on $[0,1/2]$ from zero, the bound is at most $13/10$ for $d\le1/4$ and $27/20$ for $1/4\le d\le1/2$. Both half-weighted sides together contribute at most $27/20$. Adding the self and image terms proves the claimed strict negative bound.

<!-- page -->

## 3. A supporting line reaching down to half a unit

Write $d_i=x_{i+1}-x_i$, $S_{i,m}=\sum_{j=0}^{m-1}d_{i+j}$ with cyclic indices. For $M$ strictly ordered surviving sites, $H_M=2\sum_i\sum_{m\ge1}(-1)^{m+1}f(S_{i,m})$. Define
$$
P(x)=f(x)-\sum_{k\ge1}f(2kx),\qquad y=157/100.
$$
**Lemma 3.** For every $x\ge1/2$ and $t\ge y$, $P(x)\ge P(t)+P'(t)(x-t)$, strictly unless $x=t$.

For $x\ge D=\sqrt{\log3}$ the ratio $f''(mx)/f''(x)$ decreases with $x$ for each $m\ge2$. Indeed it is $(2m^2x^2-1)e^{-(m^2-1)x^2}/(2x^2-1)$, a product of positive decreasing factors. At $x=D$, the quantitative bound in [3, §2] gives $\sum_{m\ge2,\ m\ {\rm even}}m^2 f''(mD)/f''(D)<49/50$. Hence $P''(x)>0$ on $[D,\infty)$. For $x<D$ and $t\ge y$ the tangent height is decreasing as a function of $t$, since its derivative is $P''(t)(x-t)$. It suffices to test $t=y$. Here $P(y)\le f(y)$ and $P'(y)\ge f'(y)$, so for $x\le y$ the tangent is at most $f(y)[1+2y(y-x)]$.

For completeness the short compact check uses only rational operations. For $u=j/100$, $v=u+1/100$, $j=50,\dots,104$, $x\in[u,v]$, use the lower and upper bounds
$$
A_j=f(v)-\sum_{k=1}^3 f(2ku)-2^{-15},\qquad
B_j=\tfrac{86}{1000}[1+2y(y-u)] .
$$
We have $P(x)\ge A_j$ since $\sum_{k\ge4}e^{-k^2}<2^{-15}$, and $f(y)<86/1000$. On all 55 intervals $A_j-B_j>1/125$. Together they cover $[1/2,D]$. The certificate halves each rational exponent until it is at most one, bounds its negative exponential by the degree-27 and degree-28 alternating Taylor sums, and squares back with outward rounding. The companion Python script checks every stated interval and also bounds the stationary points used in Lemma 2 by $0.524<u<0.525$ and $1.650<v<1.651$.

Let all surviving gaps be at least $1/2$ and $s=L/M$. For even $m\ge2$, convexity of $f$ on $[1,\infty)$ gives $f(S_{i,m})\le m^{-1}\sum_{j=0}^{m-1}f(md_{i+j})$. For odd $m\ge3$, averaging over the starting indices gives $\sum_i f(S_{i,m})\ge M f(ms)$. Multiplicities remain valid for windows longer than the cell. Therefore
$$
\tfrac12 H_M\ge\sum_i P(d_i)+M\sum_{m\ge3,\ m\ {\rm odd}}f(ms).
$$

<!-- page -->

## 4. Comparison in the collision closure

Apply Lemma 3 and the tangents to $f(ms)$ for odd $m\ge3$ in the last inequality. Since $e(t)=2P(t)+2\sum_{m\ge3,\ m\ {\rm odd}}f(mt)$, for $t\ge y$ we obtain
$$
H_M\ge M[e(t)+e'(t)(s-t)].
$$
Equality requires every gap to equal $t$. We can retain the additional nonnegative term $2M B_3(s;t)$ on the right, where $B_3(s;t)=f(3s)-f(3t)-3f'(3t)(s-t)$. Also $e''(t)>0$ for $t\ge y$ by $P''>0$ and the convex odd terms.

At fixed $L,N$ allow zero gaps. The closed simplex of gaps is compact, and $K_L$ is continuous. Its minimum equals the infimum over strict gaps by density. Cancel coincident opposite-sign neighbors, including cyclic coincidences. Each canceled pair leaves the signed quadratic sum unchanged. With $M$ surviving sites the cell energy is $N-M+H_M$, with $H_0=0$. The surviving strictly ordered chain of a minimizer must itself minimize at fixed $M,L$: any competitor can be extended by coincident pairs. If $M>0$ and $L\ge6$, Lemma 2 therefore makes every surviving gap greater than $1/2$.

Set $t=\max(h,t_*)$, which is greater than $y$, and $\mu(t)=e(t)-t e'(t)$. Dividing the comparison by $N$ gives, with $q=M/N$,
$$
H_N/N \ \ge\ \mu(t)+h e'(t)+(1-q)[1-\mu(t)] .
$$
At $t_*$, $\mu(t_*)=1$ by the defining equation. For $t>t_*$, $\mu'(t)=-t e''(t)<0$. The first two terms are exactly $\mathcal E(h)$ in either branch. For an empty residual cell $H_N/N=1>\mathcal E(h)$, since $V(t_*)>0$ and $e(h)\le2e^{-h^2}<1$ for $h\ge t_*$. Every configuration satisfies the lower bound, first for $L\ge6$, and then for any $L>0$ by repeating a cell until its length is at least six. Repetition preserves energy per particle.

Equality with $M>0$ forces every surviving gap to equal $t$. If $h\ge t_*$, this forces $M=N$ and equal original spacing, also at the endpoint. If $h<t_*$, equality in the closure requires $M/N=h/t_*$ and an equidistant residual chain. These conditions suffice by cancellation. They apply at small $L$ as well by repetition and reduction. A strict cell then cannot attain equality in the dense regime.

Conversely choose even $M$ nearest to $Nh/t_*$ for all sufficiently large even $N$ in that regime. Start with $M$ equally spaced sites of period $Nh$ and insert $(N-M)/2$ canceling pairs. Its energy per particle tends to $1-(h/t_*)V(t_*)$. For each $N$ one may split the pairs into strictly ordered sites with arbitrarily small energy change. This proves Theorem 1.

<!-- page -->

## 5. Optimal particle counts in large finite cells

Fix $0<h<t_*$ and put $q_*=h/t_*$. Denote by $I_N(h)$ the fixed-cell infimum of the strict energy per particle. There is $N_0(h)$ such that for even $N\ge N_0(h)$,
$$
I_N(h)=\min_{M\in\mathcal A_N}\{1-(M/N)V(Nh/M)\},
$$
where $\mathcal A_N$ consists of the two neighboring even integers bracketing $Nq_*$ (one integer if it is itself even). Every minimizer in the collision closure reduces to an equidistant chain at an optimizing count. Its other particles occur as canceling pairs. The statement permits either count when the candidate energies tie.

**Proof.** The construction on the previous page gives $I_N(h)\to\mathcal E(h)<1$, so a minimizing residual chain is nonempty eventually. Retain the $m=3$ tangent error from §4. For $q=M/N>0$ this yields
$$
I_N(h)-\mathcal E(h)\ge 2q B_3(h/q;t_*).
$$
All surviving gaps exceed $1/2$ for large $N$, so $h/q\ge1/2$. The right side is strictly positive except at $q=q_*$ on its admissible domain $0<q\le\min(1,2h)$, by strict convexity of $f(3s)$ there. It has strictly positive limit $-6h f'(3t_*)$ at $q=0$. Compactness then forces $q\to q_*$ for every sequence of minimizing counts. In particular $s=h/q\ge y$ eventually, since $t_*>y$.

Apply the comparison of §4 with $t=s$. Replacing the surviving chain by the equidistant one at the same count realizes its lower bound, and equality requires equal gaps. Its resulting energy per original particle is $U(q)=1-qV(h/q)$. The derivative is $U'(q)=sV'(s)-V(s)$. The sign result of [2] makes $U$ decreasing below $q_*$ and increasing above it. All even counts are admissible in the closure by insertion. This proves the two-count formula.

Taylor expansion at $q_*$ also yields
$$
I_N(h)=\mathcal E(h)+
\frac{t_*^2e''(t_*)}{2q_*}\,
\frac{\operatorname{dist}(Nq_*,2\mathbb Z)^2}{N^2}
+O_h(N^{-3}).
$$
Indeed $U''(q_*)=t_*^2e''(t_*)/q_*>0$ and the two candidates are within $2/N$ of $q_*$. The estimate is at fixed $h$. We give no explicit size for $N_0(h)$.

**Example.** At $h=t_*/2$ and $N$ a multiple of four, exactly $N/2$ equally spaced survivors attain the thermodynamic energy after neutral pairs are inserted in the closure. For $N\equiv2$ modulo four the leading finite-size excess is $t_*^2e''(t_*)/N^2$ as $N\to\infty$.

<!-- page -->

## Sources and verification

1. L. Bétermin, H. Knüpfer and F. Nolte, *Note on Crystallization for Alternating Particle Chains*, Journal of Statistical Physics 181 (2020), [journal article](https://doi.org/10.1007/s10955-020-02603-2). Conjecture 2.7 specifies the sign convention and originally proposes all-scale optimality for completely monotone functions of squared distance.
2. OpenAI Codex, *Equal spacing for exponential-power potentials and the Gaussian stability threshold*, [merged note](https://github.com/xiujiang4/alternating-particle-chains/blob/88ccec412f76356009fdc06e4bff3ab3a54774f6/notes/chain-stability.md). We use its sign theorem for $sV'(s)-V(s)$, its root bracket and its neutral-pair construction.
3. OpenAI Codex, *Global crystallization of dilute alternating Gaussian chains*, [merged manuscript](https://github.com/xiujiang4/alternating-particle-chains/blob/3389797a4aac8ed1c65e93c864cfa2305b65359a/en/dilute-crystallization.md). We use its Gaussian curvature-series bound at $\sqrt{\log3}$.
4. Codex and G. Jiang, *A Gaussian counterexample and a Riesz bound for alternating particle chains*, [upstream manuscript](https://github.com/xiujiang4/alternating-particle-chains/blob/a48fe4c2623a29dd45edd227410a07baba400250/en/paper.pdf). This provides the original Gaussian counterexample motivating the density-dependent question.

The upper bound by insertion and the number $b_*$ were known in [2]. The new step is a lower bound with equality conditions at all densities. It follows from the negative pair curvature in §2 and the supporting-line estimate in §3. They also identify the two candidate residual counts in a large finite periodic cell.

**Reproduction.** Run the accompanying Python 3 standard-library verifier. It certifies the 55 tangent intervals, derivative bounds, curvature constants and endpoint signs using rational arithmetic. Separately it evaluates the periodic image sum for both density branches and a commensurate collision, and compares the short-pair prediction with finite differences. The latter are numerical tests. The mathematical argument treats arbitrary displacements and every even periodic cell.

This AI-generated research manuscript has not undergone independent peer review. The results concern strictly alternating periodic chains and limits of their energy per particle. Literature priority has not been established.
