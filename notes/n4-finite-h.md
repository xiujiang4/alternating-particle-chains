# N=4 finite-h strengthening of the small-spacing theorem

**Linked note to [PR #1](https://github.com/xiujiang4/alternating-particle-chains/pull/1) and [Issue #5](https://github.com/xiujiang4/alternating-particle-chains/issues/5).**

This note records a finite-$h$ specialization for the four-particle Gaussian chain. It is not a competing general-$N$ manuscript. The infimum, the quadratic small-spacing coefficient, and the $h\downarrow0$ cluster framework are already proved in PR #1; the only new point here is the exact finite-range classification in the special case below.

## Statement

Take

$$
N=L=4,\qquad \alpha=\frac14,\qquad
q=e^{-\pi^2/4}\approx0.08480497247,\qquad
c=\frac{\sqrt\pi}{2}.
$$

Let $0<h\le 1/(2\pi)$ and require every cyclic gap, including the gap to the next period, to be at least $h$. Then every global minimizer of the energy among these alternating four-particle configurations is, up to translation, reflection, and cyclic relabeling,

$$
\boxed{(0,\ 2-h,\ 2,\ 2+h)}.
$$

In angular coordinates, with

$$
\eta=\frac{\pi h}{2},
$$

the range is $0<\eta\le1/4$, and the minimizer is

$$
(0,\ \pi-\eta,\ \pi,\ \pi+\eta).
$$

## Relation to PR #1

PR #1 proves, for every even $N$ and $q\le1/3$,

$$
I_N=1-\frac2N[G(0)-G(L/2)],
$$

the semicircle stability estimate, and, as $h\downarrow0$,

$$
M_N(h)=I_N+\frac{\lfloor N^2/8\rfloor}{N}D\,\eta^2+O(\eta^4),
\qquad D=g''(\pi)-g''(0).
$$

For $N=L=4,\alpha=1/4$, PR #1 gives a sufficient threshold
$h_0\approx1.19263\times10^{-5}$ and an $O(\eta)$ cluster localization. The present note replaces that sufficient threshold, in this one case, by
$1/(2\pi)\approx0.159155$ and replaces the $O(\eta)$ picture by an exact minimizer. It does not claim $I_4$, the coefficient $0.37088222\ldots$, or the $1+3$ asymptotic clustering as new.

There is a notation conflict: PR #1 uses $D=g''(\pi)-g''(0)$, while this note uses

$$
\mathcal D=2-|J_1|=\int_{\Omega\triangle H}|\cos\theta|\,d\theta
$$

for the defect of an arc union. The two symbols are unrelated.

## Proof outline

Let $g(\theta)=c(1+2\sum_{n\ge1}q^{n^2}\cos n\theta)$, and put

$$
T=\sum_{n\ge2}n^2q^{n^2},\qquad
U=\sum_{n\ge2}n^4q^{n^2}.
$$

The elementary estimates

$$
T\le\frac q{120},\qquad U\le\frac q{24}
\qquad\text{(1)}
$$

follow from $n^2\le4^{n-1}$, $n^4\le16^{n-1}$, and $q<1/8$. Since
$|\sin n\theta|\le n\sin\theta$ on $(0,\pi)$,

$$
g'''(\theta)
=2c\sum_{n\ge1}n^3q^{n^2}\sin n\theta
\ge2c(q-U)\sin\theta
\ge\frac{23}{12}cq\sin\theta>0.
\qquad\text{(2)}
$$

Thus $g''$ is strictly increasing on $[0,\pi]$.

For a legal configuration, let $\Omega$ be the union of the positively oriented arcs from positive particles to the next negative particles. Write

$$
J_n=\int_\Omega e^{in\theta}\,d\theta,\qquad
S_n=\sum_{j=0}^3(-1)^je^{in\theta_j}.
$$

Then $S_n=-inJ_n$ and

$$
E=1-\frac c2\sum_{n\ge1}q^{n^2}|S_n|^2.
$$

Rotate so that $J_1\ge0$, take $H=\{\cos\theta>0\}$, and set

$$
\mathcal D=2-J_1=\int_{\Omega\triangle H}|\cos\theta|\,d\theta.
$$

With $d=|\Omega\triangle H|$, the distribution function of $|\cos\theta|$ gives

$$
d^2\le8\pi\mathcal D.
\qquad\text{(3)}
$$

For even $n$, $J_n(H)=0$. For odd $n$, $J_n(H)=\pm2/n$ and
$|\cos n\theta|\le n|\cos\theta|$. These estimates give

$$
|S_n|^2-|S_n(H)|^2\le36n^2\mathcal D
\qquad(n\ge2).
$$

The first mode satisfies $|S_1|^2-4=-\mathcal D(4-\mathcal D)$. If

$$
I_4=1-\frac{g(0)-g(\pi)}2,
$$

then

$$
E-I_4
\ge cq\mathcal D\left(2-\frac{\mathcal D}{2}-\frac{18T}{q}\right)
\ge cq\mathcal D\left(\frac{37}{20}-\frac{\mathcal D}{2}\right).
\qquad\text{(4)}
$$

Now take the legal trial

$$
X_\eta=(0,\pi-\eta,\pi,\pi+\eta).
$$

Its Fourier coefficients give

$$
\begin{aligned}
E(X_\eta)-I_4
={}&2c\sum_{n\ \mathrm{odd}}q^{n^2}\sin^2(n\eta)\\
&-2c\sum_{n\ \mathrm{even}}q^{n^2}(1-\cos n\eta)^2\\
\le{}&2c(q+T)\eta^2
\le\frac{121}{60}cq\eta^2.
\end{aligned}
\qquad\text{(5)}
$$

For any global minimizer $X$, $E(X)\le E(X_\eta)$. From (4), (5),

$$
\mathcal D\le\frac{121}{51}\eta^2<5\eta^2.
\qquad\text{(6)}
$$

Substituting this back into the stronger form of (4), for $0<\eta\le1/4$,

$$
\mathcal D\le
\frac{121/60}{37/20-(5/2)\eta^2}\eta^2
\le\frac{968}{813}\eta^2
<\frac65\eta^2
\le\frac3{40}.
\qquad\text{(7)}
$$

### Clustering

Let $r$ be the distance of a particle from the nearer endpoint of $H$. If $r\ge\eta$, the interiors of the two adjacent arcs of length $\eta$ contain no other particle and the indicator of $H$ is constant on both. Since the indicator of $\Omega$ jumps at the particle, one arc lies in $\Omega\triangle H$ up to endpoints. This gives the inequality below. If $r<\eta$, it also holds because its right-hand side is negative.

$$
\mathcal D\ge\frac{2\eta}{\pi}(r-\eta),
$$

so every particle satisfies

$$
r\le R:=\eta+\frac{\pi\mathcal D}{2\eta}.
\qquad\text{(8)}
$$

For an arbitrary legal configuration with $\mathcal D<5\eta^2$ and
$\eta\le0.0868$, this gives

$$
R<\left(1+\frac{5\pi}{2}\right)\eta<\frac\pi4.
$$

For the global minimizer, (7) gives

$$
R<\left(1+\frac{3\pi}{5}\right)\eta
\le\frac14+\frac{3\pi}{20}<\frac\pi4.
\qquad\text{(9)}
$$

The two central arcs $[-\pi/4,\pi/4]$ and $[3\pi/4,5\pi/4]$ contain no particles and $|\cos\theta|\ge\sqrt2/2$ there. If $\Omega$ differed from $H$ on either arc, then $\mathcal D\ge\pi\sqrt2/4>3/40$, contradicting (7). Thus the particles form two clusters at the two endpoints of $H$. The net jumps are $+1$ and $-1$, and alternation forces both cluster sizes to be odd. For four particles the split is therefore $1+3$.

### Locking the gaps

Put the singleton at $0$ and write the other three positions as

$$
\pi+t-u,\qquad\pi+t,\qquad\pi+t+v,
\qquad u,v\ge\eta.
$$

From (9),

$$
|t|,\ |t-u|,\ |t+v|\le2R<\frac\pi2,
\qquad u+v\le2R<\frac\pi2.
\qquad\text{(10)}
$$

The two outer gaps are larger than $\eta$, so at a global minimizer $t$ is free and $E_t=0$. Direct differentiation gives

$$
\begin{aligned}
E_u+E_t&=\frac12\int_0^v
\big[g''(\pi+t+s)-g''(u+s)\big]\,ds,\\
E_v-E_t&=\frac12\int_0^u
\big[g''(\pi+t-s)-g''(v+s)\big]\,ds.
\end{aligned}
\qquad\text{(11)}
$$

By (10), the first integrand compares, after folding with
$g''(\pi+x)=g''(\pi-x)$, a point in $(\pi/2,\pi]$ with a point in
$(0,\pi/2)$. By (2), $g''$ is strictly increasing, so the integrand is positive; the second integral is positive for the same reason. Hence $E_u>0$ and $E_v>0$. If $u>\eta$, decreasing $u$ is feasible and lowers the energy; similarly for $v$. Therefore

$$
u=v=\eta.
\qquad\text{(12)}
$$

Finally, with $u=v=\eta$, Fourier expansion gives

$$
E_t=c\sum_{n\ge1}nq^{n^2}(-1)^n(1-2\cos n\eta)\sin nt.
$$

The first mode is $cq(2\cos\eta-1)\sin t$; the remaining modes are bounded using $|\sin nt|\le n|\sin t|$. For $0<|t|<\pi/2$,

$$
\begin{aligned}
\frac{E_t}{\sin t}
&\ge cq\left(2\cos\eta-1-\frac{3T}{q}\right)\\
&\ge cq\left(\frac{39}{40}-\eta^2\right)
\ge\frac{73}{80}cq>0.
\end{aligned}
\qquad\text{(13)}
$$

Thus the only stationary point in this region is $t=0$. Together with (12), every global minimizer is
$(0,\pi-\eta,\pi,\pi+\eta)$, as claimed.

## Why small defect alone is not enough

The clustering argument does not imply that every configuration with
$\mathcal D<5\eta^2$ lies in the $3\eta$ box used in some local proofs. The legal configuration

$$
(0,\ \pi-\eta,\ \pi+3\eta,\ \pi+4\eta)
$$

has $u=4\eta$, $v=\eta$, $t=3\eta$, and

$$
\begin{aligned}
\mathcal D
&=2-\left|1+e^{-i\eta}-e^{3i\eta}+e^{4i\eta}\right|\\
&\le1-\cos\eta+\cos3\eta-\cos4\eta
\le4\eta^2<5\eta^2.
\end{aligned}
$$

So the finite-h proof must use minimality to strengthen (6) to (7); the cluster lemma by itself is insufficient. This is the methodological point that motivated this note.

## Verification and full proof

The full proof, with all constants checked at 50 decimal digits, is in

- [commit 53916b8](https://github.com/flyqwq555/alternating-chain-lab/commit/53916b8d45785aebaf0059836a3064e80e34f107)
- [full proof](https://github.com/flyqwq555/alternating-chain-lab/blob/53916b8d45785aebaf0059836a3064e80e34f107/docs/proof-n4-phase-transition.md)
- [verification script](https://github.com/flyqwq555/alternating-chain-lab/blob/53916b8d45785aebaf0059836a3064e80e34f107/scripts/verify_proof.py)

The executable checks report `ALL CHECKS PASSED`; the repository test suite reports `11 passed`.

## Scope

This note proves only the stated $N=L=4,\alpha=1/4$ finite-range statement. It does not prove a general-$N$ finite-$h$ classification, does not improve PR #1's $O(\eta^4)$ asymptotic, and does not address the separate $h_c\approx0.668$ candidate phase transition in the companion repository.

The derivation and numerical checks used AI assistance and have not been independently peer reviewed.
