\name{sliwin}
\alias{sliwin}

\title{Calculation of qPCR efficiency by the 'window-of-linearity' method}

\description{
A linear model of Cycles versus log(Fluorescence) is fit within a sliding window of defined size(s) and within a defined border. Regression coefficients are calculated for each window, and at the point of maximum regression (log-linear range) or least variation in slope, parameters such as PCR efficiency and initial template fluorescence are calculated. From version 1.3-5, an approach "not unlike" to Ruijter et al. (2009) has been implemented, in which baseline values can be iteratively subtracted from the data prior to fitting the sliding window. See 'Details' for more information.  
}

\usage{
sliwin(object, wsize = 6, basecyc = 1:6, base = 0, border = NULL,
       type = c("rsq", "slope"), plot = TRUE, verbose = TRUE, ...)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{wsize}{the size(s) of the sliding window(s), default is \code{6}. A sequence such as \code{4:6} can be used to optimize the window size.}
  \item{basecyc}{if \code{base != 0}, which cycles to use for an initial baseline estimation based on the averaged fluorescence values.}
  \item{base}{either \code{0} for no baseline optimization, or a scalar defining multiples of the standard deviation of all baseline points obtained from \code{basecyc}. These are iteratively subtracted from the raw data. See 'Details' and 'Examples'.}
   \item{border}{either \code{NULL} (default) or a two-element vector which defines the border from the take-off point to points nearby the upper asymptote (saturation phase). See 'Details'.}
   \item{type}{selection of the window with best baseline + maximum \eqn{R^2} (\code{"rsq"}) or best baseline + minimal variance in slope + maximum \eqn{R^2} (\code{"slope"}).}  
  \item{plot}{if \code{TRUE}, the result is plotted with the logarithmized curve, sliding window, regression line and baseline.}	
  \item{verbose}{logical. If \code{TRUE}, more information is displayed in the console window.}
  \item{...}{only used internally for passing the parameter matrix.}
}

\details{
To avoid fits with a high \eqn{R^2} in the baseline region, some border in the data must be defined. In \code{sliwin}, this is by default (\code{base = NULL}) the region in the curve starting at the take-off cycle (\eqn{top}) as calculated from \code{\link{takeoff}} and ending at the transition region to the upper asymptote (saturation region). The latter is calculated from the first and second derivative maxima: \eqn{asympt = cpD1 + (cpD1 - cpD2)}. If the border is to be set by the user, \code{border} values such as \code{c(-2, 4)} extend these values by \eqn{top + border[1]} and \eqn{asympt + border[2]}. The \eqn{log_{10}} transformed raw fluorescence values are regressed against the cycle number \eqn{log_{10}(F) = n\beta + \epsilon} and the efficiency is then calculated by \eqn{E = 10^{slope}}. For the baseline optimization, 100 baseline values \eqn{Fb_i} are interpolated in the range of the data: \deqn{F_{min} \le Fb_i \le base \cdot \sigma(F_{basecyc[1]}...F_{basecyc[2]})} and subtracted from \eqn{F_n}. If \code{type = "rsq"}, the best window in terms of \eqn{R^2} is selected from all iterations, as defined by \code{wsize} and \code{border}. If \code{type = "slope"}, the baseline value delivering the smallest variance in the slope of the upper/lower part of the sliding window and highest \eqn{R^2} is selected. This approach is quite similar to the one in Ruijter et al. (2009) but has to be tweaked in order to obtain the same values as in the 'LinRegPCR' software. Especially the \code{border} value has significant influence on the calculation of the best window's efficiency value. 
}

\value{
A list with the following components:
  \item{eff}{the optimized PCR efficiency found within the sliding window.}
  \item{rsq}{the maximum R-squared.}
  \item{init}{the initial template fluorescence F0.}  
  \item{base}{the optimized baseline value.}
  \item{window}{the best window found within the \code{border}s.}  
  \item{parMat}{a matrix containing the parameters as above for each iteration.}
}

\author{
Andrej-Nikolai Spiess
}

\references{
Assumption-free analysis of quantitative real-time polymerase chain reaction (PCR) data.\cr
Ramakers C, Ruijter JM, Deprez RH, Moorman AF.\cr
\emph{Neurosci Lett} (2003), \bold{339}: 62-65.\cr

Amplification efficiency: linking baseline and bias in the analysis of quantitative PCR data.\cr
Ruijter JM, Ramakers C, Hoogaars WM, Karlen Y, Bakker O, van den Hoff MJ, Moorman AF.\cr
\emph{Nucleic Acids Res} (2009),  \bold{37}: e45
}

\examples{
## Sliding window of size 5 between 
## take-off point and upper asymptote, 
## no baseline optimization.
m1 <- pcrfit(reps, 1, 2, l4)
sliwin(m1, wsize = 5)

\dontrun{
## Optimizing with window sizes of 4 to 6,
## between 0/+2 from lower/upper border, 
## and baseline up to 2 standard deviations.
sliwin(m1, wsize = 4:6, border = c(0, 2), base = 2)
}
}

\keyword{models}
\keyword{nonlinear}
