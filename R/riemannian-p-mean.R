spd.mean.p.est <- function(x, p = .5, tol = .01, max.iter = 20){

    n   <- length(x)
    k   <- dim(x[[1]])[1]
    phi <- .375 / abs(p)

    # Initialize mean to mutually commutative case
    X <- Reduce(`+`, lapply(x, mat.frac.pow, p)) / n
    X <- mat.frac.pow(X, 1/p)

    # Input matrices, depending on sign(p)
    if (p > 0){
        C <- x
    } else if (p < 0){
        C <- lapply(x, solve)
    }

    # Iterate until convergence
    err <- 2*tol
    iter <- 1
    while (err > tol & iter <= max.iter){

        # Update
        H <- Reduce(`+`,
                    lapply(C, function(i) {
                        expm2(abs(p) * logm2(X %*% i %*% t(X)))
                    })) / n

        X <- expm2(-phi * logm2(H)) %*% X

        # Error update
        iter <- iter + 1
        err <- 1/sqrt(n) * norm(H - diag(rep(1, k)), type = 'F')

    }

    if (iter >= max.iter){
        warning(paste('Max iterations reached with err = ', err,
                      '\nMay not have converged.', sep = ''))
    }

    # Return
    if (p > 0){
        X.inv <- solve(X)
        return(X.inv %*% t(X.inv))
    } else if (p < 0){
        return(t(X) %*% X)
    }

}
