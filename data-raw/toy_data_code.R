## code to prepare `toy_data_code` dataset goes here

x1 <- c(70, 81, 22, 65, 21, 32, 7, 71, 58, 37, 52, 83, 4, 71, 97)
y1 <- c(5, 2, 7, 5, 1, 5, 2, 6, 9, -13, 6, 3, 7, 8, 41)
y2 <- c("TRUE", "TRUE", "FALSE", "TRUE", "FALSE", "FALSE", "FALSE", "FALSE",
        "TRUE", "FALSE", "FALSE", "TRUE", "FALSE", "TRUE", "FALSE")

toy_data <- data.frame(x1, y1, y2)

usethis::use_data(toy_data_code, overwrite = TRUE)
