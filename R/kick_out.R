#' Kick Out Outliers in your Data
#'
#' @param data A dataset containing your y-values and x-values
#' @param distances A numerical vector ordered with data to determine which rows (outliers) are to be removed
#' @param threshold A double value that differentiates between what distance is seen as an outlier or not
#'
#' @returns A dataset with the same columns as data, with the outliers kicked out
#' @importFrom checkmate assertDataFrame assert_numeric assert_number
#' @importFrom stats binomial
#' @export
#'
#' @examples
#' x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
#' y1 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
#'         "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")
#' dists <- c(0.26, 0.53, 0.16, 0.62, 0.78, 0.21, 0.89, 0.35, 0.16,
#'            0.55, 0.79, 0.63, 0.41, 0.26, 0.58)
#' data <- data.frame(x1, y1)
#' new_data <- kick_out(data, dists, 0.7)
kick_out <- function(data, distances, threshold){

  # Assertions
  checkmate::assertDataFrame(
    data,
    any.missing = FALSE,
    min.rows = 1,
    min.cols = 1
  )
  a <- nrow(data)
  b <- length(distances)
  checkmate::assert_numeric(distances)
  checkmate::assert(identical(a, b), .var.name = "a == b")
  checkmate::assert_number(threshold)

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
