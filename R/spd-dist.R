#' Distance between two symmetric, positive-definite matrices
#'
#' Function implements several distance measures between symmetric,
#' positive-definite matrices.
#'
#' @param x,y Symmetric, positive-definite matrices
#' @param method The distance measure. See details.
#' @details Allowable distance measures are
#' \itemize{
#'  \item{"euclidean": }{The Frobenius norm of the difference \code{x-y}.}
#'  \item{"logeuclidean": }{The Frobenius norm of the difference \code{log(x)-log(y)} in the tangent space.. }
#'  \item{"cholesky": }{The Frobenius norm of the difference between the cholesky factors
#'  of \code{x} and \code{y}. Not affinely invariant.}
#'  \item{"riemannian": }{The Riemmanian distance proposed by Barachant, et al. (2013)}
#'  \item{"stein": }{The square root of Jensen-Bregman log determinant divergence}
#' }

spd.dist <- function(x, y, method = 'euclidean', ...){

    if (!'spd.mat' %in% input.type(x) | !'spd.mat' %in% input.type(y)){
        stop('Both inputs must be positive definite matrices')
    }

    if (!method %in% c('euclidean', 'logeuclidean', 'cholesky',
                       'riemannian', 'stein')){
        stop('Unrecognized method')
    }

    # Wrapper
    d <- switch(method,
                euclidean    = spd.dist.euclidean(x, y, ...),
                logeuclidean = spd.dist.logeuclidean(x, y, ...),
                cholesky     = spd.dist.cholesky(x, y, ...),
                riemannian   = spd.dist.riemannian(x, y, ...),
                stein        = spd.dist.stein(x, y, ...))
    return(d)
}
