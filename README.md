
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reportr

<!-- badges: start -->

<!-- badges: end -->

The goal of reportr is to isolate and eliminate potential outliers as
you perform data analysis.

## Installation

You can install the development version of reportr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ADC-405-S26/reportr")
```

Then load reportr by using the library function:

``` r
library(reportr)
```

#### lin_out Example

lin_out uses linear regression on one numeric predictor and one numeric
feature, with whatever degree you wish. It will return a table of each
data point’s vertical distance from the predicted value.

``` r
lin_out(y = toy_data$y1, x = toy_data$x1, deg = 2)
#>    Response   Prediction   Distance
#> 1         5  6.749574569  1.7495746
#> 2         2 15.688087544 13.6880875
#> 3         7 -0.791046110  7.7910461
#> 4         5  3.915063622  1.0849364
#> 5         1  0.540482366  0.4595176
#> 6         5 -2.763861140  7.7638611
#> 7         2  8.871741374  6.8717414
#> 8         6  7.248777635  1.2487776
#> 9         9  0.008443845  8.9915562
#> 10      -13 -0.115509704 12.8844903
#> 11        6 -1.622469019  7.6224690
#> 12        3 17.694392291 14.6943923
#> 13        7  9.226271946  2.2262719
#> 14        8  7.003293449  0.9967066
#> 15       41  8.177093048 32.8229070
```

#### log_out Example

log_out on the other hand uses logistic regression on one numeric
predictor column and one binomial categorical response column. Be sure
to not only define a degree, but also positive, a.k.a. which category
will be treated as a response of 1 rather than 0. log_out will return a
table of each data point’s vertical distance from the predicted
probability.

``` r
log_out(y = toy_data$y2, x = toy_data$x1, deg = 1, positive = "TRUE")
#>    Response Prediction   Distance
#> 1         1 0.54448061 0.45551939
#> 2         1 0.69496615 0.30503385
#> 3         0 0.08914199 0.08914199
#> 4         1 0.46674724 0.53325276
#> 5         0 0.08415610 0.08415610
#> 6         0 0.15401066 0.15401066
#> 7         0 0.03634495 0.03634495
#> 8         0 0.70106495 0.70106495
#> 9         1 0.34796059 0.65203941
#> 10        0 0.19771436 0.19771436
#> 11        0 0.37695504 0.37695504
#> 12        1 0.71916848 0.28083152
#> 13        0 0.03020993 0.03020993
#> 14        1 0.55932813 0.44067187
#> 15        0 0.99586838 0.99586838
```

#### kick_out Example

If you want, reportr can help eliminate those pesky outliers from your
data. Add the dataset you used as a dataframe, along with the distances
obtained from lin_out or log_out, and a threshold for what distances
will be considered outliers to be eliminated. The result will be your
dataset with all the isolated outliers filtered out (Note that the row
numbers on this output can be misleading, there are actually only 13
rows here).

``` r
output <- log_out(y = toy_data$y2, x = toy_data$x1, deg = 1, positive = "TRUE")
kick_out(data = toy_data, distances = output$Distance, threshold = 0.7)
#>    x1  y1    y2
#> 1  70   5  TRUE
#> 2  81   2  TRUE
#> 3  22   7 FALSE
#> 4  65   5  TRUE
#> 5  21   1 FALSE
#> 6  32   5 FALSE
#> 7   7   2 FALSE
#> 9  58   9  TRUE
#> 10 37 -13 FALSE
#> 11 52   6 FALSE
#> 12 83   3  TRUE
#> 13  4   7 FALSE
#> 14 71   8  TRUE
```
