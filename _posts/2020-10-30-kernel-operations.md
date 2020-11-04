---
layout: page
title: "Kernel operations"
category: doc
date: 2020-10-30 13:02:24
mathjax: true
order: 6
---


**spdm** intends to implement clustering, classification, and pca (currently, only SVMs) in the space of SPD matrices using kernels based on the Riemannian metric. The methods are implemented as wrappers around the corresponding functions in `kernlab`.

<h4>Kernel</h4>

Kernel methods are based on the Riemannian metric on the SPD manifold. Namely, given two tangent vectors (symmetric matrices) $$X$$ and $$Y$$ at an SPD matrix $$P$$, their inner-product is

$$
    K(X,Y) = \mathrm{tr}(XP^{-1}YP^{-1})
$$

When constructing the kernel matrix, a set of SPD matrices is projected onto the tangent space at the basepoint $`P`$. Typically, this would be chosen to be the mean of the training samples, so as to minimize the distortions caused by linearizing around $$P$$.

<h4>kSVM</h4>

Fitting a kernel SVM is accomplished through the function `spd.svm`, which is little more than a wrapper around `kernlab::ksvm`, with the addition of a custom kernel matrix. As such, the reader should study the kernlab documentation for more detailed instructions. `spd.svm` accepts a list `x` of SPD matices, and vector `y` of labels (either factors or numeric, for classification or regression), an SPD matrix `p` (the basepoint), and a vector of indices `test.idx` indicated observation to be held out for testing. Further arguments can be passed to `kernlab::ksvm` through `...`

```r
x <- lapply(1:20, function(i) cov(matrix(rnorm(100*10), ncol = 10)))
y <- rnorm(20)
p <- spd.mean(x, method = 'riemannian')
test.idx <- 1:5

spd.svm(x, y, p, test.idx)
```

The function returns a dataframe containing the test labels and predictions.

```
  Index       Label  Prediction
1     1 -0.16271578  0.06136029
2     2  1.85902017  0.32071303
3     3 -0.27696783 -0.02236058
4     4  0.08344203 -0.31618511
5     5  0.39559377 -0.23699512
```




