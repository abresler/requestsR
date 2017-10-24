requestsR
================

`requestsR` : Python's Requests module for R

Ref: <http://docs.python-requests.org/>

> *"Requests is an elegant and simple HTTP library for Python {and now R}, built for human beings. You are currently looking at the documentation of the development release.."*

### Background

R has a number of great packages for interacting with web data but it still lags behind Python in large part because of the power and ease of use of the Requests module.

This package aims to port those powers to R, I like to think of this package as the [Bo Jackson](https://en.wikipedia.org/wiki/Bo_Jackson) of web interaction tools.

![requestsR Logo](http://asbcllc.com/r_packages/requestsR/logo/reqestsRLogo.png)

It is fast, agile, powerful, clean and now it plays 2 languages!

### Caveats

. This is not intended to replace `httr`, `curl`, `rvest`, or whatever package you use to interact with web data. In fact, in many cases you will want to use `requestsR` in concert with those packages, especially `curl` and `rvest`. I have found that `requestsR` comes in most handy for very complex web scraping tasks that require multiple headers, parameters and cookies.

### Installation

This package requires Python and the `requests` module.

To install Requests in R you can run:

``` r
system("pip install requests")
```

### Work-horse functions

-   `import_requests`: imports requests module for full use in R
-   `Get`: mimics python get request
-   `post`: mimics python post request

### Other functions

-   `Head`: mimics python head request
-   `delete`: mimcs python delete request
-   `put`: mimics python put request

#### Mungers

-   `convert_dictionary_to_list`: converts dictionary to list
-   `parse_response_html`: parses html from response object
-   `parse_response_json`: parses JSON from response object

### Installation

``` r
devtools::install_github("abresler/requestsR")
```

``` r
options(width=120)
```

### Usage

Please feel free to take a look at [this](%22http://abresler.github.io/r_packages/requestsR/introduction/index.html%22) introductory blog post that outlines how to use the package.
