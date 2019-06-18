#' @name cumGain
#' @title Calculates the cumulative gain between sequential values.
#' @description Calculate the sum of every gain in a series, i.e., for the series x = 4, 3, 2, 5, 6 the cumulative gain is 3 + 1 = 4.
#' @param x A numeric vector of values.
#' @details cumGain returns the cumulative gain between consecutive values in a series.
#' @return Returns a single value sum of all gains.
#' @examples
#' x <- c(400, 500, 500, 450, 550)  # Some example elevation values
#' cumGain(x)                       # Calc. cum gain (AKA tot. ascent)
#' @author Bjorn J. Brooks
#' @export

###
cumGain <- function(x) {
  y <- x - c(x[1], x[-length(x)])            # Calculate lagged residual
  y[which(y < 0)] <- NA                      # Set negative changes to NA
  output <- sum(y, na.rm=TRUE)               # Sum all changes
  return(output)
}
