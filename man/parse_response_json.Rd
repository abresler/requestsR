% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{parse_response_json}
\alias{parse_response_json}
\title{Parse response json}
\usage{
parse_response_json(resp, is_tibble = FALSE)
}
\arguments{
\item{resp}{response module}

\item{is_tibble}{if \code{TRUE} returns a data frame}
}
\value{
JSON object or \code{tibble}
}
\description{
Parses response object
content into JSON
}
