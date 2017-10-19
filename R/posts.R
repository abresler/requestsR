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
    closeAllConnections()
    resp
  }

#' Post verb
#'
#' @param url
#' @param auth
#' @param parse_json
#' @param parse_html
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
post <-
  function(url,
           auth = NULL,
           parse_json = NULL,
           # list(parse_to_json = TRUE, return_data_frame = FALSE)
           parse_html = FALSE,
           ...) {
    resp <-
      post.basic(url = url, ...)

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