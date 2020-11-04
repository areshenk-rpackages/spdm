# Mean functions
spd.mean.euclidean <- function(x, ...){
    Reduce(`+`, x)/length(x)
}

spd.mean.logeuclidean <- function(x, ...){
    expm2(Reduce(`+`, lapply(x, logm2))/length(x))
}

spd.mean.riemannian <- function(x, p = 0, tol = .01, max.iter = 50){

    if (p < -1 | p > 1){
        stop('p must lie in the interval [-1,1]')
    }

    if (p == 0){
        mu <- spd.mean.p.est(x, p = p+.1, tol = tol, max.iter = max.iter)
        ml <- spd.mean.p.est(x, p = p-.1, tol = tol, max.iter = max.iter)
        return(spd.interpolate(mu, ml, t = .5, method = 'riemannian'))
    } else {
        return(spd.mean.p.est(x, p = p-.1, tol = tol, max.iter = max.iter))
    }

}
