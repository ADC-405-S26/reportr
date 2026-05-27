test_that("kick_out creates the output dataset correctly", {

  # Preliminary setup
  x1 <- c(4, 8, 2, 0, 1, 5, 3, 8, 2, 7, 3, 5, 4, 10, 4)
  y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)
  dists <- c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6)
  data <- data.frame(x1, y1)
  test_result <- kick_out(data, dists, 0.7)

  # Check if the output is a dataframe
  expect_s3_class(test_result, "data.frame")

  # Check that it removed two outliers
  expect_equal(nrow(test_result), 13)

  # Check that it contains the same two columns
  expect_equal(ncol(test_result), 2)

})

test_that("kick_out throws errors when it is supposed to", {

  # Same preliminary setup
  x1 <- c(4, 8, 2, 0, 1, 5, 3, 9, 2, 7, 3, 5, 4, 10, 4)
  y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)
  dists1 <- c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6)
  data <- data.frame(x1, y1)

  # threshold is not a double
  expect_error(kick_out(data = data, distances = dists1, threshold = "WRONG"), "Assertion on 'threshold' failed")

  # data is not a dataframe
  expect_error(kick_out(data = x1, distances = dists1, threshold = 0.7), "Assertion on 'data' failed")

  dists2 <- c(4, 8, 2, 0, 1, 5, NA_character_, 9, 2, 7, 3, 5, 4, 10, 4)

  # distances has missing data
  expect_error(kick_out(data = data, distances = dists2, threshold = 0.7), "Assertion on 'distances' failed")

  dists3 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8)

  # Unequal number of rows in data and distances
  expect_error(kick_out(data = data, distances = dists3, threshold = 0.7), "Assertion on 'a == b' failed")

  # One of the parameters is missing
  expect_error(kick_out(data = data, distances = dists1), "argument \"threshold\" is missing, with no default")
  expect_error(kick_out(distances = dists1, threshold = 0.7), "argument \"data\" is missing, with no default")
  expect_error(kick_out(data = data, threshold = 0.7), "argument \"distances\" is missing, with no default")

  # There are too many parameters
  expect_error(kick_out(data = data, distances = dists1, threshold = 0.7, 1), "unused argument")

})

