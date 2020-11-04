context("spd-expam and spd-logmap")

# Positive definite matrixTesting data
x <- cov(matrix(rnorm(100), ncol = 5))

test_that("Exp and Log are inverses", {
    expect_true(compare(x, spd.expmap(spd.logmap(x)))$equal)
})
