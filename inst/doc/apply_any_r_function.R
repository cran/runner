## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  x <- rnorm(20)
#  dates <- seq.Date(Sys.Date(), Sys.Date() + 19, by = "1 day")
#  
#  runner(x,
#         k = 14,
#         idx = dates,
#         f = function(xi) {
#          mean(xi, na.rm = TRUE, trim = 0.05)
#         })

## ----eval=FALSE---------------------------------------------------------------
#  runner::runner(x = 1:15,
#                 k = 4,
#                 f = function(x) mean(x))

## ----eval=FALSE---------------------------------------------------------------
#  runner::runner(x = 1:15,
#                 k = 4,
#                 lag = 2,
#                 f = function(x) mean(x))

## ----eval=FALSE---------------------------------------------------------------
#  idx <- c(4, 6, 7, 13, 17, 18, 18, 21, 27, 31, 37, 42, 44, 47, 48)
#  runner::runner(x = 1:15,
#                 k = 5,
#                 lag = 1,
#                 idx = idx,
#                 f = function(x) mean(x))

## ----eval=FALSE---------------------------------------------------------------
#  idx <- c(4, 6, 7, 13, 17, 18, 18, 21, 27, 31, 37, 42, 44, 47, 48)
#  runner::runner(x = 1:15,
#                 k = 5,
#                 lag = 1,
#                 idx = idx,
#                 at = c(18, 27, 48, 31),
#                 f = function(x) mean(x))

## ----eval=FALSE---------------------------------------------------------------
#  idx <- c(4, 6, 7, 13, 17, 18, 18, 21, 27, 31, 37, 42, 44, 47, 48)
#  runner::runner(x = 1:15,
#                 k = 5,
#                 lag = 1,
#                 idx = idx,
#                 at = c(4, 18, 48, 51),
#                 na_pad = TRUE,
#                 f = function(x) mean(x))

