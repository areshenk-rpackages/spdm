context("Input detection")

# Positive definite matrix
x.spd  <- matrix(c(1,.5,.5,1), ncol = 2)
x.s    <- matrix(c(-1,.5,.5,-1), ncol = 2)
x.spdl <- lapply(1:5, function(i) x.spd)
x.sl   <- x.spdl; x.sl[[1]] <- x.s
x.ns   <- matrix(c(1,.5,.75,1), ncol = 2)
x.nsl  <- x.spdl; x.nsl[[1]] <- x.ns
x.npdl  <- x.spdl; x.npdl[[1]] <- x.s

test_that("input.type discriminates successfully", {

    # SPD matrix case
    expect_true('spd.mat' %in% spdm:::input.type(x.spd) &
                    's.mat' %in% spdm:::input.type(x.spd) &
                    !'s.list' %in% spdm:::input.type(x.spd) &
                    !'spd.list' %in% spdm:::input.type(x.spd))

    # S matrix case
    expect_true(!'spd.mat' %in% spdm:::input.type(x.s) &
                    's.mat' %in% spdm:::input.type(x.s) &
                    !'s.list' %in% spdm:::input.type(x.s) &
                    !'spd.list' %in% spdm:::input.type(x.s))

    # SPD list type
    expect_true(!'spd.mat' %in% spdm:::input.type(x.spdl) &
                    !'s.mat' %in% spdm:::input.type(x.spdl) &
                    's.list' %in% spdm:::input.type(x.spdl) &
                    'spd.list' %in% spdm:::input.type(x.spdl))

    # S list type
    expect_true(!'spd.mat' %in% spdm:::input.type(x.sl) &
                    !'s.mat' %in% spdm:::input.type(x.sl) &
                    's.list' %in% spdm:::input.type(x.sl) &
                    !'spd.list' %in% spdm:::input.type(x.sl))
})

test_that("input.type detects erroneous input", {

    expect_error(spdm:::input.type(as.complex(x.spd)),
                 'Input must be either a matrix or a list of matrices')
    expect_error(spdm:::input.type(c(1,2,3)),
                 'Input must be either a matrix or a list of matrices')
    expect_error(spdm:::input.type(x.ns),
                 'Invalid input type. Probably, input matrix fails to be symmetric')
    expect_error(spdm:::input.type(x.nsl),
                 'Invalid input type. Probably, input matrix fails to be symmetric')
    expect_error(spdm:::input.type(matrix(c(1,NA,NA,1))),
                 'Invalid input type. Probably, input matrix fails to be symmetric')

})


