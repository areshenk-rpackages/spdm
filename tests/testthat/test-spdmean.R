context("spd-mean")

# Positive definite matrixTesting data
x <- lapply(1:10, function(i) cov(matrix(rnorm(100), ncol = 5)))

test_that("All mean methods run without error", {

    expect_error(spd.mean(x, method = 'euclidean'), NA)
    expect_error(spd.mean(x, method = 'logeuclidean'), NA)
    expect_error(spd.mean(x, method = 'riemannian', p = 0), NA)
    expect_error(spd.mean(x, method = 'riemannian', p = .25), NA)
    expect_error(spd.mean(x, method = 'riemannian', p = -.25), NA)

})

test_that("Unrecognized method fails gracefully", {

    expect_error(spd.mean(x, method = 'blurnsball'),
                 'Unrecognized method')

})
