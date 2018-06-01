\name{expfit}
\alias{expfit}

\title{Calculation of PCR efficiency by fitting an exponential model}

\description{
An exponential model is fit to a window of defined size on the qPCR raw data. The window is identified either by the second derivative maximum 'cpD2' (default), 'studentized outlier' method as described in Tichopad \emph{et al}. (2003), the 'midpoint' method (Peirson \emph{et al}., 2003) or by subtracting the difference of cpD1 and cpD2 from cpD2 ('ERBCP', unpublished).
}

\usage{
expfit(object, method = c("cpD2", "outlier", "midpoint", "ERBCP"),
       model = c("exp", "linexp"), offset = 0, pval = 0.05, n.outl = 3, 
       n.ground = 1:5, corfact = 1, fix = c("top", "bottom", "middle"), 
       nfit = 5, plot = TRUE, ...) 
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{method}{one of the four possible methods to be used for defining the position of the fitting window.}
  \item{model}{which exponential model to use. \code{\link{expGrowth}} is default, but the linear-exponential model \code{\link{linexp}} can also be chosen.}
  \item{offset}{for \code{method = "cpD2"}, the cycle offset from second derivative maximum.}
  \item{pval}{for \code{method = "outlier"}, the p-value for the outlier test.}
  \item{n.outl}{for \code{method = "outlier"}, the number of successive outlier cycles.}
  \item{n.ground}{for \code{method = "midpoint"}, the number of cycles in the noisy ground phase to calculate the standard deviation from.}
  \item{corfact}{for \code{method = "ERBCP"}, the correction factor for finding the exponential region. See 'Details'.}
  \item{fix}{for methods "midpoint" and "ERBCP", the orientation of the fitting window based on the identified point. See 'Details'.} 
  \item{nfit}{the size of the fitting window.}
  \item{plot}{logical. If \code{TRUE}, a graphical display of the curve and the fitted region is shown.}
  \item{...}{other parameters to be passed to the plotting function.} 
}

\details{
The exponential growth function \eqn{f(x) = a \cdot exp(b \cdot x) + c} is fit to a subset of the data. Calls \code{\link{efficiency}} for calculation of the second derivative maximum, \code{\link{takeoff}} for calculation of the studentized residuals and 'outlier' cycle, and \code{midpoint} for calculation of the exponential phase 'midpoint'. For method 'ERBCP' (Exponential Region By Crossing Points), the exponential region is calculated by \eqn{expR = cpD2 - \code{corfact} \cdot (cpD1-cpD2)}. The efficiency is calculated from the exponential fit with \eqn{E = exp(b)} and the inital template fluorescence \eqn{F_0 = a}.
}

\value{
 A list with the following components:
  \item{point}{the point within the exponential region as identified by one of the three methods.}
  \item{cycles}{the cycles of the identified region.}
  \item{eff}{the efficiency calculated from the exponential fit.}
  \item{AIC}{the Akaike Information Criterion of the fit.}
  \item{resVar}{the residual variance of the fit.}
  \item{RMSE}{the root-mean-squared-error of the fit.}
  \item{init}{the initial template fluorescence.}
  \item{mod}{the exponential model of class 'nls'.}
}

\author{
Andrej-Nikolai Spiess
}

\references{
Standardized determination of real-time PCR efficiency from a single reaction set-up.\cr
Tichopad A, Dilger M, Schwarz G & Pfaffl MW.\cr
\emph{Nucleic Acids Research} (2003), \bold{31}:e122.

Comprehensive algorithm for quantitative real-time polymerase chain reaction.\cr
Zhao S & Fernald RD.\cr
\emph{J Comput Biol} (2005), \bold{12}:1047-64.
}

\examples{
## Using default SDM method.
m1 <- pcrfit(reps, 1, 2, l5)
expfit(m1)

## Using 'outlier' method.
expfit(m1, method = "outlier")

## Linear exponential model.
expfit(m1, model = "linexp")
}

\keyword{models}
\keyword{nonlinear}
