# Find Outliers in a Linear Model

Find Outliers in a Linear Model

## Usage

``` r
lin_out(y, x, deg)
```

## Arguments

- y:

  A numerical vector as the independent variable

- x:

  A numerical vector as the dependent variable

- deg:

  An integer determining the degree of the linear model

## Value

A table of the vertical distances of each y-value from its predicted
y-value

## Examples

``` r
x1 <- c(4, 8, 2, 0, 1, 5, 3, 9, 2, 7, 3, 5, 4, 10, 4)
y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, 1, 6, 3, 7, 8, 41)
output <- lin_out(y1, x1, 1)
```
