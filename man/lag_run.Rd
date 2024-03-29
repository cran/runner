% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{lag_run}
\alias{lag_run}
\title{Lag dependent on variable}
\usage{
lag_run(x, lag = 1L, idx = integer(0), nearest = FALSE)
}
\arguments{
\item{x}{(\code{vector}, \code{data.frame}, \code{matrix}, \code{xts}, \code{grouped_df})\cr
Input in runner custom function \code{f}.}

\item{lag}{(\code{integer} vector or single value)\cr
Denoting window lag. If \code{lag} is a single value then window lag is constant
for all elements, otherwise if \code{length(lag) == length(x)} different window
size for each element. Negative value shifts window forward. One can also
specify \code{lag} in the same way as \code{by} argument in
\code{\link[base:seq.POSIXt]{base::seq.POSIXt()}}. See 'Specifying time-intervals' in details
section.}

\item{idx}{(\code{integer}, \code{Date}, \code{POSIXt})\cr
Optional integer vector containing sorted (ascending) index of observation.
By default \code{idx} is index incremented by one. User can provide index with
varying increment and with duplicated values. If specified then \code{k} and
\code{lag} are depending on \code{idx}. Length of \code{idx} have to be equal of length
\code{x}.}

\item{nearest}{\code{logical} single value. Applied when \code{idx} is used,
then \code{nearest = FALSE} returns observation lagged exactly by the
specified number of "periods". When \code{nearest = TRUE}
function returns latest observation within lag window.}
}
\description{
Vector of input lagged along integer vector
}
\examples{
lag_run(1:10, lag = 3)
lag_run(letters[1:10], lag = -2, idx = c(1, 1, 1, 2, 3, 4, 6, 7, 8, 10))
lag_run(letters[1:10], lag = 2, idx = c(1, 1, 1, 2, 3, 4, 6, 7, 8, 10), nearest = TRUE)
}
