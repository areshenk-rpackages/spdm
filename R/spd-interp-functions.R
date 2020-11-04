# Interpolation functions
spd.interpolate.euclidean <- function(x, y, t, ...){
    return((1-t)*x + t*y)
}

spd.interpolate.logeuclidean <- function(x, y, t, ...){
    return(expm((1-t)*logm2(x) + t*logm2(y)))
}

spd.interpolate.riemannian <- function(x, y, t, ...){
    x.inv.sqrt <- solve(sqrtm(x))
    x.sqrt     <- sqrtm(x)
    return(x.sqrt %*% mat.frac.pow(x.inv.sqrt %*% y %*% x.inv.sqrt, t) %*% x.sqrt)
}