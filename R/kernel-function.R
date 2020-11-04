spddot <- function(sigma = 1, method = 'logeuclidean'){

    rval <- function(x, y = NULL){

        # Type checking
        if (!is(x,"vector")) stop("x must be a vector")
        if (!is(y,"vector") && !is.null(y)) stop("y must a vector")
        if (is(x,"vector")  && is.null(y)){
            return(1)
        }

        # Compute kernel
        if (is(x,"vector") && is(y,"vector")){
            if (length(x) != length(y)){
                stop("number of dimensions must be the same for both data points")
            }
            d <- spd.dist(spd.vectorize(x),
                          spd.vectorize(y),
                          method = method)
            return(exp(-sigma * d^2))
        }
    }
    return(new("spdkernel", .Data = rval, kpar = list(sigma = sigma, method = method)))
}
setClass("spdkernel",
         prototype = structure(.Data = function(){},
                               kpar  = list()),
         contains = c("kernel"))

