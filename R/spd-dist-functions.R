# Distance functions
spd.dist.euclidean <- function(x,y,...){
    norm(x - y, type = 'F')
}

spd.dist.logeuclidean <- function(x,y,...){
    norm(logm2(x) - logm(y), type = 'F')
}

spd.dist.cholesky <- function(x,y){
    norm(chol(x) - chol(y), type = 'F')
}

spd.dist.riemannian <- function(x,y,...){

    g <- geigen(x, y, symmetric = T)$values
    d <- sqrt(sum( (10*log10(g))^2 ))
    return(d)
    # x.inv.sqrt <- sqrtm(solve(x))
    # z <- x.inv.sqrt %*% y %*% x.inv.sqrt
    # return(norm(logm2(x.inv.sqrt %*% y %*% x.inv.sqrt), type = 'F'))
}

spd.dist.stein <- function(x,y,...){
    d <- log(det( (x+y)/2 )) -.5 * log(det(x%*%y))
    return(sqrt(d))
}
