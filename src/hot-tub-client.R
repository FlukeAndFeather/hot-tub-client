library(serial)
library(lubridate)
library(tidyverse)

init_ar <- function(file) {
  file(file, open = "rw")
}

read_ar <- function(con, what, nmax = 1) {
  scan(con, what = what, nmax = nmax, quiet = TRUE)
}
read_ar_dbl <- function(con, nmax = 1) {
  scan(con, what = numeric(0), nmax = nmax, quiet = TRUE)
}
read_ar_chr <- function(con, nmax = 1) {
  scan(con, what = character(0), nmax = nmax, quiet = TRUE)
}

ar_con <- init_ar("/dev/cu.usbmodem141101")
read_ar_dbl(ar_con)
