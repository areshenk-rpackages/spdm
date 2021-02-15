---
layout: default
title: "About"
---

`spdm` is an R package containing tools for the manipulation and analysis of symmetric, positive-definite matrices (aka covariance matrices). It implements regularized covariance estimation, several means and distance measures, as well as the exponential and logarithmic maps on the Riemannian manifold of covariance matrices.

## Installation
The package can be installed directly from the Gitlab repository using the `devtools` package with

```r
devtools::install_git('https://github.com/areshenk-rpackages/spdm')
```

Alternately, the repository can be cloned to a local machine and installed through the terminal by running

```
R CMD INSTALL spdm
```
in the directory containing the folder.
