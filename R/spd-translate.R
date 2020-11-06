#' Translation of a covariance matrix
#'
#' Translates a covariance matrix from one basepoint to another, Formally,
#' projects a covariance matrix onto the tangent space at one basepoint,
#' transports to the tangent space at the second basepoint, and projects back onto
#' the space of SPD marices.
#'
#' @param x A symmetric, positive-definite matrix
#' @param from The SPD matrix to whose tangent space x belong
#' @param to The SPD matrix to whose tangent space to move x
#' @param ... Additional arguments to spd.transport
#' @return A symmetric, positive-definite matrix
#' @export

spd.translate <- function(x, from, to = NULL, ...) {

    if (!'spd.mat' %in% input.type(x)){
        stop('x must be a positive definite matrix')
    }
    if (!'spd.mat' %in% input.type(to)){
        stop('to must be a positive definite matrix')
    }
    if (!'spd.mat' %in% input.type(from)){
        stop('from must be a positive definite matrix')
    }

    tanvec <- spd.logmap(x, p = from)
    tanvec.tr <- spd.transport(tanvec, from = from, to = to, ...)
    x.tr <- spd.expmap(tanvec.tr, p = to)
    return(x.tr)

}
