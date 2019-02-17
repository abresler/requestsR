post.basic <-
  function(url = 'http://httpbin.org/post',
           ...) {
    check_url(url = url)
    import_requests()

    if ('data' %>% exists()) {
      data <-
        data %>%
        jsonlite::toJSON(auto_unbox = TRUE)
    }

    if ('params' %>% exists()) {
      params <- params %>% dict()
    }

    if ('headers' %>% exists()) {
      headers <-
        reticulate::dict(headers)
    }
    resp <- r$post(url = url, ...)
    resp$close()
    gc()
    resp
  }

#' Request post
#'
#' @param url a url
#' @param auth a list of authentication variables \code{
#' list(username = "user", password = "pwd")
#' } or \code{NULL}
#' @param parse_to_json if not \code{NULL} returns JSON, to return parsed JSON
#' if possible, list(is_tibble = TRUE)
#' @param parse_to_html if \code{true}
#' @param ... Other parameters passable to the get verb.
#' Including \itemize{
#' \item cookies: dictionary or list of cookies
#' \item headers: dictionary or list of headers
#' \item params: tuple or list of parameters
#' \item timeout: vector of timeout
#' \item data: list of data parameters
#' }
#'
#' @return request module, json or HTML depending on input
#' @export
#' @import dplyr purrr
#' @examples
Post <-
  function(url = NULL,
           auth = NULL,
           parse_json = NULL,
           # list(parse_to_json = TRUE, return_tibble = FALSE)
           parse_html = FALSE,
           ...) {

    if (url %>% purrr::is_null()) {
      stop("Please enter url")
    }
    resp <-
      post.basic(url = url, ...)

    has_json <-
      !parse_json %>% purrr::is_null()

    if (has_json) {
      if (parse_json %>% tibble::has_name("is_tibble")) {
        if (parse_json[['is_tibble']] == T) {
          df <-
            resp %>%
            parse_response_json(is_tibble = TRUE)
        } else {
          df <-
            resp %>%
            parse_response_json(is_tibble = FALSE)
        }
      } else {
        df <-
          resp %>%
          parse_response_json(is_tibble = FALSE)
      }

      return(df)
    }

    if (parse_html) {
      page <-
        resp %>%
        parse_response_html()

      return(page)
    }

    resp
  }