  #' @name hclustDist
#' @title Wrapper for hierarchical clustering of spatial coordinates.
#' @description Convenient wrapper for hierarchical clustering spatial
#'   coordinates.
#' @importFrom stats dist
#' @importFrom stats hclust
#' @param xy A numeric array of spatial coordinates.
#' @param method A character string specifying the hierarchical clustering
#'   method to be passed to stats::hclust.
#' @param dS An optional numeric value specifying the denominator to be used in
#'   down-scaling each value of input xy.
#' @details hclustDist returns results from hierarchical clustering using the
#'   stats::hclust() function.
#' @return Returns an object of class *hclust*, see stats::hclust.
#' @examples
#' xy <- data.frame(x=c(0, 0, 2, 3),               # Some example coordinates
#'                  y=c(0, 1, 4, 5))
#' rownames(xy) <- LETTERS[1:4]                    # Set names of coord points
#' fit <- hclustDist(xy)
#'
#' # Plot
#' par(mfrow=c(1,2))
#' plot(xy, pch='')
#' text(xy, labels=rownames(xy))
#'
#' plot(fit)
#' @author Bjorn J. Brooks
#' @export

###
hclustDist <- function(xy, method='ward.D', dS=NULL) {
  if (is.numeric(dS)) {                            # If dS specified then
    xy[,1] <- xy[,1] / dS                          #  down-scale values
    xy[,2] <- xy[,2] / dS
  }
  d <- dist(xy, method='euclidean')                # Distance matrix
  invisible(gc())                                  # Liberate memory
  output <- hclust(d, method=method)               # Cluster points

  return(output)
}
