spd.transport.pt <- function(x, from, to, nsteps) {

    # Generate discrete geodesic from source to target
    geod <- lapply(seq(0, 1, length.out = nsteps+1)[-1], function(i) {
        spd.interpolate(from, to, t = i, method = 'riemannian')
    })

    # Iterate over rungs
    trans <- spd.expmap(x, from)
    source <- from
    for (i in 1:nsteps){
        m <- spd.interpolate(trans, geod[[i]], t = .5, method = 'riemannian')
        trans  <- spd.interpolate(source, m, t = 2, method = 'riemannian')
        source <- geod[[i]]
    }

    return(spd.logmap(trans, p = to))

}

spd.transport.gl <- function(x, from, to){
    G <- sqrtm2(to) %*% isqrtm2(from)
    return(G %*% x %*% t(G))
}
