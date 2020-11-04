logm2 <- function(x){
    #lx <- logm(x)
    e  <- eigen(x)
    lx <- e$vectors %*% diag(log(e$values)) %*% t(e$vectors)
    return((lx + t(lx))/2)
}

expm2 <- function(x){
    #ex <- expm(x)
    e  <- eigen(x)
    ex <- e$vectors %*% diag(exp(e$values)) %*% t(e$vectors)
    return((ex + t(ex))/2)
}

sqrtm2 <- function(x){
    #ex <- expm(x)
    e  <- eigen(x)
    sx <- e$vectors %*% diag(sqrt(e$values)) %*% t(e$vectors)
    return((sx + t(sx))/2)
}

isqrtm2 <- function(x){
    #ex <- expm(x)
    e  <- eigen(x)
    sx <- e$vectors %*% diag(1/sqrt(e$values)) %*% t(e$vectors)
    return((sx + t(sx))/2)
}
