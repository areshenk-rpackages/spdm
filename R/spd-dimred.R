#' Dimension reduction
#'
#' Wrapper function for dimension reduction on SPD matrices.
#'
#' @param X A list of SPD matrices.
#' @param method Method of dimension reduction. See details
#' @param ... See details.
#' @details Allowable methods are:
#' \itemize{
#'  \item{"congedo": }{Method proposed by Congedo et al. 2017. Maps a set of SPD
#'  matrices onto a set of lower dimensional SPD matrices. Useful as a preprocessing
#'  step for techniques which scale poorly with the dimension of the covariance
#'  matrix.}
#'  \item{"pga": }{Principal geodesic analysis (PGA) using the algorithm proposed
#'  by Fletcher and Joshi (2004). Projects data onto the tangent space around the
#'  sample mean, and estimates principal geodesics by applying PCA to tangent vectors.}
#' }
#' Additional arguments may be passed to the functions which perform estimation.
#' Specifically:
#' \itemize{
#'  \item{"congedo": }{`k` gives the dimension of the output space. By default,
#'  `k=2`.}
#'  \item{"pga": }{`k` gives the dimension of the output space. By default,
#'  `k=2`.}
#' }
#'
#' @return \itemize{
#'  \item{"congedo": }{A named list containing a list `Xred` of dimension
#'  reduced covariance matrices, and a `n x k` matrix `Z` of components.}
#'  \item{"pga": }{A named list containing the sample mean, the components (unit
#'  tangent vectors at the mean), the associated eigenvalues, variance explained,
#'  and the component scores of each observation.}
#' }
#' @export

spd.dimred <- function(X, method, ...){

if (!method %in% c('congedo', 'pga'))
    stop('Unrecognized method')

if (!all(sapply(X, is.matrix))){
    stop('X must contain only matrices')
}

if (any(diff(t(sapply(X, dim))) != 0)){
    stop('All matrices in X must have the same dimensions')
}

e <- switch(method,
            congedo = spd.dimred.congedo(X, ...),
            pga = spd.dimred.pga(X, ...))

return(e)
}
