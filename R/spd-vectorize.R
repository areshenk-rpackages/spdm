#' Vectorize and unvectorize a matrix
#'
#' Function converts between a square symmetric matrix and a vector of the
#' lower triangular elements + diagonal. Allows optional scaling of the off-diagonal
#' entries in order to preserve the norm.
#'
#' @param x Either a square matrix, or a vector contains the lower triangular
#' elements of x (including the diagonal elements)
#' @param scaling If TRUE, scales the off diagonal elements by sqrt(2) to preserve
#' the norm of the resulting vector
#' @details If input is a square matrix, converts the lower triangular elements
#' (including the diagonal) into a numeric vector. If input is a numeric vector,
#' converts the input to a symmetric matrix. Note that, if the input is a vector,
#' its length must be a triangular number.
#' @export

spd.vectorize <- function(x, scaling = F){

    # If input is a matrix, vectorize
    if (is.matrix(x)){

        if (dim(x)[1] != dim(x)[2]){
            stop('Input must be a square matrix')
        }

        n  <- dim(x)[1]
        if (scaling){
            x[lower.tri(x)] <- sqrt(2) * x[lower.tri(x)]
        }
        return(x[lower.tri(x, diag = T)])

    # If input is a vector, check triangular, then vectorize
    } else if (is.vector(x)) {

        n <- length(x)
        if (sqrt(8*n + 1) %% 1 != 0){
            stop('Length of x must be a triangular number')
        }

        k <- (sqrt(8*n + 1) - 1)/2
        y <- matrix(0, k, k)
        y[lower.tri(y, diag = T)] <- x
        if (scaling){
            y[lower.tri(y)] <- y[lower.tri(y)]
        }
        return(y + t(y) - diag(diag(y)))

    }

}
