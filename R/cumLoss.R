#' @name cumLoss
#' @title Calculates the cumulative loss between sequential values.
#' @description Calculate the sum of every loss in a series, i.e., for the
#'   series x = 4, 3, 2, 5, 6 the cumulative loss is 1 + 1 = 2.
#' @param x A numeric vector of values.
#' @details cumLoss returns the cumulative loss between consecutive values in a
#'   series.
#' @return Returns a single value sum of all losses.
#' @examples
#' x <- c(400, 500, 500, 450, 550)  # Some example elevation values
#' cumLoss(x)                       # Calc. cum loss (AKA tot. descent)
#' @author Bjorn J. Brooks
#' @export

###
cumLoss <- function(x) {
  y <- x - c(x[1], x[-length(x)])            # Calculate lagged residual
  y[which(y > 0)] <- NA                      # Set postive changes to NA
  output <- abs(sum(y, na.rm=TRUE))          # Sum changes, take abs val
  return(output)
}
