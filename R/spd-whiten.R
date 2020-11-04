#' Covariance whitening transform
#'
#' Whitens an SPD matrix using the procedure advocated by Ng, et al. (2014)
#'
#' @param x An SPD matrix to be whitened
#' @param p The SPD baseline whitening matrix
#' @param unwhiten Logical. If TRUE, reverses a previously applied whitening transform.
#' @return A symmetric, positive-definite matrix.

spd.whiten <- function(x, p, unwhiten = F){

    if (!'spd.mat' %in% input.type(x)){
        stop('x must be a positive definite matrix')
    }
    if (!'spd.mat' %in% input.type(p)){
        stop('p must be a positive definite matrix')
    }

    if (!unwhiten){
        p.inv.sqrt <- solve(sqrtm(p))
        return(p.inv.sqrt %*% x %*% p.inv.sqrt)
    } else if (unwhiten){
        p.sqrt <- sqrtm(p)
        return(p.sqrt %*% x %*% p.sqrt)
    }

}
