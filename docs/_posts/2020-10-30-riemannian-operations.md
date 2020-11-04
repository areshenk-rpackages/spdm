---
layout: page
title: "Riemannian operations"
category: doc
date: 2020-10-30 13:01:50
mathjax: true
order: 5
---

The functions `spd.logmap()` and `spd.expmap()` implement the logarithm and exponential maps, respectively, at a basepoint `p`. Given spd.matrices `x` and `p`, `spd.logmap(x, p)` returns a tangent vector (a symmetric matrix) located at `p`, equal to the projection of `x` onto the tangent space at `p`. Often, this operation is interpreted as the linearization of the SPD manifold around `p`. The projection of a tangent vector `y` at `p` back onto the SPD manifold is accomplished using `spd.expmap(y, p)`.

## Transport

**spdm** can transport tangent vectors between tangent spaces using the function `spd.transport(x, from, to, method)`, where `x` is a symmetric matrix (a tangent vector), and `from` and `to` are SPD matrices. The following two forms of transport are currently implemented:

### Parallel Transport

Setting `method = "pt"` uses the Schild's ladder algorithm to parallel transport a tangent vector along a geodesic between two SPD matrices. An additional argument `nsteps` sets the number of steps used in the Schild's ladder algorithm.

```r
spd.transport(x, from, to, method = 'pt', nsteps = 10)
```

### GL(n) Action

The metric on the Riemannian manifold $$\mathcal{S}_{++}$$ of SPD matrices is invariant under the $$GL_n(\mathbb{R})$$ action

$$
\phi: GL_n(\mathbb{R}) \times \mathcal{S}_{++} \rightarrow \mathcal{S}_{++}
$$

$$
\phi_G(\Sigma) = G \Sigma G^\top
$$

Zhao et al. (2018) propose to transport a tangent vector $$V$$ from $$S_1$$ to $$S_2$$ using the differential

$$
d\phi_G(V) = G V G^\top,
$$

and setting $$G = S_2^{1/2}S_1^{-1/2}$$, giving the transport

$$
d\phi_{S_1 \rightarrow S_2}(V) = S_2^{1/2} S_1^{-1/2} V S_1^{-1/2} S_2^{1/2}
$$

This can be done by setting `method = "gl"`
```r
spd.transport(x, from, to, method = 'gl')
```

<h4>References</h4>

Zhao, Q., Kwon, D., & Pohl, K. M. (2018, September). A Riemannian Framework for Longitudinal Analysis of Resting-State Functional Connectivity. In International Conference on Medical Image Computing and Computer-Assisted Intervention (pp. 145-153). Springer, Cham.
