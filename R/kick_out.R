kick_out <- function(data, distances, threshold){

  # Load checkmate
  library(checkmate)


  # Assertions
  assertDataFrame(
    data,
    any.missing = FALSE,
    min.rows = 1,
    min.cols = 1
  )
  assert_numeric(distances)
  assert_number(threshold)

  # Find indices of points that are past the threshold
  outliers <- which(distances > threshold)

  # Kick out labeled outliers if any exist, otherwise return original data
  if (length(outliers) > 0) {
    updated_data <- data[-outliers, ]
  } else {
    updated_data <- data
  }

  # Return the updated dataset
  return(updated_data)

}
