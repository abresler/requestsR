#' Generate random url references
#'
#' Creates random url references
#' for use in headers
#'
#'
#' @return a data frame
#' @export
#' @import dplyr purrr stringr
#' @examples
generate_url_reference <-
  function() {
    user_agents <-
      c(
        "Mozilla/5.0 (Linux; U; en-US) AppleWebKit/528.5+ (KHTML, like Gecko, Safari/528.5+) Version/4.0 Kindle/3.0 (screen 600x800; rotate)",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246",
        "Mozilla/5.0 (X11; CrOS x86_64 8172.45.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.64 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36"
      )


    user_agent <-
      user_agents[!user_agents %>% str_detect("bot|slurp")] %>%
      sample(1)

    tl_domain <-
      c('.com', '.gov', '.org', '.mil', '.co') %>%
      sample(1)

    word_length <-
      8:15

    words <-
      word_length %>% sample(1)

    domain_slug <-
      1:words %>%
      map_chr(function(x) {
        sample(letters, 1)
      }) %>%
      paste0(collapse = '')

    url <-
      list('http://', domain_slug, tl_domain) %>%
      purrr::reduce(paste0)
    df <-
      data_frame(urlReferer = url,
                 userAgent = user_agent)
    return(df)
  }


check_url <-
  function(url = NULL) {
    if (url %>% purrr::is_null()) {
      stop("Please enter a url")
    }
    return(invisible())
  }

#' Parse response json
#'
#' Parses response object
#' content into JSON
#'
#' @param resp response module
#' @param is_data_frame if \code{TRUE} returns a data frame
#'
#' @return
#' JSON object or \code{data_frame}
#' @export
#'
#' @examples
parse_from_json <-
  function(resp, is_data_frame = FALSE) {
    json_df <-
      resp$content %>%
      jsonlite::fromJSON(flatten = TRUE)

    if (is_data_frame) {
      json_df <-
        json_df %>%
        dplyr::as_data_frame()
    }

    json_df
  }

#' Parse response html
#'
#' Parses response object's
#' content into html
#'
#'
#' @param resp response module
#'
#' @return an html object
#' @export
#'
#' @examples
parse_from_html <-
  function(resp) {
    html <-
      resp$content %>%
      stringi::stri_trans_general("Latin-ASCII") %>%
      xml2::read_html()

    html
  }

#' Converty Python dictionary to list
#'
#' @param text vector of text
#' @param assign_name if not NULL assigns output to environment
#'
#' @return a list
#' @export
#'
#' @examples
convert_dictionary_to_list <-
  function(text = "{'DNT': '1', 'Accept-Encoding': 'gzip, deflate', 'Accept-Language': 'en-US,en;q=0.9', 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36', 'Accept': 'text/html, */*; q=0.01', 'Referer': 'http://www.cpifinancial.net/analytics/bme100', 'X-Requested-With': 'XMLHttpRequest', 'Connection': 'keep-alive'}",
           assign_name = NULL) {
    func_call <-
      text %>% str_replace_all("\\: ", "\\=") %>% str_replace_all("\\{", "list(") %>% str_replace_all("\\}", "\\)")
    if (!assign_name %>% purrr::is_null()) {
      assign(
        x = assign_name,
        value = func_call %>%
          rlang::parse_expr(x = .) %>%
          eval(),
        envir = .GlobalEnv
      )
    }
    func_call %>%
      rlang::parse_expr(x = .) %>%
      eval()
  }