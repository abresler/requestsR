# gdeltr2::load_needed_packages(c("purrr", "glue", "reticulate", "dplyr", "rvest", "readr", "stringr", "stringi"))
#' Import requests module
#'
#' @return requests module
#' @export
#'
#' @examples
import_requests <-
  function() {
    if (!'r' %>% exists()) {
      r <- reticulate::import("requests")
      assign('r', r, envir = .GlobalEnv)
      return(r)
    }
  }

#' Install requests module
#'
#' @return invisible
#' @export
#'
#' @examples
install_requests <-
  function() {
    system("pip install requests")
  }


generate_headers <-
  function(headers = NULL) {
    if (!headers %>% purrr::is_null()) {
      headers <-
        headers %>%
        reticulate::dict()
      return(headers)
    }

  }


#' Request Head
#'
#' @param url
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
head <-
  function(url, ...) {
    check_url(url = url)
    import_requests()
    resp <-
      r$head(url = url, ...)
    resp$close()
    gc()
    closeAllConnections()
    resp
  }

#' Delete
#'
#' @param url
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
delete <-
  function(url, ...) {
    check_url(url = url)
    import_requests()
    resp <-
      r$delete(url = url, ...)
    resp$close()
    gc()
    closeAllConnections()
    resp
  }


#' Options
#'
#' @param url
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
options <- function(url, ...) {
  check_url(url = url)
  import_requests()
  resp <-
    r$options(url = url, ...)
  resp$close()
  gc()
  closeAllConnections()
  resp
}

#' Put
#'
#' @param url
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
put <- function(url, ...) {
  check_url(url = url)
  import_requests()
  resp <-
    r$options(url = url, ...)
  resp$close()
  gc()
  closeAllConnections()
  resp
}

