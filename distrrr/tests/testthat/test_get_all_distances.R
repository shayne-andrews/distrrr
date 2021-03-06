#' test_get_all_distances.R
#' Feb 2019
#' @author: Evan Yathon
#'
#' This script is for testing the functionality for get_distance.R

library(testthat)

test_that("Output vector is the same length of the number of rows of input data frame",{

      df <- data.frame("A" = c(1,2,3), "B" = c(8,2,4))
      ref_vec <- c(-2,4)

      dists <- get_all_distances(ref_vec, df)

      expect_equal(dim(df)[1], length(dists))
})

test_that("Output vector is type numeric",{

      df <- data.frame("A" = c(1,2,3), "B" = c(8,2,4))
      ref_vec <- c(-2,4)

      dists <- get_all_distances(ref_vec, df)

      expect_that(dists, is_a("numeric"))
})

test_that("Distance metrics are correct different metrics distance",{

      df <- data.frame("A" = c(1,2,3), "B" = c(8,2,4))
      ref_vec <- c(-2,4)

      dists <- get_all_distances(ref_vec, df, dist = "euclidean")
      expect_equal(round(dists,2), c(5,4.47,5))

      dists <- get_all_distances(ref_vec, df, dist = "cosine")
      expect_equal(round(dists,2), c(0.83,0.32,0.45))

      dists <- get_all_distances(ref_vec, df, dist = "manhattan")
      expect_equal(round(dists,2), c(7,6,5))
})

test_that("Second argument should be a data frame",{
      ref_vec <- c(-2,4)

      expect_error(get_all_distances(ref_vec,c(1,2,3)), info = "Second Argument not a dataframe")
      expect_error(get_all_distances(ref_vec,2), info = "Second Argument not a dataframe")
      expect_error(get_all_distances(ref_vec,list("A" = c(1,2,3), "B" = c(8,2,4))), info = "Second Argument not a dataframe")
})

test_that("First argument should be a vector",{
      df <- data.frame("A" = c(1,2,3), "B" = c(8,2,4))

      expect_error(get_all_distances("a",df), info = "first argument should be a vector")
      expect_error(get_all_distances(df,df), info = "first argument should be a vector")
})


test_that("Reference vector should be length k, the number of columns of the input dataframe",{
      df <- data.frame("A" = c(1,2,3), "B" = c(8,2,4))
      ref_vec <- c(1,2,3,4)

      expect_error(get_all_distances(ref_vec,df), "ref vector is not the right size")
})

test_that("dist_type should be a string and one of 'cosine', 'euclidean' or 'manhattan'",{
      df <- data.frame("A" = c(1,2,3), "B" = c(8,2,4))
      ref_vec <- c(1,2,3,4)

      expect_error(get_all_distances(ref_vec,df, dist = 1), "distance metric is not a valid option")
      expect_error(get_all_distances(ref_vec,df, dist = "cityblock"), "distance metric is not a valid option")
})


