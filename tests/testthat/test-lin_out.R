test_that("lin_out creates the output table correctly", {

  # Preliminary setup
  x1 <- c(4, 8, 2, 0, 1, 5, 3, 9, 2, 7, 3, 5, 4, 10, 4)
  y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)
  test_result1 <- lin_out(y1, x1, 1)

  # Check that Response is a double
  expect_type(test_result1$Response, "double")

  # Check that Prediction is a double
  expect_type(test_result1$Prediction, "double")

  # Check that Distance is a double
  expect_type(test_result1$Distance, "double")

  # Switch up the type of numeric variable and degree number
  x1 <- c(4.3, 8.5, 2.2, 0.9, 1.1, 5.4, 3.6, 9.7, 2.3, 7.4, 3.5,
          5.2, 4.6, 10.8, 4.9)
  y1 <- c(5.9, 2.2, 7.4, 5.1, 1.0, 5.8, 2.9, 6.8, 9.3, 1.6, 6.0,
          3.3, 7.2, 8.7, 41.5)
  test_result2 <- lin_out(y1, x1, 3)

  # Check that Response is a double
  expect_type(test_result2$Response, "double")

  # Check that Prediction is a double
  expect_type(test_result2$Prediction, "double")

  # Check that Distance is a double
  expect_type(test_result2$Distance, "double")

})

test_that("lin_out throws errors when it is supposed to", {

  x1 <- c(4, 8, 2, 0, 1, 5, 3, 9, 2, 7, 3, 5, 4, 10, 4)
  y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)

  # deg is not an integer
  expect_error(lin_out(y1, x1, deg = 2.5), "Assertion on 'deg' failed")

  x2 <- c(4, 8, 2, 0, 1, 5, NA_character_, 9, 2, 7, 3, 5, 4, 10, 4)

  # x has missing data
  expect_error(lin_out(y1, x2, deg = 1), "Assertion on 'x' failed")

  y2 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
          "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")

  # y is not numeric
  expect_error(lin_out(y2, x1, deg = 1), "Assertion on 'y' failed")

  x3 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8)

  # Unequal number of rows in x and y
  expect_error(lin_out(y1, x3, deg = 1), "arguments imply differing number of rows")

  # One of the parameters is missing
  expect_error(lin_out(y = y1, deg = 1), "argument \"x\" is missing, with no default")
  expect_error(lin_out(x = x1, deg = 1), "argument \"y\" is missing, with no default")
  expect_error(lin_out(y = y1, x = x1), "argument \"deg\" is missing, with no default")

  # There are too many parameters
  expect_error(lin_out(x1, y1, 1, 2), "unused argument")

})
