#' Projection onto the tangent space
#'
#' Function projects an SPD matrix x onto the tangent space at a point p
#'
#' @param x A symmetric positive definite matrix
#' @param p The point on whose tangent space to project x
#' @return A symmetric matrix.

spd.logmap <- function(x, p = NULL){

    if (!'spd.mat' %in% input.type(x)){
        stop('x must be a positive definite matrix')
    }

    if (is.null(p)) {
        p <- diag(rep(1,dim(x)[1]))
    } else if (!'spd.mat' %in% input.type(p)){
        stop('p must be a positive definite matrix')
    }

    p.sqrt <- sqrtm2(p)
    p.inv.sqrt <- isqrtm2(p)
    return(p.sqrt %*% logm2(p.inv.sqrt %*% x %*% p.inv.sqrt) %*% p.sqrt)

}
