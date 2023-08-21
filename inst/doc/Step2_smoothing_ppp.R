## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----setup, include = FALSE---------------------------------------------------
library(geocausal)

## ----load data, include = FALSE-----------------------------------------------
# Vignette 1 -----
airstrikes <- geocausal::airstrikes
insurgencies <- geocausal::insurgencies
iraq_window <- geocausal::iraq_window

# 1. Treatment data

## 1-1. Convert time variable to numerics
airstrikes$time <- as.numeric(airstrikes$date - min(airstrikes$date) + 1)

## 1-2. Generate a hyperframe
treatment_hfr <- get_hfr(data = airstrikes,
                         subtype_column = "type",
                         window = iraq_window,
                         time_column = "time",
                         time_range = c(1, max(airstrikes$time)),
                         coordinates = c("longitude", "latitude"),
                         combined = TRUE)

# 2. Outcome data

## 2-1. Convert time variable to numerics
insurgencies$time <- as.numeric(insurgencies$date - min(insurgencies$date) + 1)

outcome_hfr <- get_hfr(data = insurgencies,
                       subtype_column = "type",
                       window = iraq_window,
                       time_column = "time",
                       time_range = c(1, max(insurgencies$time)),
                       coordinates = c("longitude", "latitude"),
                       combined = TRUE)

# 3. Combine two hyperframes
dat_hfr <- spatstat.geom::cbind.hyperframe(treatment_hfr, outcome_hfr[, -1])
names(dat_hfr)[names(dat_hfr) == "all_combined"] <- "all_treatment"
names(dat_hfr)[names(dat_hfr) == "all_combined.1"] <- "all_outcome"

## -----------------------------------------------------------------------------
# Smoothing
smooth_allout <- get_smoothed_outcome(data_interest = dat_hfr$all_outcome,
                                      method = "mclust", initialization = TRUE,
                                      sampling = 0.05)

# Save the output
dat_hfr$smooth_allout <- smooth_allout

