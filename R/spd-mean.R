#' Compute the mean of a set of spd matrices
#'
#' Function computes the mean of a set of symmetric positive-definite matrices.
#' Several methods are implemented, as described in \code{Details}.
#'
#' @param x A list of symmetric, positive-definite matrices
#' @param method The type of mean to compute. See details
#' @param ... Further arguments. See details
#' @details Function computes the mean of a set of symmetrix, positive-definite
#' matrices. Several methods are implemented:
#' \itemize{
#'  \item{"euclidean": }{The ordinary arithmetic mean -- the sum of the matrices in x,
#'  divided by the number of matrices. This is guaranteed to be an spd matrix, but
#'  does not necessarily preserve the spectral characteristics of the individual matrices.}
#'  \item{"logeuclidean": }{Computed by taking the arithmetic mean of the logarithms
#'  of the matrices in \code{x}, and then projecting back onto the space of spd matrices.
#'  In general, better behaved than the arithmetic mean.}
#'  \item{"riemannian": }{The Riemmanian p-mean. Smoothly interpolates between the
#'  harmonic mean at \code{p = -1} to the geometric mean at \code{p = 0} to the
#'  arithmetic mean at \code{p = 1}.
#'  Is approximated iteratively using the fixed point algorithm described by
#'  Congedo, Barachant and Koopaei (2017). Requies a parameter \code{p} in the interval
#'  \code{[-1,1]} specifying the type of mean, a maximum error tolerance \code{tol}
#'  (default .01), and a maximum number of iterations (default 50). The case
#'  \code{p = 0} is approximated by computing the p-means at -.1 and .1, and then
#'  returning the midpoint between them using \code{spd.interpolate(..., method = 'riemannian')}}
#' }
#' @return The mean of the matrices in \code{x}.
#' @export

spd.mean <- function(x, method = 'euclidean', ...){

    if (!'spd.list' %in% input.type(x)){
        stop('Invalid input type')
    }

    if (!method %in% c('euclidean', 'logeuclidean', 'riemannian')){
        stop('Unrecognized method')
    }

    # Wrapper
    m <- switch(method,
                euclidean    = spd.mean.euclidean(x, ...),
                logeuclidean = spd.mean.logeuclidean(x, ...),
                riemannian   = spd.mean.riemannian(x, ...))
    return(m)

}
