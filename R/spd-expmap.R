#' Projection from the tangent space
#'
#' Function projects a tangent vector x (a symmetric matrix) at a point p
#' onto the space of SPD matrices.
#'
#' @param x A symmetric matrix
#' @param p The point to whose tangent space x belongs
#' @return A symmetric, positive-definite matrix.

spd.expmap <- function(x, p = NULL){

    if (!'s.mat' %in% input.type(x)){
        stop('x must be a positive definite matrix')
    }
    if (is.null(p)) {
        p <- diag(rep(1,dim(x)[1]))
    } else if (!'spd.mat' %in% input.type(p)){
        stop('p must be a positive definite matrix')
    }

    p.sqrt <- sqrtm2(p)
    p.inv.sqrt <- solve(p.sqrt)
    return(p.sqrt %*% expm2(p.inv.sqrt %*% x %*% p.inv.sqrt) %*% p.sqrt)

}
