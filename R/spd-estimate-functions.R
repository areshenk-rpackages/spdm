#' @importFrom nlshrink linshrink_cov nlshrink_cov
#' @importFrom huge huge huge.select

spd.estimate.sample <- function(x, ...){
    cov(x, ...)
}

spd.estimate.linshrink <- function(x, ...){
    linshrink_cov(x, ...)
}

spd.estimate.nlshrink <- function(x, ...){
    nlshrink_cov(x, ...)
}

spd.estimate.glasso <- function(x, ...){

    pars <- list(...)

    pars.huge <- pars[grepl(pattern = 'huge.', names(pars), fixed = T)]
    pars.huge$huge.method      <- 'glasso'
    pars.huge$huge.cov.output  <- TRUE

    pars.select <- pars[grepl(pattern = 'select.', names(pars), fixed = T)]
    pars.select$verbose <- FALSE

    names(pars.huge) <- sapply(names(pars.huge), function(i) {
        gsub('huge.', '', i, fixed = T)
    })
    names(pars.select) <- sapply(names(pars.select), function(i) {
        gsub('select.', '', i, fixed = T)
    })

    huge.fit <- do.call(huge, c(list(x = x), pars.huge))
    S <- as.matrix(do.call(huge.select, c(list(huge.fit), pars.select))$opt.cov)
    return(S)
}
