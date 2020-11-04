#' Kernel svm for SPD matrices
#'
#' Functions trains a kernel SVM to a list of SPD matrices, and generates
#' predictions on a specified test set. The kernel matrix is constructed
#' by projecting the observations onto the tangent space at a basepoint p
#' and taking the inner-product given by the Riemannian metric. This can
#' be interpreted roughly as linearizing the space of SPD matrices around p
#' and fitting a linear svm. This function is more or less a wrapper around the
#' kernlab function \code{ksvm}.
#'
#' @param x A list of symmetric, positive-definite matrices
#' @param y A vector of labels
#' @param p The basepoint, on whose tangent space to project the elements of x
#' @param test.idx A vector of indices indicating the element of x to be witheld
#' for testing
#' @param ... Further arguments for kernlab::ksvm.
#' @return A data.frame with test set labels and predictions.

spd.svm <- function(x, y, p, test.idx, ...){

    # Check input
    if (!'spd.list' %in% input.type(x)){
        stop('Invalid input type')
    }
    if (!'spd.mat' %in% input.type(p)){
        stop('Invalid input type')
    }

    # Compute tangent vectors at p
    tan.vec <- lapply(x, spd.logmap, p = p)

    # p-inverse
    p.eig <- eigen(p)
    p.inv <- p.eig$vectors %*% diag(1/p.eig$values) %*% t(p.eig$vectors)

    # Kernel matrix
    tan.vec.premult <- lapply(tan.vec, function(i) i %*% p.inv)
    K <- as.matrix(proxy::simil(tan.vec.premult, method = function(i,j) {
        sum(diag(i %*% j))
    }))
    diag(K) <- sapply(tan.vec.premult, function(i) sum(diag(i %*% i)))
    Ktrain  <- as.kernelMatrix(K[-test.idx, -test.idx])

    # Fit model and generate prediction
    fit.train <- ksvm(Ktrain, y[-test.idx], kernel = 'matrix', ...)
    Ktest <- as.kernelMatrix(K[test.idx, -test.idx][,SVindex(fit.train), drop = F])
    prediction <- predict(fit.train, Ktest)

    # Create output dataframe
    df <- data.frame(Index = test.idx,
                     Label = y[test.idx],
                     Prediction = prediction)
    return(df)
}

