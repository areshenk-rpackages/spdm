# For fractional powers...
mat.frac.pow <- function(x, p){
    d <- eigen(x)
    return(d$vectors %*% diag(d$values^p) %*% solve(d$vectors))
}

