---
layout: page
title: "Distance measures"
category: doc
date: 2020-10-30 12:58:38
mathjax: true
order: 3
---

**spdm** implements several distance measures between two covariance matrices $$S_1$$ and $$S_2$$. The function is called as follows:

```r
spd.dist(x, y, method = c('euclidean', 'logeuclidean', 'cholesky', 'riemannian'), ...)
```
where `x` and `y` are SPD matrices, and `method` specifies the distance measure.

<h4>euclidean (default)</h4>

The Frobenius norm of the difference

$$
    d(S_1,S_2) = \|S_1 - S_2\|_F
$$

Example:
```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.dist(x, y, method = 'euclidean')
```

<h4>logeuclidean</h4>

The Frobenius norm of the difference

$$
    d(S_1,S_2) = \|\log{S_1} - \log{S_2}\|_F
$$

Example:

```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.dist(x, y, method = 'logeuclidean')
```

<h4>cholesky</h4>

The Frobenius norm of the difference between the Cholesky factors of $$S_1$$ and $$S_2$$.

$$
    d(S_1,S_2) = \|\text{Chol}(S_1) - \text{Chol}(S_2)\|_F
$$

Example:

```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.dist(x, y, method = 'cholesky')
```

<h4>riemannian</h4>

The intrinsic distance on the SPD manifold, in decibels.

$$
    d(S_1,S_2) = \left ( \sum_{i=1}^k (10 \cdot \textrm{log}_{10}\lambda_k)^2 \right )^\frac{1}{2}
$$

where $$\lambda_i$$ are the generalized eigenvalues of $$S_1$$ and $$S_2$$, satisfying $$\lambda S_1 - S_2 = 0$$.

Example:

```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.dist(x, y, method = 'riemannian')
```
