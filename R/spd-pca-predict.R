#' Prediction for SPD kernel PCA
#'
#' Function accepts a fitted kpca object returned by \code{spd.pca} and a list of
#' SPD matrices and returns a matrix of estimated principal component scores.
#'
#' @param fit An object of class kpca return by spd.pca
#' @param x A list of SPD matrices for which to derive component scores.
#' @return A matrix of principal component scores

spd.pca.predict <- function(fit, x){

    # Check input
    if (!'spd.list' %in% input.type(x)){
        stop('Invalid input type')
    }

    # Vectorize inputs
    vecs <- t(sapply(x, function(i) spd.vectorize(i, scaling = F)))
    return(predict(fit, vecs))
}
