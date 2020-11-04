---
layout: page
title: "Interpolation"
category: doc
date: 2020-10-30 12:59:32
mathjax: true
order: 4
---

**spdm** implements several forms of continuous interpolation between two covariance matrices $$S_1$$ and $$S_2$$. The function is called as follows:
```r
spd.interpolate(x, y, t, method = c('euclidean', 'logeuclidean', 'riemannian'), ...)
```
where `x` and `y` are SPD matrices, `t` $$\in [0,1]$$ is an interpolation parameter, and `method` specifies the form of interpolation measure.

<h4>euclidean (default)</h4>

Euclidean distance interpolation between $$S_1$$ and $$S_2$$:

$$
    I_{S_1,S_2}(t) = (t-1)S_1 + tS_2
$$

Example:
```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.interpolate(x, y, t = .5, method = 'euclidean')
```

<h4>logeuclidean</h4>

Log-Euclidean distance interpolation between $$S_1$$ and $$S_2$$:

$$
    I_{S_1,S_2}(t) = \exp \left [ (t-1)\log{S_1} + t\log{S_2} \right ]
$$

Example:
```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.interpolate(x, y, t = .5, method = 'logeuclidean')
```

<h4>riemannian</h4>

Riemannian geodesic interpolation between $$S_1$$ and $$S_2$$:

$$
    I_{S_1,S_2}(t) = S_1^\frac{1}{2} (S_1^{-\frac{1}{2}} S_2 S_1^{-\frac{1}{2}})^t S_1^\frac{1}{2}
$$

Example:
```r
x <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
y <- spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
d <- spd.interpolate(x, y, t = .5, method = 'riemannian')
```


