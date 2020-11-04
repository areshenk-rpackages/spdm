---
layout: page
title: "Estimation"
category: doc
date: 2020-10-30 12:44:52
mathjax: true
order: 1
---

**spdm** implements several types of covariance estimation through the `spd.estimate()` function, which acts as a wrapper around estimators from different R packages. The function is called as follows
```r
spd.estimate(x, method = c('sample', 'linshrink', 'nlshrink', 'glasso'), ...)
```
and accepts an $$n$$ observations by $$p$$ variables numeric matrix `x`, a character string `method` specifying the estimator, and any additional arguments `...`. The list of supported estimators is below. In all cases, `spd.estimate()` will return a warning if the estimate is not positive-definite.

<h4>sample</h4>

The standard sample covariance matrix, computed by calling `cov(x, ...)`. Implemented to allow easy comparison between the sample covariance and other estimators within **spdm**, although the sample covariance is generally a poor estimator, and is not guaranteed to be positive-definite. It's use is not recommended unless there are several times more observations than variables.

Example:
```r
x <- matrix(rnorm(100), ncol = 20)
S <- spd.estimate(x, method = 'sample')
```

<h4>linshrink (default)</h4>

The linear shrinkage estimator proposed by Ledoit and Wolf (2004), and implemented by the **nlshrink** package using `linshrink_cov(x, ...)`. It is a convex combination of the sample covariance matrix and the identity matrix, equivalent to linearly shrinking the eigenvalues of the sample covariance to their mean.

Example:
```r
x <- matrix(rnorm(100), ncol = 20)
S <- spd.estimate(x, method = 'linshrink')
```

<h4>nlshrink</h4>

The non-linear shrinkage estimator proposed by Ledoit and Wolf (2012), and implemented by the **nlshrink** package using `nlshrink_cov(x, ...)`. Equivalent to non-linearly shrinking the eigenvalues of the sample covariance to their mean. Although the authors find that this estimator generally achieves superior performance to **linshrink**, **nlshrink** can be substantially slower, and so is not used as the default.

<h4>glasso</h4>

The graphical lasso estimate proposed by Friedman, Hastie, and Tibishiranit (2007), implemented by the **huge** package, and generally used for the estimation of Gaussian graphical models. Roughly, the Glasso operates by estimating a sparse inverse covariance matrix using an $$\ell_1$$-penalty. 

Glasso model fitting and selection involve a rather large number of possible tuning parameters, all of which can be provided by passing additional arguments to `spd.estimate()`. The user should study the **huge** package documentation in detail for instructions. 

The internal function calls are roughly
```r
huge.fit <- huge(x, method = 'glasso', cov.output = T, ...)
S <- huge.select(huge.fit, ...)$opt.cov
return(S)
```
Arguments to `huge()` should be prepended with `huge.`, while arguments to `huge.select()` should be prepended with `select.`. The user should note that not all estimation/selection settings result in the exporting of a covariance matrix, in which case the function will return an error.

Example:
```r
x <- matrix(rnorm(100), ncol = 20)
S <- spd.estimate(x, method = 'glasso', huge.scr = T, select.criterion = 'ebic')
```

