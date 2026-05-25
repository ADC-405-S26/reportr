#' Find Outliers in a Linear Model
#'
#' @param y A numerical vector as the independent variable
#' @param x A numerical vector as the dependent variable
#' @param deg An integer determining the degree of the linear model
#'
#' @returns A table of the vertical distances of each y-value from its predicted y-value
#' @importFrom checkmate assert_numeric assertInt
#' @importFrom stats binomial lm predict
#' @export
#'
#' @examples
#' x1 <- c(4, 8, 2, 0, 1, 5, 3, 9, 2, 7, 3, 5, 4, 10, 4)
#' y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)
#' output <- lin_out(y1, x1, 1)
lin_out <- function(y, x, deg)
{

  # Assertions
  checkmate::assert_numeric(y)
  checkmate::assert_numeric(x)
  checkmate::assertInt(deg)

  # Define certain preliminaries before the loop
  n <- length(y)

  Y_value <- numeric(n)

  Prediction <- numeric(n)

  Distance <- numeric(n)

  dataset <- data.frame(y = y, x = x)

  # For loop to execute CV on each point to isolate potential outliers
  for (i in 1:n) {

    # Isolate training set and the single data point of interest
    train_data <- dataset[-i, ]
    test_point <- dataset[i, ]

    # Fit model using columns from train_data
    model <- lm(y ~ poly(x, deg, raw = TRUE), data = train_data)

    # Actual y_value
    Y_value[i] <- test_point$y

    # Prediction of y[i] based on the other points
    Prediction[i] <- predict(model, newdata = test_point)

    # Vertical distance of the data point from the best fit line
    Distance[i] <- abs(Y_value[i] - Prediction[i])
  }

  # Return a data frame of the key values that will isolate potential outliers
  return(data.frame(Y_value, Prediction, Distance))

}
