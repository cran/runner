## ----gh-installation, eval=FALSE-----------------------------------------
#  # devtools::install_github("gogonzo/runner")
#  install.packages("runner")

## ---- echo=TRUE----------------------------------------------------------
library(runner)
x <- runif(15)
k <- sample(1:15, 15, replace = TRUE)
idx <- cumsum(sample(c(1, 2, 3, 4), 15, replace = TRUE))

# simple call
simple_mean <- runner(x = x, k = 4, f = mean)

# additional arguments for mean
trimmed_mean <- runner(x = x, k = 4, f = function(x) mean(x, trim = 0.05))

# varying window size
varying_window <- runner(x = x, k = k, f = function(x) mean(x, trim = 0.05))

# windows depending on date
date_windows <- runner(x = x, k = k, idx = idx, f = function(x) mean(x, trim = 0.05))

data.frame(x, k, idx, simple_mean, trimmed_mean, varying_window, date_windows)

