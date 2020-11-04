#' Check if a matrix is symmetric and positive definite

#' @param ... One or more numeric matrices
#' @param tol Numerical tolerance for checking symmetry and positive definiteness
#' @details Function checks whether the matrix \code{x} is symmetric and positive
#' definite. Symmetry is evaluated up to an entrywise tolerance of \code{tol}, so
#' that differences smaller than \code{tol} are ignored. Positive-definiteness is
#' checked by computing the eigenvalues of \code{x} using \code{eigen}, setting
#' eigenvalues smaller than \code{tol} in absolute value to zero, and then checking
#' whether any are less than or equal to zero.
#'
#' @return A Boolean value indicating whether the matrix is symmetric and positive
#' definite


is.spd <- function(..., tol = 1e-8){

    data <- list(...)

    check <- sapply(data, function(i) {

        # Test if matrix
        if (!is.matrix(i)){
            return(FALSE)
        }

        # Test if symmetric
        if (!isSymmetric(i, tol = tol)){
            return(FALSE)
        }

        # Test if positive definite
        eig <- eigen(i, symmetric = T, only.values = T)$values
        eig[abs(eig) <= tol] <- 0
        if (any(eig <= 0)){
            return(FALSE)
        }

        return(TRUE)
    })

}
