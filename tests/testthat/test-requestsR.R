library(requestsR)
library(dplyr)
library(reticulate)
library(jsonlite)
# basic.get -------------------------------------------------------------------

resp <-
  Get(url = 'https://api.github.com/events')

json_data <-
  resp %>%
  parse_response_json(is_data_frame = F)

json_data


# basic.post --------------------------------------------------------------
resp <-
  post(url = 'http://httpbin.org/post', data = list(key = "value"))
resp %>%
  parse_response_json(is_data_frame = FALSE)

# other -------------------------------------------------------------------
resp <-
  put(url = 'http://httpbin.org/post', data = list(key = "value"))
resp = delete(url = 'http://httpbin.org/delete')
resp$apparent_encoding
resp = head('http://httpbin.org/get')
resp = options('http://httpbin.org/get')


# payloads ----------------------------------------------------------------
payload <- "{'key1': 'value1', 'key2': 'value2'}" %>% convert_dictionary_to_list()
resp <- Get(url = 'http://httpbin.org/get', params = payload)
resp %>% parse_response_json()

# headers -----------------------------------------------------------------

headers <-
  "{'user-agent': 'my-app/0.0.1'}" %>%
  convert_dictionary_to_list()
Get(url = 'https://api.github.com/some/endpoint', headers = headers)


# Post.Complicated --------------------------------------------------------

payload <-
  "{'key1': 'value1', 'key2': 'value2'}" %>%
  convert_dictionary_to_list()
resp <- post("http://httpbin.org/post", data = payload, headers = headers)
resp$text
resp$headers
resp %>%
  parse_response_json()


# Post.tupl ---------------------------------------------------------------

payload <-
  tuple(tuple('key1', 'value1'),
        tuple('key1', 'value2'))
resp <- post('http://httpbin.org/post', data = payload)

# cookies -----------------------------------------------------------------

cookies <-
  dict(cookies_are = 'working')

cookies_list <-
  list(cookies_are = 'working')

resp <-
  Get(url = 'http://httpbin.org/cookies', cookies = cookies)

resp2 <-
  Get(url = 'http://httpbin.org/cookies', cookies = cookies_list)

resp$text == resp2$text


# response_content --------------------------------------------------------
resp <- get('https://api.github.com/events')
resp$text
resp %>% parse_response_json()
resp$encoding

# json get ----------------------------------------------------------------
resp <- Get(url = 'https://api.github.com/repos/requests/requests/issues/482')
resp$status_code
resp %>%
  parse_response_json(is_data_frame = FALSE)


# options -----------------------------------------------------------------

resp <- requestsR::options(url = "http://a-good-website.com/api/cats")
resp$headers
r$status_codes$code

Get(url = 'https://github.com', timeout = 5)
