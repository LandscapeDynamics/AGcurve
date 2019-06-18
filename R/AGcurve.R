#' @name AGcurve
#' @title Wrapper for producing an AG-curve.
#' @description Convenient wrapper for producing an AG-curve from spatial
#'   coordinates.
#' @importFrom stats cutree dist hclust
#' @param xy A numeric array of spatial coordinates.
#' @param method A character string passed to hclustDist() that specifies the
#'   hierarchical clustering method to be passed to stats::hclust.
#' @param dS An optional numeric value passed to hclustDist() that specifies the
#'   denominator used in down-scaling each value of input xy.
#' @details hclustDist returns a data frame consisting of the numbers of clusters
#'   as a function of height in the dendrogram.
#' @return Returns a data frame of height and k values describing the AG-curve
#'   suitable for plotting.
#' @examples
#' xy <- data.frame(x=sample(1:100, size=20,   # Some example coordinates
#'                           replace=TRUE,     # weighted toward 1
#'                           prob=2^(100:1)),
#'                  y=sample(1:100, size=20,
#'                           replace=TRUE,
#'                           prob=2^(100:1)))
#' rownames(xy) <- LETTERS[1:20]               # Set names of coord points
#' fit <- hclustDist(xy, method="single")      # Dendrogram
#' AG <- AGcurve(xy, method="single")          # AG-curve
#'
#' # Plot
#' par(mfrow=c(1,2))                           # Set multiplot panels
#' layout(matrix(c(1,2,2), nrow=1, ncol=3))    # Customize size of plot panels
#' plot(fit, xlab='Cluster Group')             # Plot dendrogram
#' plot(AG$k, AG$h, type='b',
#'      xlab='Numnber of Clusters (k)',        # Plot AG-curve
#'      ylab='Height, h[k]',
#'      main='AG-curve (corresponds to rate of branching in dendrogram)')
#' @author Bjorn J. Brooks
#' @export

###
# Returns the AG curve values (includes scaling, distance matrix
#  calculation, clustering, and aggregating dendrogram)
AGcurve <- function(xy, method='ward.D', dS=NULL) {
  # Custom fxn that returns the number of unique elements
  lenU <- function(x) {length(unique(x))}

  fit <- hclustDist(xy, method=method, dS=dS)      # Generate dendrogram
  k <- length(fit$height):1
  h <- fit$height                                  # Values of h
  output <- data.frame(k=k, height=h)

  return(output)
}
