lin_out <- function(y, x, deg)
{

  # Assertions
  checkmate::assert_numeric(y)
  checkmate::assert_numeric(x)
  checkmate::assert_number(deg)

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
