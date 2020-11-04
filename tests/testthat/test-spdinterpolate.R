context("spd-interpolate")

# Positive definite matrixTesting data
x <- cov(matrix(rnorm(100), ncol = 5))
y <- cov(matrix(rnorm(100), ncol = 5))

test_that("Functions accurate interpolate", {

    # Euclidean
    expect_true(compare(x, spd.interpolate(x, y, t = 0, method = 'euclidean'))$equal)
    expect_true(compare(y, spd.interpolate(x, y, t = 1, method = 'euclidean'))$equal)

    # Euclidean
    expect_true(compare(x, spd.interpolate(x, y, t = 0, method = 'logeuclidean'))$equal)
    expect_true(compare(y, spd.interpolate(x, y, t = 1, method = 'logeuclidean'))$equal)

    # Euclidean
    expect_true(compare(x, spd.interpolate(x, y, t = 0, method = 'riemannian'))$equal)
    expect_true(compare(y, spd.interpolate(x, y, t = 1, method = 'riemannian'))$equal)
})
