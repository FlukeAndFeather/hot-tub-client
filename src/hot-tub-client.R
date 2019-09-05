library(serial)
library(lubridate)
library(tidyverse)

# Initialize connection to Arduino serial
init_ar <- function(file) {
  file(file, open = "a+")
}

# Read from Arduino serial
read_ar <- function(con, what = character(0), nmax = 1) {
  scan(con, what = what, nmax = nmax, quiet = TRUE)
}
read_ar_dbl <- function(con, nmax = 1) {
  scan(con, what = numeric(0), nmax = nmax, quiet = TRUE)
}
read_ar_chr <- function(con, nmax = 1) {
  scan(con, what = character(0), nmax = nmax, quiet = TRUE)
}

# Write to Arduino serial
write_ar <- function(con, msg) {
  write(msg, con)
}

# Read submersible thermometer
read_ts <- function(con) {
  response <- read_ar(con)
  n_attempts <- 15
  att <- 1
  while (length(response) == 0 && att <= n_attempts) {
    write_ar(con, "TS:")
    response <- read_ar(con)
    att <- att + 1
    Sys.sleep(0.1)
  }
  if (length(response) == 0) {
    stop("Err in read_ts: request timeout")
  }
  if (str_sub(response, 1, 2) != "TS") {
    stop(sprintf("Err in read_ts: %s", response))
  }
  parse_number(response)
}

ar_con <- init_ar("/dev/cu.usbmodem141101")
replicate(10, read_ts(ar_con))
