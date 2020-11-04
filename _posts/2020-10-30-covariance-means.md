---
layout: page
title: "Covariance means"
category: doc
date: 2020-10-30 12:57:18
mathjax: true
order: 2
---

**spdm** implements several measures of central tendency for observations $$S_1,S_2, ..., S_n$$ on the positive-definite cone. The function is called as follows

```r
spd.mean(x, method = c('euclidean', 'logeuclidean', 'riemannian'), ...)
```
where `x` is a list of SPD matrices. Currently supported means are:

<h4>euclidean (default)</h4>

The elementwise arithmetic mean

$$
    \bar{S} = \frac{1}{n}\sum_{i=1}^n S_i
$$

This is guaranteed to be an SPD matrix, although, unlike the mean of a set of real numbers, it is not necessarily the center of the sample in the squared error sense.

Example:

```r
# Generate a set of covariance matrices using `linshrink` estimation to ensure positive-definiteness
x <- lapply(1:10, function(i) {
    spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
}) 

# Compute the mean
m <- spd.mean(x, method = 'euclidean')
```

<h4>logeuclidean</h4>

Obtained by exponentiating the arithmetic mean of the logarithms of the sample matrices

$$
    \bar{S} = \exp \left ( \frac{1}{n}\sum_{i=1}^n \log{S_i} \right )
$$

Geometrically, this can be interpreted as projecting the sample onto the tangent space of the SPD cone at the identity, taking the mean, and then taking the exponential map back to the space of covariance matrices.

Example:

```r
# Generate a set of covariance matrices using `linshrink` estimation to ensure positive-definiteness
x <- lapply(1:10, function(i) {
    spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
}) 

# Compute the mean
m <- spd.mean(x, method = 'logeuclidean')
```

<h4>riemannian</h4>

Estimates the power means of $$S_1,S_2, ..., S_n$$ using the fixed point algorithm developed by Congedo, Barachant, and Koopae (2017). These means generalize the usual power mean of a set of real numbers

$$
    \bar{x}_p = \left ( \frac{1}{n}\sum_{i=1}^n x^p \right )^\frac{1}{p}
$$

to the space of symmetric, positive-definite matrices, where $$p=-1$$ gives the harmonic mean, $$p=0$$ gives the geometric mean, and $$p=1$$ gives the usual arithmetic mean. In the SPD case, the geometric mean $$\bar{S}_{G}$$ is known to satisfy 

$$
    \bar{S}_G = \text{arg min} \sum_{i=1}^n d(x,S_i) 
$$

where $$d(x,y)$$ is the geodesic distance between two SPD matrices $$x$$ and $$y$$. This is analogous to the usual arithmetic mean of a set of real numbers, which is known to minimize the squared error. The case of $$p=0$$ is estimated by interpolating between the solution for $$p = .1$$ and $$p = -.1$$.

`method = 'riemannian'` accepts additional arguments `tol` giving the target error tolerance (default = .01) and `max.iter` giving the maximum number of iterations (default = 50).

Example:

```r
# Generate a set of covariance matrices using `linshrink` estimation to ensure positive-definiteness
x <- lapply(1:10, function(i) {
    spd.estimate(matrix(rnorm(100), ncol = 20), method = 'linshrink')
}) 

# Compute the mean
m <- spd.mean(x, method = 'riemannian', p = 0, tol = .01, max.iter = 50)
```
