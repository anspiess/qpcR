\name{maxRatio}
\alias{maxRatio}

\title{The maxRatio method as in Shain et al. (2008)}

\description{
The maximum ratio (MR) is determined along the cubic spline interpolated curve of \eqn{\frac{F_n}{F_{n-1}}} and the corresponding cycle numbers FCN and its adjusted version FCNA are then calculated for MR.
}

\usage{
maxRatio(x, method = c("spline", "sigfit"), baseshift = NULL, 
         smooth = TRUE, plot = TRUE, ...)
}

\arguments{
  \item{x}{an object of class 'pcrfit' (single run) or 'modlist' (multiple runs).}
  \item{method}{the parameters are either calculated from the cubic spline interpolation (default) or a sigmoidal fit.}
  \item{baseshift}{numerical. Shift value in case of \code{type = "spline"}. See 'Details'.}
  \item{smooth}{logical. If \code{TRUE} and \code{type = "spline"}, invokes a 5-point convolution filter (\code{\link{filter}}). See 'Details'.} 
  \item{plot}{Should diagnostic plots be displayed?}
  \item{...}{other parameters to be passed to \code{\link{eff}} or \code{\link{plot}}.}     
}

\details{                   
In a first step, the raw fluorescence data can be smoothed by a 5-point convolution filter. This is optional but feasible for many qPCR setups with significant noise in the baseline region, and therefore set to \code{TRUE} as default. If \code{baseshift} is a numeric value, this is added to each response value \eqn{F_n = F_n + baseshift} (baseline shifting). Finally, a cubic spline is fit with a resolution of 0.01 cycles and the maximum ratio (efficiency) is calculated by \eqn{MR = max(\frac{F_n}{F_{n-1}}-1)}. \eqn{FCN} is then calculated as the cycle number at \eqn{MR} and from this the adjusted \eqn{FCNA = FCN -log_2(MR)}. Sometimes problems are encountered in which, due to high noise in the background region, randomly high efficiency ratios are calculated. This must be resolved by tweaking the \code{baseshift} value.  
}

\value{
 A list with the following components:
  \item{eff}{the maximum efficiency. Equals to \code{mr} + 1.}
  \item{mr}{the maximum ratio.}
  \item{fcn}{the cycle number at \code{mr}.}
  \item{fcna}{an adjusted \code{fcn}, as described in Shain et al.}
  \item{names}{the names of the runs as taken from the original dataframe.}  
}

\author{
Andrej-Nikolai Spiess
}

\note{
This function has been approved by the original author (Eric Shain).
}

\references{
A new method for robust quantitative and qualitative analysis of real-time PCR.\cr
Shain EB & Clemens JM.\cr
\emph{Nucleic Acids Research} (2008), \bold{36}: e91.
}

\examples{
## On single curve using baseline shifting.
m1 <- pcrfit(reps, 1, 2, l5)
maxRatio(m1, baseshift = 0.3)     

## On a 'modlist' using baseline shifting.
\dontrun{
ml1 <- modlist(reps, model = l5) 
maxRatio(ml1, baseshift = 0.5)
}
}

\keyword{models}
\keyword{nonlinear}
