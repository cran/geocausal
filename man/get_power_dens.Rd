% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_power_dens.R
\name{get_power_dens}
\alias{get_power_dens}
\title{Get power densities}
\usage{
get_power_dens(target_dens, priorities, window, grayscale = FALSE)
}
\arguments{
\item{target_dens}{list of target densities}

\item{priorities}{vector of priorities for each of target densities}

\item{window}{owin object}

\item{grayscale}{logical. `grayscale` specifies whether to convert plot to grayscale (by default, FALSE).}
}
\value{
list of an im object and a ggplot object of power densities
}
\description{
`get_power_dens()` takes the target densities and their priorities
and returns a power density.
}
\examples{
# Density 1: Distance from Mosul
dist_from_mosul <- get_dist_focus(window = iraq_window,
                                  longitude = c(43.158),
                                  latitude = c(36.349),
                                  resolution = 0.5,
                                  grayscale = FALSE,
                                  mile = FALSE,
                                  preprocess = FALSE)

# Density 2: Distance from Baghdad
dist_from_baghd <- get_dist_focus(window = iraq_window,
                                  longitude = c(44.366),
                                  latitude = c(33.315),
                                  resolution = 0.5,
                                  grayscale = FALSE,
                                  mile = FALSE,
                                  preprocess = FALSE)
                                  
# Power density
get_power_dens(target_dens = list(dist_from_mosul[[1]], dist_from_baghd[[1]]),
               priorities = c(3, 2), 
               window = iraq_window,
               grayscale = FALSE)
}
