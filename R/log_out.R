#' Find Outliers in a Logistic Model
#'
#' @param y A binomial categorical vector as the independent variable
#' @param x A numerical vector as the dependent variable
#' @param deg An integer determining the degree of the logistic model
#' @param positive A character value that determines which category in y will be considered "1" rather than "0"
#'
#' @returns A table of the vertical distances of each y-value (0 or 1) from its predicted probability
#' @importFrom checkmate assert check_character check_factor assertFactor assert_numeric assertInt assertChoice assert_number
#' @importFrom stats binomial glm predict
#' @export
#'
#'
#' @examples
#' x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
#' y1 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
#'         "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")
#' output <- log_out(y1, x1, 1, "TRUE")
log_out <- function(y, x, deg, positive)
{

  # First checkmate assertion
    checkmate::assert(
    combine = "or",
    checkmate::check_character(y),
    checkmate::check_factor(y))

  # Put y in factor form first before performing the rest of the assertions
  y <- factor(y)

  # Other required assertions
  checkmate::assertFactor(y, n.levels = 2)
  checkmate::assert_numeric(x)
  checkmate::assertInt(deg)
  checkmate::assertChoice(factor(positive), choices = y)
  checkmate::assert_number(length(y), lower = deg + 1)

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
    model <- glm(formula = y ~ poly(x, deg, raw = TRUE),
                     data = train_data,
                     family = binomial)

    # Actual y_value
    Y_value[i] <- ifelse(test_point$y == positive, 1, 0)

    # Prediction of y[i] based on the other points
    Prediction[i] <- predict(object = model,
                                   newdata = test_point,
                                   type = "response")

    # Vertical distance of the data point from the best fit line
    Distance[i] <- abs(Y_value[i] - Prediction[i])
  }

  # Return a data frame of the key values that will isolate potential outliers
  return(data.frame(Y_value, Prediction, Distance))

}
