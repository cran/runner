## -----------------------------------------------------------------------------
library(runner)
x <- sample(letters, 20, replace = TRUE)
date <- as.Date(cumsum(sample(1:5, 20, replace = TRUE)), origin = Sys.Date()) # unequaly spaced time series

runner(x, k = 7, idx = date, f = function(x) length(unique(x)))

## -----------------------------------------------------------------------------
x <- cumsum(rnorm(20))
date <- as.Date(cumsum(sample(1:5, 20, replace = TRUE)), origin = Sys.Date()) # unequaly spaced time series

runner(x, k = 7, idx = date, f = function(x) mean(x, trim = 0.05))

## -----------------------------------------------------------------------------
x <- cumsum(rnorm(20))
y <- 3 * x + rnorm(20)
date <- as.Date(cumsum(sample(1:3, 20, replace = TRUE)), origin = Sys.Date()) # unequaly spaced time series
data <- data.frame(date, y, x)

running_regression <- function(idx) {
  predict(lm(y ~ x, data = data))[max(idx)]
}

data$pred <- runner(seq_along(x), k = 14, idx = date, f = running_regression)

plot(data$date, data$y, type = "l", col = "red")
lines(data$date, data$pred, col = "blue")

## -----------------------------------------------------------------------------
library(dplyr)
set.seed(3737)
df <- data.frame(
  user_id = c(rep(27, 7), rep(11, 7)),
  date = as.Date(rep(c('2016-01-01', '2016-01-03', '2016-01-05', '2016-01-07', '2016-01-10', '2016-01-14', '2016-01-16'), 2)),
  value = round(rnorm(14, 15, 5), 1))

df %>%
  group_by(user_id) %>%
  mutate(
    v_minus7  = sum_run(value, 7, idx = date),
    v_minus14 = sum_run(value, 14, idx = date))

## -----------------------------------------------------------------------------
library(runner)
df <- read.table(text = "  user_id       date category
       27 2016-01-01    apple
       27 2016-01-03    apple
       27 2016-01-05     pear
       27 2016-01-07     plum
       27 2016-01-10    apple
       27 2016-01-14     pear
       27 2016-01-16     plum
       11 2016-01-01    apple
       11 2016-01-03     pear
       11 2016-01-05     pear
       11 2016-01-07     pear
       11 2016-01-10    apple
       11 2016-01-14    apple
       11 2016-01-16    apple", header = TRUE)

df %>%
  group_by(user_id) %>%
  mutate(
    distinct_7  = runner(category, k =  7, idx = date, f = function(x) length(unique(x))),
    distinct_14 = runner(category, k = 14, idx = date, f = function(x) length(unique(x)))
  )
