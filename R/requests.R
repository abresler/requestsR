#' Import requests module
#'
#' Imports request module into
#' your global environment as r
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


#' Request header
#'
#'
#' @param url a url
#' @param ... Other parameters passable to the head verb.
#' Including \itemize{
#' \item cookies: dictionary or list of cookies
#' \item headers: dictionary or list of headers
#' \item params: tuple or list of parameters
#' \item timeout: vector of timeout
#' \item data: list of data parameters
#' }
#'
#' @return a python request object
#' @export
#'
#' @examples
Head <-
  function(url, ...) {
    check_url(url = url)
    import_requests()
    resp <-
      r$head(url = url, ...)
    resp$close()

    resp
  }

#' Request delete
#'
#' @param url a url
#' @param ... Other parameters passable to the delete verb.
#' Including \itemize{
#' \item cookies: dictionary or list of cookies
#' \item headers: dictionary or list of headers
#' \item params: tuple or list of parameters
#' \item timeout: vector of timeout
#' \item data: list of data parameters
#' }
#'
#' @return a python request object
#' @export
#'
#' @examples
Delete <-
  function(url, ...) {
    check_url(url = url)
    import_requests()
    resp <-
      r$delete(url = url, ...)
    resp$close()

    resp
  }


#' Request options
#'
#' @param url a url
#' @param ... Other parameters passable to the option verb.
#' Including \itemize{
#' \item cookies: dictionary or list of cookies
#' \item headers: dictionary or list of headers
#' \item params: tuple or list of parameters
#' \item timeout: vector of timeout
#' \item data: list of data parameters
#' }
#'
#' @return a python request object
#' @export
#'
#' @examples
Options <- function(url, ...) {
  check_url(url = url)
  import_requests()
  resp <-
    r$options(url = url, ...)
  resp$close()

  resp
}

#' Request put
#'
#' @param url a url
#' @param ... Other parameters passable to the head verb.
#' Including \itemize{
#' \item cookies: dictionary or list of cookies
#' \item headers: dictionary or list of headers
#' \item params: tuple or list of parameters
#' \item timeout: vector of timeout
#' \item data: list of data parameters
#' }
#'
#' @return a python request object
#' @export
#'
#' @examples
Put <- function(url, ...) {
  check_url(url = url)
  import_requests()
  resp <-
    r$options(url = url, ...)
  resp$close()

}

