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
    closeAllConnections()
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
    closeAllConnections()
    resp
  }


#' Get VERB
#'
#' @param url a url
#' @param auth a list of authentication variables or \code{NULL}
#' @param parse_to_json
#' @param parse_to_html
#' @param ... Other parameters passable to the get verb. Including \itemize{
#' \item cookies
#' \item headers
#' \item params
#' \item timeout
#' }
#'
#' @return
#' @export
#' @import dplyr purrr
#' @examples
get <-
  function(url,
           auth = NULL,
           parse_json = NULL,
           # list(parse_to_json = TRUE, return_data_frame = FALSE)
           parse_html = FALSE,
           ...) {

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
        parse_from_json(is_data_frame = TRUE)
      } else {
        df <-
          resp %>%
          parse_from_json(is_data_frame = FALSE)
      }
      } else {
        df <-
          resp %>%
          parse_from_json(is_data_frame = FALSE)
      }

      return(df)
    }

    if (parse_html) {
      page <-
        resp %>%
        parse_from_html()

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
          parse_from_json(is_data_frame = TRUE)
      } else {
        df <-
          resp %>%
          parse_from_json(is_data_frame = FALSE)
      }
    } else {
      df <-
        resp %>%
        parse_from_json(is_data_frame = FALSE)
    }

    return(df)
  }

  if (parse_html) {
    page <-
      resp %>%
      parse_from_html()

    return(page)
  }

  resp

}