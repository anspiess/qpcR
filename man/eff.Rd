\name{eff}
\alias{eff}

\title{The amplification efficiency curve of a fitted object}

\description{
Calculates the efficiency curve from the fitted object by \eqn{E_n = \frac{F_n}{F_{n-1}}}, with \eqn{E} = efficiency, \eqn{F} = raw fluorescence, \eqn{n} = Cycle number. Alternatively, a cubic spline interpolation can be used on the raw data as in Shain \emph{et al}. (2008). 
}

\usage{
eff(object, method = c("sigfit", "spline"), sequence = NULL, baseshift = NULL, 
    smooth = FALSE, plot = FALSE)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{method}{the efficiency curve is either calculated from the sigmoidal fit (default) or a cubic spline interpolation.}
  \item{sequence}{a 3-element vector (from, to, by) defining the sequence for the efficiency curve. Defaults to [min(Cycles), max(Cycles)] with 100 points per cycle.}
  \item{baseshift}{baseline shift value in case of \code{type = "spline"}. See documentation to \code{\link{maxRatio}}.}
  \item{smooth}{logical. If \code{TRUE} and \code{type = "spline"}, invokes a 5-point convolution filter (\code{\link{filter}}). See documentation to \code{\link{maxRatio}}.} 
  \item{plot}{should the efficiency be plotted?}
 }

\value{
A list with the following components:
  \item{eff.x}{the cycle points.}
  \item{eff.y}{the efficiency values at \code{eff.x}.}   
  \item{effmax.x}{the cycle number with the highest efficiency.}
  \item{effmax.y}{the maximum efficiency.}   
}

\details{
For more information about the curve smoothing, baseline shifting and cubic spline interpolation for the method as in Shain \emph{et al}. (2008), see 'Details' in \code{\link{maxRatio}}.
}

\author{
Andrej-Nikolai Spiess
}    

\references{
A new method for robust quantitative and qualitative analysis of real-time PCR.\cr
Shain EB & Clemens JM.\cr
\emph{Nucleic Acids Research} (2008), \bold{36}, e91.
}  

\examples{
## With default 100 points per cycle.
m1 <- pcrfit(reps, 1, 7, l5)
eff(m1, plot = TRUE) 

## Not all data and only 10 points per cycle.
eff(m1, sequence = c(5, 35, 0.1), plot = TRUE) 

## When using cubic splines it is preferred 
## to use the smoothing option.
#eff(m1, method = "spline", plot = TRUE, smooth = TRUE, baseshift = 0.3)  
}

\keyword{models}
\keyword{nonlinear}
