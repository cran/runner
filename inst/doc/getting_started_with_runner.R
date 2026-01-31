## ----eval=FALSE---------------------------------------------------------------
# library(runner)
# 
# x <- data.frame(
#   date = seq.Date(Sys.Date(), Sys.Date() + 365, length.out = 20),
#   a = rnorm(20),
#   b = rnorm(20)
# )
# 
# runner(
#   x,
#   lag = "1 months",
#   k = "4 months",
#   idx = x$date,
#   f = function(x) {
#     cor(x$a, x$b)
#   }
# )

## ----eval=FALSE---------------------------------------------------------------
# runner(1:15, k = 4)

## ----eval=FALSE---------------------------------------------------------------
# runner(
#   1:15,
#   k = 4,
#   lag = 2
# )

