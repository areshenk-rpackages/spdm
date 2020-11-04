context("spd-dist")

# Positive definite matrix Testing data
x <- cov(matrix(rnorm(100), ncol = 5))
y <- cov(matrix(rnorm(100), ncol = 5))

test_that("All distance methods run without error", {

    expect_error(spd.dist(x, y, method = 'euclidean'), NA)
    expect_error(spd.dist(x, y, method = 'logeuclidean'), NA)
    expect_error(spd.dist(x, y, method = 'cholesky'), NA)
    expect_error(spd.dist(x, y, method = 'riemannian'), NA)
    expect_error(spd.dist(x, y, method = 'stein'), NA)

})

test_that("Unrecognized method fails gracefully", {

    expect_error(spd.dist(x, y, method = 'blurnsball'),
                 'Unrecognized method')

})
