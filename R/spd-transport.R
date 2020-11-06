#' Transport a tangent vector
#'
#' Transports a tangent vector from one tangent space to another.
#'
#' @param x A tangent vector (a symmetric matrix)
#' @param from The SPD matrix to whose tangent space x belong
#' @param to The SPD matrix to whose tangent space to move x
#' @param method See details
#' @param nsteps For parallel transport, the number of steps along the geodesic
#' connecting from and to
#' @details Allowable method are
#' \itemize{
#'  \item{"pt": }{Parallel transport using the Schild's ladder algorithm}
#'  \item{"gl": }{Transport from A to B using the GL(n) action \eqn{A -> GAG'}, where
#'  \eqn{G = B^{1/2}A^{-1/2}}}
#' }
#' @return A symmetric matrix -- a tangent vector at to.
#' @export

spd.transport <- function(x, from, to = NULL, method = 'gl', nsteps = NA){

    if (!'s.mat' %in% input.type(x)){
        stop('x must be a positive definite matrix')
    }
    if (!'spd.mat' %in% input.type(to)){
        stop('to must be a positive definite matrix')
    }
    if (!'spd.mat' %in% input.type(from)){
        stop('from must be a positive definite matrix')
    }
    if (!method %in% c('pt', 'gl')) {
        stop('Unrecognized method')
    }
    if (method == 'pt') {
        if (is.na(nsteps) || nsteps <= 0) {
            stop('For parallel transport, nsteps must be a positive integer')
        }
    }

    # Wrapper
    i <- switch(method,
                pt    = spd.transport.pt(x, from, to, nsteps),
                gl    = spd.transport.gl(x, from, to))
    return(i)
}
