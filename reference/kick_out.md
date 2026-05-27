# Kick Out Outliers in your Data

Kick Out Outliers in your Data

## Usage

``` r
kick_out(data, distances, threshold)
```

## Arguments

- data:

  A dataset containing your y-values and x-values

- distances:

  A numerical vector ordered with data to determine which rows
  (outliers) are to be removed

- threshold:

  A double value that differentiates between what distance is seen as an
  outlier or not

## Value

A dataset with the same columns as data, with the outliers kicked out

## Examples

``` r
x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
y1 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
        "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")
dists <- c(0.26, 0.53, 0.16, 0.62, 0.78, 0.21, 0.89, 0.35, 0.16,
           0.55, 0.79, 0.63, 0.41, 0.26, 0.58)
data <- data.frame(x1, y1)
new_data <- kick_out(data, dists, 0.7)
```
