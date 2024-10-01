#' Center a collection of covariance matrices
#'
#' Center a dataset of covariance matrices by parallel transport
#'
#' @param d A dataframe. See details.
#' @param covmats An optional list of covariance matrices.
#' @param group_by Variable in d to group by.
#' @param from_constraints Logical expression indicating subsets to use for group means.
#' @param to_constraints   Logical expression indicating subset to use for target mean.
#' @details A convenience wrapper implementing the centering of a covariance
#' matrix valued dataset by parallel transport. The essential goal of this
#' procedure is to accomplish something like the following: We have measured
#' multiple covariance matrices per test subject, and we would like to align
#' the mean covariance of each subject to a common (overall) mean. This is
#' accomplished by
#'
#' \itemize{
#'    \item{1. }{Computing the grand mean covariance}
#'    \item{2. }{Computing the mean covariance for each subject}
#'    \item{3. }{Projecting each of the subjects' observations onto the tangent space around their mean}
#'    \item{4. }{Parallel transporting each of these tangent vectors along a geodesic to the grand mean}
#'    \item{5. }{Exponential mapping back onto the space of covariance matrices}
#' }
#'
#' Consider a neuroimaging experiment in which we measure functional connectivity
#' (a covariance matrix) in multiple conditions within each subject, including a
#' baseline condition. Let covmats be a list of covariance matrices, and let d
#' be a dataframe (with nrows(d) = length(covmats)) containing columns for Subject
#' and Condition. In order to center each subjects' mean to the grand mean, the
#' user can specify group_by = "Subject" -- leaving the other constraints empty.
#' If the user wished to align the subject baselines to the grand mean baseline,
#' the user can set from_constraints = "Condition == 'Baseline'" -- instructing
#' that only the baseline condition should be used to construct the subject
#' meann -- and set to_constraints the same way.
#'
#' More generally, the data are split according to group_by, and the group means
#' are computed using only the observations satisfying from_constraints. The
#' grand mean is then computed using all observations satisfying to_constraints.
#'
#' Note that, rather than providing a list of covariance matrices, the provided
#' dataframe may include a field named COVMATS containing such a list. In that
#' case, these covariance matrices will be used. Note that if both are provided,
#' the argument covmats will be overwritten.
#' @return A named list containing the centered covariance matrices, and the target mean covariance.
#' @export

spd.center <- function(d, covmats = NULL, group_by, from_constraints = NULL, to_constraints = NULL) {

    if ((!'COVDATA' %in% names(d)) & is.null(covmats)) {
        stop('Either covmats must be provided, or d must contain a field named COVMATS')
    } else if (is.null(covmats))
        covmats <- d$COVMATS

    # Compute grand barycenter
    if (is.null(to_constraints)) {
        target_idx <- 1:length(covmats)
    } else {
        target_idx <- with(d, which(eval(parse(text = to_constraints))))
    }

    target_mean <- spd.mean(covmats[target_idx], method = 'riemannian')

    # Compute individual barycenters
    group_idx <- lapply(unique(d[[group_by]]), function(s) which(d[[group_by]] == s))

    if (is.null(from_constraints)) {
        from_idx <- 1:length(covmats)
    } else {
        from_idx <- with(d, which(eval(parse(text = from_constraints))))
    }
    from_idx  <- lapply(unique(d[[group_by]]), function(s)
        intersect(which(d[[group_by]] == s), from_idx))

    source_map <- sapply(d[[group_by]], function(i) which(unique(d[[group_by]]) == i))

    if (any(sapply(from_idx, length)) == 0)
        stop('At least 1 "from" group contains no data')

    source_means <- lapply(from_idx, function(i) {
        if (length(i) == 1)
            return(covmats[[i]])
        else
            return(spd.mean(covmats[i], method = 'riemannian'))
    })

    covmat_center <- lapply(1:length(covmats), function(i)
        spd.translate(covmats[[i]], from = source_means[[source_map[i]]],
                      to = target_mean))

    ret <- list('centered_covmats' = covmat_center,
                'target_covariance' = target_mean)

    return(ret)

}
