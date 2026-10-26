pkg <- "requestsR"

test_that("requestsR namespace loads", {
  expect_true(requireNamespace(pkg, quietly = TRUE))
})

test_that("every NAMESPACE export() exists in the namespace", {
  ns <- readLines(system.file("NAMESPACE", package = pkg))
  declared <- grep("^export\\(", ns, value = TRUE)
  declared <- sub("^export\\((.*)\\)$", "\\1", declared)
  declared <- trimws(gsub("\"", "", unlist(strsplit(declared, ","))))
  expect_gt(length(declared), 0)
  missing <- setdiff(declared, getNamespaceExports(pkg))
  expect_equal(missing, character(0))
})

test_that("parse_response_json parses a response body into a data frame or tibble", {
  resp <- list(content = '[{"id": 7, "name": "widget", "nested": {"k": "v"}}]')
  df <- requestsR::parse_response_json(resp, is_tibble = FALSE)
  expect_s3_class(df, "data.frame")
  expect_equal(df$id, 7)
  expect_equal(df$name, "widget")
  expect_equal(df$nested.k, "v")

  tbl <- requestsR::parse_response_json(resp, is_tibble = TRUE)
  expect_s3_class(tbl, "tbl_df")
  expect_equal(tbl$id, 7)
  expect_equal(tbl$nested.k, "v")
})

test_that("parse_response_html transliterates to ASCII and returns a parsed document", {
  resp <- list(content = "<html><body><p id='x'>café</p></body></html>")
  doc <- requestsR::parse_response_html(resp)
  expect_s3_class(doc, "xml_document")
  expect_equal(xml2::xml_text(xml2::xml_find_first(doc, "//p[@id='x']")), "cafe")
})

test_that("convert_dictionary_to_list turns a python dict string into an R list", {
  out <- requestsR::convert_dictionary_to_list("{'DNT': '1', 'Accept': 'text/html'}")
  expect_equal(out, list(DNT = "1", Accept = "text/html"))
})

test_that("generate_url_reference returns a plausible referer and user agent", {
  df <- requestsR::generate_url_reference()
  expect_equal(nrow(df), 1)
  expect_equal(names(df), c("urlReferer", "userAgent"))
  expect_match(df$urlReferer, "^http://[a-z]{8,15}\\.(com|gov|org|mil|co)$")
  expect_match(df$userAgent, "^Mozilla/5\\.0")
})
