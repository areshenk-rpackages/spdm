spd.dimred.congedo <- function(X, k = 2, ...){

    n <- length(X)
    S <- matrix(0, nrow = nrow(X[[1]]), ncol = ncol(X[[1]]))
    W <- matrix(1/n, n, n)
    Xisqrt <- lapply(X, isqrtm2)
    for (i in 1:n) {
        for (j in 1:i) {
            L <- logm2(Xisqrt[[i]] %*% X[[j]] %*% Xisqrt[[i]])
            S <- S + W[i,j] * L %*% L
        }
    }
    Z <- eigen(S)$vectors[,1:k]

    Xred <- lapply(X, function(i) t(Z) %*% i %*% Z)
    ret <- list(Xred = Xred, Z = Z)
    return(ret)
}

spd.dimred.pga <- function(X, k = 2, ...) {

    # Compute tangent vectors
    n  <- length(X)
    p  <- nrow(X[[1]])
    m  <- spd.mean(X, method = 'riemannian')
    Xt <- sapply(X, function(x)
        as.numeric(spd.logmap(x, p = m)))

    # PGA
    fit <- svd(Xt)
    components  <- lapply(1:k, function(i) matrix(fit$u[,i], p, p))
    eigenvalues <- fit$d^2
    varexp <- eigenvalues/sum(eigenvalues)
    scores <- fit$v[,1:k]

    ret <- list(Mean = m, Components = components,
                Eigenvalues = eigenvalues[1:k],
                Varexp = varexp[1:k], Scores = scores)

    return(ret)
}
