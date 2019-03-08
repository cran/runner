## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-"
)

## ----gh-installation, eval=FALSE-----------------------------------------
#  # devtools::install_github("gogonzo/runner")
#  install.packages("runner")

## ----run_window, echo=TRUE-----------------------------------------------
library(runner); library(magrittr)
window_run( x = 1:5, k = c(1,2,3,3,2) )

## ----run_window2, echo=TRUE----------------------------------------------
window_run( x= 1:5, k = c(1,2,3,3,2) ) %>%
  lapply(sum) %>%
  unlist

## ----run_window3, echo=TRUE----------------------------------------------
window_run( x = 1:5, k = 3, idx = c(1,2,5,6,7) ) 

## ----unique_run, echo=TRUE-----------------------------------------------
x2 <- sample( letters[1:3], 6, replace=TRUE)
x2 
unique_run( x=x2, k = 3 )

## ----min_run_example, echo=TRUE------------------------------------------
x <- c(1,-5,1,-3,NA,NA,NA,1,-1,NA,-2,3)
k <- c(4,5,2,5,4,4,2,2,4,4,3,1)
idx <- as.Date( c(1,3,4,6,7,10,13,16,19,21,23,26), origin = "1970-01-01")

a0 <- cummin(x)
a1 <- min_run(x, na_rm = TRUE)
a2 <- min_run(x, k=5, na_rm = TRUE)
a3 <- min_run(x, na_rm = FALSE)
a4 <- min_run(x, k=k, na_rm = TRUE, na_pad = TRUE)
a5 <- min_run(x, k=5, idx=idx)

data.frame(idx, x, a0, a1, a2, a3, a4, a5)

## ------------------------------------------------------------------------
x <- c(NA, NA, "b","b","a",NA,NA,"a","b",NA,"a","b")
data.frame(x, 
           f1 = fill_run(x), 
           f2 = fill_run(x,run_for_first = T), 
           f3 = fill_run(x, only_within = T))

## ------------------------------------------------------------------------
x <- c("A","B","A","A","B","B","B",NA,"B","A","B")
data.frame(
  x, 
  s0 = streak_run(x),
  s1 = streak_run(x, na_rm=F, k=3),
  s2 = streak_run(x, k=4) )

## ------------------------------------------------------------------------
x <- c(T,T,T,F,NA,T,F,NA,T,F,T,F)
data.frame(
  x, 
  s0 = whicht_run(x, which="first"),
  s1 = whicht_run(x, na_rm=F, k=5, which="first"),
  s2 = whicht_run(x, k=5,"first"))


