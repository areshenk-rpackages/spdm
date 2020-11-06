#' Compute (partial) correlations
#'
#' Transforms an SPD matrix into a matrix of partial correlations
#'
#' @param x An SPD matrix to be whitened
#' @param method A string specifying either "correlation" (default) orf
#' "partial" correlation.
#' @return A symmetric, positive-definite matrix.
#' @export

spd.correlation <- function(x, method = 'correlation'){

    if (!'spd.mat' %in% input.type(x)){
        stop('x must be a positive definite matrix')
    }

    # Correlation matrix
    s <- diag(1/sqrt(diag(x)))
    x <- s %*% x %*% s
    if (method == 'correlation'){
        return(x)
    } else if (method == 'partial'){
        x.inv <- solve(x)
        sc    <- diag(x.inv) %o% diag(x.inv)
        return(x.inv / sqrt(sc))
    } else {
        stop('Unrecognized method')
    }
}
