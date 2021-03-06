% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as-tsibble.R
\name{build_tsibble}
\alias{build_tsibble}
\title{Low-level constructor for a tsibble object}
\usage{
build_tsibble(x, key, key_data = NULL, index, index2, ordered = NULL,
  regular = TRUE, interval = NULL, validate = TRUE,
  .drop = key_drop_default(x))
}
\arguments{
\item{x}{A \code{data.frame}, \code{tbl_df}, \code{tbl_ts}, or other tabular objects.}

\item{key}{Unquoted variable(s) that uniquely determine time indices. \code{NULL} for
empty key, and works with tidy selector (e.g. \code{starts_with()}).}

\item{key_data}{A data frame containing key variables and \code{.rows}. When a data
frame is supplied, the argument \code{key} will be ignored.}

\item{index}{A bare (or unquoted) variable to specify the time index variable.}

\item{index2}{A candidate of \code{index} to update the index to a new one when
\link{index_by}. By default, it's identical to \code{index}.}

\item{ordered}{The default of \code{NULL} arranges the key variable(s) first and
then index from past to future. \code{TRUE} suggests to skip the ordering as \code{x} in
the correct order. \code{FALSE} also skips the ordering but gives a warning instead.}

\item{regular}{Regular time interval (\code{TRUE}) or irregular (\code{FALSE}). The
interval is determined by the greatest common divisor of index column, if \code{TRUE}.}

\item{interval}{\code{NULL} computes the interval. Use the specified interval via
\code{\link[=new_interval]{new_interval()}} as is, if an class of \code{interval} is supplied.}

\item{validate}{\code{TRUE} suggests to verify that each key or each combination
of key variables leads to unique time indices (i.e. a valid tsibble). If you
are sure that it's a valid input, specify \code{FALSE} to skip the checks.}

\item{.drop}{If \code{TRUE}, empty key groups are dropped.}
}
\description{
\code{build_tsibble()} creates a \code{tbl_ts} object with more controls. It is useful
for creating a \code{tbl_ts} internally inside a function, and it allows developers to
determine if the time needs ordering and the interval needs calculating.
}
\examples{
# Prepare `pedestrian` to use a new index `Date` ----
pedestrian \%>\%
  build_tsibble(
    key = !! key_vars(.), index = !! index(.), index2 = Date,
    interval = interval(.)
  )
}
