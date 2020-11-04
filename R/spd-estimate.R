#' Covariance estimation
#'
#' Function implements several forms of  covariance estimation.
#'
#' @param x A data matrix, where rows are observations and columns are variables
#' @param method Method of covariance estimation. See details
#' @param ... Additional arguments passed toe stimation functions. See details.
#' @details Allowable estimation methods are:
#' \itemize{
#'  \item{"sample": }{The ordinary sample covariance. Generally a poor choice in
#'  anything but very low dimensional settings, and is not guaranteed to be positive-definite.}
#'  \item{"linshrink": }{Linear shrinkage estimator proposed by Ledoit and Wolf (2004)}
#'  \item{"nlshrink": }{Non-linear shrinkage estimator proposed by Ledoit and Wolf (2012)}
#'  \item{"glasso": }{Graphical lasso (glasso) estimation using the huge package.
#'  Typically generates sparse estimates.}
#' }
#' Additional arguments may be passed to the functions which perform estimation.
#' Specifically:
#' \itemize{
#'  \item{"sample": }{Uses \code{cov(x, ...)}}
#'  \item{"linshrink": }{Uses \code{nlshrink::linshrink_cov(x, ...)}}
#'  \item{"nlshrink": }{Uses \code{nlshrink::nlshrink_cov(x, ...)}}
#'  \item{"glasso": }{Uses \code{huge(x, method = 'glasso', cov.output = T, ...)}
#'  followed by \code{huge.select(x, ...)}. Note that \code{method} cannot be
#'  overridden, as other estimation methods do not return covariance estimates.
#'  Additional arguments to \code{huge()} or \code{huge.select()} should be
#'  prepended with \code{huge.} or \code{select.}, respectively.}
#' }
#' In all cases, function will generate a warning if the estimated matrix is
#' not positive definite.
#' @return A covariance matrix


spd.estimate <- function(x, method = 'linshrink', ...){

    if (!is.matrix(x)){
        stop('Input x must be a matrix')
    }

    e <- switch(method,
                sample    = spd.estimate.sample(x, ...),
                linshrink = spd.estimate.linshrink(x, ...),
                nlshrink  = spd.estimate.nlshrink(x, ...),
                glasso    = spd.estimate.glasso(x, ...))

    if (!is.spd(e)){
        warning('Estimate is not positive-definite')
    }

    return(e)
}
