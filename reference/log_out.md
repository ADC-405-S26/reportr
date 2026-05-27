# Find Outliers in a Logistic Model

Find Outliers in a Logistic Model

## Usage

``` r
log_out(y, x, deg, positive)
```

## Arguments

- y:

  A binomial categorical vector as the independent variable

- x:

  A numerical vector as the dependent variable

- deg:

  An integer determining the degree of the logistic model

- positive:

  A character value that determines which category in y will be
  considered "1" rather than "0"

## Value

A table of the vertical distances of each y-value (0 or 1) from its
predicted probability

## Examples

``` r
x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
y1 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
        "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")
output <- log_out(y1, x1, 1, "TRUE")
```
