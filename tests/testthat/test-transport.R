context("spd-transport")

# Positive definite matrixTesting data
from <- cov(matrix(rnorm(300), ncol = 3))
to   <- cov(matrix(rnorm(300), ncol = 3))
x    <- .8 * from + .2 * cov(matrix(rnorm(300), ncol = 3))
x    <- spd.logmap(x, p = from)

y1.pt   <- spd.transport(x, from = from, to = to, method = 'pt', nsteps = 10)
y2.pt   <- spd.transport(y1.pt, from = to, to = from, method = 'pt', nsteps = 10)

y1.gl   <- spd.transport(x, from = from, to = to, method = 'gl')
y2.gl   <- spd.transport(y1.gl, from = to, to = from, method = 'gl')

test_that("Parallel transport back and forth is equal", {
    expect_true(compare(x, y2.pt)$equal)
})

test_that("GL-action transport back and forth is equal", {
    expect_true(compare(x, y2.gl)$equal)
})
