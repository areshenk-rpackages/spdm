#' Interpolation between two symmetric, positive-definite matrices
#'
#' Function smoothly interpolates between two SPD matrices \code{x} and \code{y}.
#' The interpolation is parametrized by \code{t}, where \code{t=0} returns \code{x},
#' \code{t=1} returns \code{y}, and \code{t=.5} returns the mean of \code{x} and \code{y}
#'
#' @param x,y Symmetric, positive-definite matrices
#' @param t Interpolation parameter in \code{[0,infinity)}
#' @param method Type of interpolation (see details)
#' @details Allowable distance measures are
#' \itemize{
#'  \item{"euclidean": }{Euclidean interpolation \code{(1-t)x + ty}}
#'  \item{"logeuclidean": }{Euclidean interpolation in the tangent space.}
#'  \item{"riemannian": }{Interpolation along the geodesic path from \code{x} to \code{y}}
#' }
#' @export

spd.interpolate <- function(x, y, t, method = 'euclidean', ...){

    if (!'spd.mat' %in% input.type(x) | !'spd.mat' %in% input.type(y)){
        stop('Both inputs must be positive definite matrices')
    }
    if (t < 0){
        stop('t must be greater than 1')
    }

    # Wrapper
    i <- switch(method,
                euclidean    = spd.interpolate.euclidean(x, y, t, ...),
                logeuclidean = spd.interpolate.logeuclidean(x, y, t, ...),
                riemannian   = spd.interpolate.riemannian(x, y, t, ...))
    return(i)
}
