"""Certificates and independent image-sum checks for the alternating Gaussian chain."""

from fractions import Fraction as Q
from functools import lru_cache
from itertools import accumulate
from math import ceil, exp, fsum, sqrt
from random import Random


@lru_cache(maxsize=None)
def exp_minus(x):
    """Rational interval containing exp(-x) for nonnegative rational x."""
    x = Q(x)
    assert x >= 0
    halvings = 0
    while x > 1:
        x /= 2
        halvings += 1
    term = total = Q(1)
    for j in range(1, 29):
        term *= -x / j
        total += term
    scale = 10**35
    lo = ((total - term) * scale).__floor__()
    hi = (total * scale).__ceil__()
    for _ in range(halvings):
        lo = lo * lo // scale
        hi = (hi * hi + scale - 1) // scale
    return Q(lo, scale), Q(hi, scale)


def support_certificate():
    y = Q(157, 100)
    assert exp_minus(y*y)[1] < Q(86, 1000)
    margins = []
    for j in range(50, 105):
        u, v = Q(j, 100), Q(j+1, 100)
        lower = exp_minus(v*v)[0] - Q(1, 2**15)
        for k in (1, 2, 3):
            lower -= exp_minus((2*k*u)**2)[1]
        upper = Q(86, 1000) * (1 + 2*y*(y-u))
        margins.append(lower - upper)
    assert min(margins) > Q(1, 125)
    print("55 rational intervals; minimum certified tangent margin > 1/125.")


def curvature_certificate():
    # The two positive zeros of f'''' are isolated using the defining polynomial.
    def polynomial(x):
        return 16*x**4 - 48*x*x + 12

    lo1, hi1 = Q(524, 1000), Q(525, 1000)
    lo2, hi2 = Q(1650, 1000), Q(1651, 1000)
    assert polynomial(lo1) > 0 > polynomial(hi1)
    assert polynomial(lo2) < 0 < polynomial(hi2)
    assert (12*hi1 - 8*lo1**3)*exp_minus(lo1**2)[1] < 4
    assert (8*hi2**3 - 12*lo2)*exp_minus(lo2**2)[1] < Q(6, 5)
    d = Q(1, 4)
    assert (12*d - 8*d**3)*exp_minus(d*d)[0] > Q(5, 2)
    assert Q(800, 2**25) < Q(1, 100)
    assert -Q(3, 2) + Q(1, 100) + Q(27, 20) == -Q(7, 50)
    # Tail for P'' follows from B=log(3)>13/12.
    assert Q(184, 189) + Q(1024, 3**15) < Q(49, 50)
    assert exp_minus(Q(105, 100)**2)[1] < Q(1, 3)
    print("Rational bounds for both extrema, periodic images and convexity passed.")


def root_certificate():
    # J(s) = s V'(s)-V(s), evaluated in b=s^2.
    def bounds(b):
        lo = hi = Q(-1)
        for m in range(1, 11):
            left, right = exp_minus(b*m*m)
            c = (-1)**(m+1)*(4*b*m*m+2)
            lo += min(c*left, c*right)
            hi += max(c*left, c*right)
        tail = Q(32*11**4, 2**121)
        return lo-tail, hi+tail
    left, right = Q("2.47416700"), Q("2.47416702")
    assert bounds(left)[0] > 0 > bounds(right)[1]
    assert Q(157, 100)**2 < left
    print("Certified opposite endpoint signs: 2.47416700 < b* < 2.47416702.")


def image_energy(points, length):
    n = len(points)
    reach = ceil(10 / length) + 1
    return n - fsum((-1)**(i+j)*exp(-(x-y+k*length)**2)
                    for i,x in enumerate(points) for j,y in enumerate(points)
                    for k in range(-reach, reach+1))


def uniform(s):
    return 2*fsum((-1)**(m+1)*exp(-(m*s)**2) for m in range(1, ceil(10/s)+2))


def independent_checks():
    hstar = sqrt(2.47416701)
    rng = Random(305912)
    cells = curves = 0
    for n in (2, 4, 8, 12):
        for h in (0.4, 0.85, 1.4, hstar, 1.65, 2.5, 4.0):
            length = n*h
            target = uniform(h) if h >= hstar else 1-h*(1-uniform(hstar))/hstar
            for sample in range(12):
                if sample == 0:
                    points = [i*h for i in range(n)]
                else:
                    weights = [rng.uniform(0.015, 1)**2 for _ in range(n)]
                    points = [0.0, *accumulate(length*w/sum(weights) for w in weights[:-1])]
                energy = image_energy(points, length)
                assert energy/n >= target - 2e-11
                cells += 1
                gaps = [v-u for u,v in zip(points, points[1:]+[points[0]+length])]
                i = min(range(n), key=gaps.__getitem__)
                if gaps[i] <= .5 and length >= 6:
                    j = (i+1) % n
                    step = min(.0005, gaps[i]/3)
                    moved = []
                    for sign in (-1, 1):
                        trial = points[:]
                        trial[i] -= sign*step/2
                        trial[j] += sign*step/2
                        moved.append(image_energy(trial, length))
                    observed = (fsum(moved) - 2*energy) / step**2
                    assert observed < -.13, (n, h, observed)
                    curves += 1

    # Exact collisions in floating-point coordinates at a commensurate high density.
    m, n = 8, 12
    length = m*hstar
    residual = [j*hstar for j in range(m)]
    center = hstar/3
    packed = sorted(residual+[center]*4)
    expected = 1-(m/n)*(1-uniform(hstar))
    assert abs(image_energy(packed,length)/n - expected) < 2e-13
    almost = sorted(residual+[center+j*1e-6 for j in range(4)])
    assert expected-2e-12 <= image_energy(almost,length)/n < expected+2e-6
    print(f"Independent floating-point checks: {cells} cells, {curves} short-pair Hessians,"
          " and a commensurate collision / splitting test.")


def finite_grid_checks():
    """Enumerate cyclically ordered four- and six-site cells on a 12-point circle."""
    from itertools import combinations_with_replacement

    ticks = 12
    hstar = sqrt(2.47416701)
    total = 0
    for n in (4, 6):
        pairs = [(i, j, (-1)**(i+j)) for i in range(n) for j in range(i)]
        for h in (0.6, hstar/2, 1.4, hstar, 1.8):
            length = n*h
            reach = ceil(10/length)+1
            periodized = [fsum(exp(-((r/ticks+k)*length)**2)
                               for k in range(-reach,reach+1)) for r in range(ticks)]
            target = uniform(h) if h >= hstar else 1-h*(1-uniform(hstar))/hstar
            best = float("inf")
            for tail in combinations_with_replacement(range(ticks), n-1):
                points = (0, *tail)
                cross = fsum(sign*periodized[points[i]-points[j]] for i,j,sign in pairs)
                value = 1-periodized[0]-2*cross/n
                best = min(best,value)
                total += 1
            assert best >= target-2e-11
            if h >= hstar or (n == 4 and h == hstar/2):
                assert abs(best-target) < 2e-11
    print(f"Exhaustive mesh: {total} labeled ordered cells with the first site fixed,"
          " including exact coincidences.")


if __name__ == "__main__":
    curvature_certificate()
    support_certificate()
    root_certificate()
    independent_checks()
    finite_grid_checks()
