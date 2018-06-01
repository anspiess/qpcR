\name{pcropt1}
\alias{pcropt1}

\title{Combinatorial elimination of plateau and ground phase cycles}

\description{
The estimation of PCR efficiency and calculation of initial fluorescence \eqn{F_0} is analyzed by refitting the (optimized) model on subsets of the data, thereby using all possible combinations of datapoints. The estimated parameters are then collated in a dataframe. This is intended to be the prerequisite for finding the optimal datapoints that minimize the fit or exhibit the best correlation to a calibration curve. This approch is an extension to the method described in Rutledge \emph{et al}. (2004). The result of any collected parameter can then be displayed by a rank-colored bubbleplot. See 'Examples'.
}

\usage{
pcropt1(object, fact = 3, opt = FALSE, plot = TRUE, bubble = NULL, ...)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{fact}{numeric. The multiplier for the scan border. See 'Details'.} 
  \item{opt}{logical. If \code{true}, model selection is applied for each combination of cycles. Beware: Slow!!} 
  \item{plot}{logical. If \code{TRUE}, the iterative plotting is displayed, which makes the method a bit slower.}
  \item{bubble}{either \code{NULL} for no bubble plot or any parameter (given as a character vector) in the result matrix to be displayed as a bubble plot. See 'Examples'.}
  \item{...}{other parameters to be passed on to \code{\link{efficiency}}, \code{\link{mselect}} or \code{qpcR:::bubbleplot}.}
}

\details{
It has been shown by Rutledge (2004) that the estimation of PCR efficiency gives more realistic values when the number of plateau cycles are decreased. This paradigm is the basis for this function, but we also consider the cycles in the ground phase and all combinations between ground/plateau cycles. All datapoints between the lower border cpD1 - \code{fact} * (cpD1 - cpD2) and upper border cpD1 + \code{fact} * (cpD1 - cpD2) are cycled through.
}

\value{
A matrix with the selected border values, goodness-of-fit measures as obtained from \code{\link{pcrGOF}} and efficiency and \eqn{F_0} values from \code{\link{efficiency}}.
}

\author{
Andrej-Nikolai Spiess
}

\references{
Sigmoidal curve fitting redefines quantitative real-time PCR with the prospective of developing automated high-throughput applications.\cr
Rutledge RG.\cr
\emph{Nucleic Acids Research} (2004), \bold{32}: e178.
}

\examples{
\dontrun{
## Optimize fit and display bubbleplot of R-square.
m1 <- pcrfit(reps, 1, 2, l4)
res1 <- pcropt1(m1, plot = FALSE, bubble = "Rsq")
}
}


\keyword{models}
\keyword{nonlinear}
