get.login <-
  function(url = 'https://api.github.com/user',
           auth = list(user = "user",
                       password = "password"),
           ...) {
    check_url(url = url)
    import_requests()
    user <- auth$user
    password <- auth$password
    login <-
      reticulate::tuple(user, password)

    if ('params' %>% exists()) {
      params <- params %>% dict()
    }

    if ('headers' %>% exists()) {
      headers <-
        reticulate::dict(headers)
    }
    resp <-
      r$get(url = url,
            auth = login,
            ...)
    resp$close()
    gc()
    resp
  }

get.basic <-
  function(url = "http://www.drudgereport.com/", ...) {
    import_requests()
    check_url(url = url)
    if ('params' %>% exists()) {
      params <- params %>% dict()
    }

    if ('headers' %>% exists()) {
      headers <-
        reticulate::dict(headers)
    }

    resp <- r$get(url = url , ...)
    resp$close()
    gc()
    resp
  }


#' Request get
#'
#'
#' @param url a url
#' @param auth a list of authentication variables \code{
#' list(username = "user", password = "pwd")
#' } or \code{NULL} - default
#' @param parse_to_json if not \code{NULL} returns JSON, to return parsed JSON
#' if possible, list(is_data_frame = TRUE)
#' @param parse_to_html if \code{true}
#' @param ... Other parameters passable to the get verb.
#' Including \itemize{
#' \item cookies: dictionary or list of cookies
#' \item headers: dictionary or list of headers
#' \item params: tuple or list of parameters
#' \item timeout: vector of timeout
#' \item data: list of data parameters
#' \item proxy: list or dictionary of proxy settings
#' }
#'
#' @return request module, json or HTML depending on input
#' @export
#' @import dplyr purrr
#' @examples
Get <-
  function(url = NULL,
           auth = NULL,
           parse_json = NULL,
           # list(parse_to_json = TRUE, return_data_frame = FALSE)
           parse_html = FALSE,
           ...) {
    if (url %>% purrr::is_null()) {
      stop("Please enter url")
    }
  if (!auth %>% purrr::is_null()) {
    resp <-
      get.login(url, auth = auth, ...)
    has_json <-
      !parse_json %>% purrr::is_null()

    if (has_json) {



      if (parse_json %>% tibble::has_name("is_data_frame")) {
      if (parse_json[['is_data_frame']] == T) {
        df <-
        resp %>%
        parse_response_json(is_data_frame = TRUE)
      } else {
        df <-
          resp %>%
          parse_response_json(is_data_frame = FALSE)
      }
      } else {
        df <-
          resp %>%
          parse_response_json(is_data_frame = FALSE)
      }

      return(df)
    }

    if (parse_html) {
      page <-
        resp %>%
        parse_response_html()

      return(page)
    }

    return(resp)
  }

  resp <-
    get.basic(url = url, ...)

  has_json <-
    !parse_json %>% purrr::is_null()

  if (has_json) {



    if (parse_json %>% tibble::has_name("is_data_frame")) {
      if (parse_json[['is_data_frame']] == T) {
        df <-
          resp %>%
          parse_response_json(is_data_frame = TRUE)
      } else {
        df <-
          resp %>%
          parse_response_json(is_data_frame = FALSE)
      }
    } else {
      df <-
        resp %>%
        parse_response_json(is_data_frame = FALSE)
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