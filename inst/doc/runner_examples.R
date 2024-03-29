## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  
#  x <- sample(letters, 20, replace = TRUE)
#  date <- Sys.Date() + cumsum(sample(1:5, 20, replace = TRUE)) # unequally spaced time series
#  
#  runner(
#    x,
#    k = "7 days",
#    idx = date,
#    f = function(x) length(unique(x))
#  )

## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  
#  x <- cumsum(rnorm(20))
#  date <- Sys.Date() + cumsum(sample(1:5, 20, replace = TRUE)) # unequaly spaced time series
#  
#  runner(
#    x,
#    k = "week",
#    idx = date,
#    f = function(x) mean(x, trim = 0.05)
#  )

## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  
#  # sample data
#  x <- cumsum(rnorm(20))
#  data <- data.frame(
#    date = Sys.Date() + cumsum(sample(1:3, 20, replace = TRUE)), # unequally spaced time series,
#    y = 3 * x + rnorm(20),
#    x = cumsum(rnorm(20))
#  )
#  
#  # solution
#  data$pred <- runner(
#    data,
#    lag = "1 days",
#    k = "2 weeks",
#    idx = data$date,
#    f = function(data) {
#      predict(
#        lm(y ~ x, data = data)
#      )[nrow(data)]
#    }
#  )
#  
#  
#  plot(data$date, data$y, type = "l", col = "red")
#  lines(data$date, data$pred, col = "blue")

## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  library(dplyr)
#  
#  set.seed(3737)
#  df <- data.frame(
#    user_id = c(rep(27, 7), rep(11, 7)),
#    date = as.Date(rep(c(
#      "2016-01-01", "2016-01-03", "2016-01-05", "2016-01-07",
#      "2016-01-10", "2016-01-14", "2016-01-16"
#    ), 2)),
#    value = round(rnorm(14, 15, 5), 1)
#  )
#  
#  df %>%
#    group_by(user_id) %>%
#    mutate(
#      v_minus7  = sum_run(value, 7, idx = date),
#      v_minus14 = sum_run(value, 14, idx = date)
#    )

## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  library(dplyr)
#  
#  df <- read.table(text = "  user_id       date category
#         27 2016-01-01    apple
#         27 2016-01-03    apple
#         27 2016-01-05     pear
#         27 2016-01-07     plum
#         27 2016-01-10    apple
#         27 2016-01-14     pear
#         27 2016-01-16     plum
#         11 2016-01-01    apple
#         11 2016-01-03     pear
#         11 2016-01-05     pear
#         11 2016-01-07     pear
#         11 2016-01-10    apple
#         11 2016-01-14    apple
#         11 2016-01-16    apple", header = TRUE)
#  
#  df %>%
#    group_by(user_id) %>%
#    mutate(
#      distinct_7 = runner(category,
#        k = "7 days",
#        idx = as.Date(date),
#        f = function(x) length(unique(x))
#      ),
#      distinct_14 = runner(category,
#        k = "14 days",
#        idx = as.Date(date),
#        f = function(x) length(unique(x))
#      )
#    )

## ----eval=FALSE---------------------------------------------------------------
#  library(dplyr)
#  
#  x <- cumsum(rnorm(20))
#  y <- 3 * x + rnorm(20)
#  date <- Sys.Date() + cumsum(sample(1:3, 20, replace = TRUE)) # unequaly spaced time series
#  group <- rep(c("a", "b"), each = 10)
#  
#  
#  data.frame(date, group, y, x) %>%
#    group_by(group) %>%
#    run_by(idx = "date", k = "5 days") %>%
#    mutate(
#      alpha_5 = runner(
#        x = .,
#        f = function(x) {
#          coefficients(lm(x ~ y, x))[1]
#        }
#      ),
#      beta_5 = runner(
#        x = .,
#        f = function(x) {
#          coefficients(lm(x ~ y, x))[1]
#        }
#      )
#    )

## ----eval=FALSE---------------------------------------------------------------
#  library(runner)
#  library(dplyr)
#  
#  Date <- seq(
#    from = as.Date("2014-01-01"),
#    to = as.Date("2019-12-31"),
#    by = "day"
#  )
#  market_return <- c(rnorm(2191))
#  
#  AAPL <- data.frame(
#    Company.name = "AAPL",
#    Date = Date,
#    market_return = market_return
#  )
#  
#  MSFT <- data.frame(
#    Company.name = "MSFT",
#    Date = Date,
#    market_return = market_return
#  )
#  
#  df <- rbind(AAPL, MSFT)
#  df$stock_return <- c(rnorm(4382))
#  df <- df[order(df$Date), ]
#  
#  df2 <- data.frame(
#    Company.name2 = c(replicate(450, "AAPL"), replicate(450, "MSFT")),
#    Event_date = sample(
#      seq(as.Date("2015/01/01"),
#        as.Date("2019/12/31"),
#        by = "day"
#      ),
#      size = 900
#    )
#  )
#  
#  
#  df2 %>%
#    group_by(Company.name2) %>%
#    mutate(
#      intercept = runner(
#        x = df[df$Company.name == Company.name2[1], ],
#        k = "180 days",
#        lag = "5 days",
#        idx = df$Date[df$Company.name == Company.name2[1]],
#        at = Event_date,
#        f = function(x) {
#          coef(
#            lm(stock_return ~ market_return, data = x)
#          )[1]
#        }
#      ),
#      slope = runner(
#        x = df[df$Company.name == Company.name2[1], ],
#        k = "180 days",
#        lag = "5 days",
#        idx = df$Date[df$Company.name == Company.name2[1]],
#        at = Event_date,
#        f = function(x) {
#          coef(
#            lm(stock_return ~ market_return, data = x)
#          )[2]
#        }
#      )
#    )

