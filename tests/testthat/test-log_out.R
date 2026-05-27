test_that("log_out creates the output table correctly", {

  # Preliminary setup
  x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
  y1 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
          "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")
  test_result1 <- log_out(y1, x1, 1, "TRUE")

  # Check that Response is a double
  expect_type(test_result1$Response, "double")

  # Check that Prediction is a double
  expect_type(test_result1$Prediction, "double")

  # Check that Distance is a double
  expect_type(test_result1$Distance, "double")

  # Switch up the degree number and positive category
  test_result2 <- log_out(y1, x1, 3, "FALSE")

  # Check that Response is a double
  expect_type(test_result2$Response, "double")

  # Check that Prediction is a double
  expect_type(test_result2$Prediction, "double")

  # Check that Distance is a double
  expect_type(test_result2$Distance, "double")

})

test_that("log_out throws errors when it is supposed to", {

  x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
  y1 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
          "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")

  # deg is not an integer
  expect_error(log_out(y1, x1, deg = 2.5, "TRUE"), "Assertion on 'deg' failed")

  x2 <- c(4, 8, 2, 0, 1, 5, NA_character_, 9, 2, 7, 3, 5, 4, 10, 4)

  # x has missing data
  expect_error(log_out(y1, x2, deg = 1, "TRUE"), "Assertion on 'x' failed")

  y2 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)

  # y is not categorical
  expect_error(log_out(y2, x1, deg = 1, "TRUE"), "Assertion failed")

  x3 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8)

  # Unequal number of rows in x and y
  expect_error(log_out(y1, x3, deg = 1, "TRUE"), "arguments imply differing number of rows")


  # One of the parameters is missing
  expect_error(log_out(y = y1, deg = 1, positive = "TRUE"), "argument \"x\" is missing, with no default")
  expect_error(log_out(x = x1, deg = 1, positive = "TRUE"), "argument \"y\" is missing, with no default")
  expect_error(log_out(y = y1, x = x1, deg = 1), "argument \"positive\" is missing, with no default")
  expect_error(log_out(y = y1, x = x1, positive = "TRUE"), "argument \"deg\" is missing, with no default")

  # There are too many parameters
  expect_error(log_out(y1, x1, 1, "TRUE", 2), "unused argument")

})
