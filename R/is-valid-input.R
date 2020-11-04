is.valid.input <- function(x, type){

    if (type == 'spd.mat'){

        if (!is.numeric(x) | !is.matrix(x)) return(FALSE)
        if (any(Im(x) != 0)) return(FALSE)
        if (!is.spd(x)) return(FALSE)

    } else if (type == 's.mat') {

        if (!is.numeric(x) | !is.matrix(x)) return(FALSE)
        if (any(Im(x) != 0)) return(FALSE)
        if (dim(x)[1] != dim(x)[2]) return(FALSE)
        if (!isSymmetric(x)) return(FALSE)

    } else if (type == 'spd.list'){

        if (!is.list(x)) return(FALSE)
        if (!length(x) > 1) return(FALSE)
        if (any(sapply(x, is.null))) return(FALSE)
        chk <- sapply(x, function(i) {
            if (!is.numeric(i) | !is.matrix(i)) return(FALSE)
            if (any(Im(i) != 0)) return(FALSE)
            if (dim(i)[1] != dim(i)[2]) return(FALSE)
            if (!is.spd(i)) return(FALSE)
            return(TRUE)
        })
        if (any(!chk)) return(FALSE)
        if (length(unique(sapply(x, function(i) dim(i)[1]))) > 1) return(FALSE)

    } else if (type == 's.list') {

        if (!is.list(x)) return(FALSE)
        if (!length(x) > 1) return(FALSE)
        if (any(sapply(x, is.null))) return(FALSE)
        chk <- sapply(x, function(i) {
            if (!is.numeric(i) | !is.matrix(i)) return(FALSE)
            if (any(Im(i) != 0)) return(FALSE)
            if (dim(i)[1] != dim(i)[2]) return(FALSE)
            if (!isSymmetric(i)) return(FALSE)
            return(TRUE)
        })
        if (any(!chk)) return(FALSE)
        if (length(unique(sapply(x, function(i) dim(i)[1]))) > 1) return(FALSE)

    }

    return(TRUE)
}

input.type <- function(x){

    if (!is.matrix(x) & !is.list(x)){
        stop('Input must be either a matrix or a list of matrices')
    }

    # Check input type
    type <- c('spd.mat', 's.mat', 'spd.list', 's.list')
    chk <- sapply(type, function(i) {
        is.valid.input(x, i)
    })

    if (!any(chk)){
        stop('Invalid input type. Probably, input matrix fails to be symmetric')
    } else {
        return(type[which(chk)])
    }

}
