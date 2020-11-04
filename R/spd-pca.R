#' Kernel pca for SPD matrices
#'
#' Function performs kernel principal component analysis on a set of symmetric,
#' positive-definite matrices using an rbf kernel: \code{exp(-sigma * d(i,j)^2)},
#' where \code{d(i,j)} is a distance function implemented by \code{spd.dist}.
#' This function is more or less a wrapper around the kernlab function \code{kpca.}
#'
#' @param x A list of symmetric, positive-definite matrices
#' @param method The type of distance. See \code{spd.dist}, but also see
#' details. Defaults to "logeuclidean".
#' @param sigma scale parameter for rbf kernel
#' @param ... Further arguments for kernlab::kpca.
#' @details Function performs kpca using a rbf kernel, where the distance between
#' two inputs is given by \code{method}. Note that only "euclidean" and "logeuclidean"
#' have been proven to give rise to positive-definite kernels for all values of sigma, although any distance
#' implemented in \code{spd.dist} may be used. Anecdotally, \code{method = "riemannian"}
#' often achieves superior performance.
#' @return An S4 object of class kpca.

spd.pca <- function(x, method = 'euclidean', sigma = 1, ...){

    # Check input
    if (!'spd.list' %in% input.type(x)){
        stop('Invalid input type')
    }

    # Vectorize inputs
    vecs <- t(sapply(x, function(i) spd.vectorize(i, scaling = F)))

    # Fit kPCA
    fit <- kpca(vecs, kernel = 'spddot',
                kpar = list(sigma = sigma, method = method), ...)
    return(fit)
}
