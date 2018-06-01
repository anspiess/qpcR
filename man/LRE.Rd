\name{LRE}
\alias{LRE}

\title{Calculation of qPCR efficiency by the 'linear regression of efficiency' method}

\description{
The LRE method is based on a linear regression of raw fluorescence versus efficiency, with the final aim to obtain cycle dependent individual efficiencies \eqn{E_n}. A linear model is then fit to a sliding window of defined size(s) and within a defined border. Regression coefficients are calculated for each window, and from the window of maximum regression, parameters such as PCR efficiency and initial template fluorescence are calculated. See 'Details' for more information. This approach is quite similar to the one in \code{\link{sliwin}}, but while \code{sliwin} regresses cycle number versus log(fluorescence), \code{LRE} regresses raw fluorescence versus efficiency. Hence, the former is based on assuming a constant efficiency for all cycles while the latter is based on a per-cycle individual efficiency.
}

\usage{
LRE(object, wsize = 6, basecyc = 1:6, base = 0, border = NULL, 
    plot = TRUE, verbose = TRUE, ...)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{wsize}{the size(s) of the sliding window(s), default is \code{6}. A sequence such as \code{4:6} can be used to optimize the window size.}
  \item{basecyc}{if \code{base != 0}, which cycles to use for an initial baseline estimation based on the averaged fluorescence values.}
   \item{base}{either \code{0} for no baseline optimization, or a scalar defining multiples of the standard deviation of all baseline points obtained from \code{basecyc}. These are iteratively subtracted from the raw data. See 'Details' and 'Examples'.}
   \item{border}{either \code{NULL} (default) or a two-element vector which defines the border from the take-off point to points nearby the upper asymptote (saturation phase). See 'Details'.}
   \item{plot}{if \code{TRUE}, the result is plotted with the fluorescence/efficiency curve, sliding window, regression line and baseline.}	
  \item{verbose}{logical. If \code{TRUE}, more information is displayed in the console window.}
  \item{...}{only used internally for passing the parameter matrix.}
}

\details{
To avoid fits with a high \eqn{R^2} in the baseline region, some border in the data must be defined. In \code{LRE}, this is by default (\code{base = NULL}) the region in the curve starting at the take-off cycle (\eqn{top}) as calculated from \code{\link{takeoff}} and ending at the transition region to the upper asymptote (saturation region). The latter is calculated from the first and second derivative maxima: \eqn{asympt = cpD1 + (cpD1 - cpD2)}. If the border is to be set by the user, \code{border} values such as \code{c(-2, 4)} extend these values by \eqn{top + border[1]} and \eqn{asympt + border[2]}. The efficiency is calculated by \eqn{E_n =  \frac{F_n}{F_{n-1}}} and regressed against the raw fluorescence values \eqn{F}: \eqn{E = F\beta + \epsilon}. For the baseline optimization, 100 baseline values \eqn{Fb_i} are interpolated in the range of the data: \deqn{F_{min} \le Fb_i \le base \cdot \sigma(F_{basecyc[1]}...F_{basecyc[2]})} and subtracted from \eqn{F_n}. For all iterations, the best regression window in terms of \eqn{R^2} is found and its parameters returned.
Two different initial template fluorescence values \eqn{F_0} are calculated in \code{LRE}:\cr

\code{init1}: Using the single maximum efficiency \eqn{E_{max}} (the intercept of the best fit) and the fluorescence at second derivative maximum \eqn{F_{cpD2}}, by
\deqn{F_0 = \frac{F_{cpD2}}{E_{max}^{cpD2}}}
\code{init2}: Using the cycle dependent efficiencies \eqn{E_n} from \eqn{n = 1} to the near-lowest integer (floor) cycle of the second derivative maximum \eqn{n = \lfloor cpD2 \rfloor}, and the fluorescence at the floor of the second derivative maximum \eqn{F_{\lfloor cpD2 \rfloor}}, by
\deqn{F_0 = \frac{F_{\lfloor cpD2 \rfloor}}{\prod E_n}}
This approach corresponds to the paradigm described in Rutledge & Stewart (2008), by using cycle-dependent and decreasing efficiencies \eqn{\Delta_E} to calculate \eqn{F_0}.
}

\value{
A list with the following components:
  \item{eff}{the maximum PCR efficiency \eqn{E_{max}} calculated from the best window.}
  \item{rsq}{the maximum \eqn{R^2}.}
  \item{base}{the optimized baseline value.}
  \item{window}{the best window found within the \code{border}s.}  
  \item{parMat}{a matrix containing the parameters as above for each iteration.}
  \item{init1}{the initial template fluorescence \eqn{F_0} assuming constant efficiency \eqn{E_{max}} as described under 'Details'.}
  \item{init2}{the initial template fluorescence \eqn{F_0}, assuming cycle-dependent efficiency \eqn{E_n} as described under 'Details'.}
}

\author{
Andrej-Nikolai Spiess
}

\references{
A kinetic-based sigmoidal model for the polymerase chain reaction and its application to high-capacity absolute quantitative real-time PCR.\cr
Rutledge RG & Stewart D.\cr
\emph{BMC Biotech} (2008), \bold{8}: 47.\cr
}

\examples{
\dontrun{
## Sliding window of size 5 between take-off point 
## and 3 cycles upstream of the upper asymptote 
## turning point, one standard deviation baseline optimization.
m1 <- pcrfit(reps, 1, 2, l4)
LRE(m1, wsize = 5, border = c(0, 3), base = 1)
}
}

\keyword{models}
\keyword{nonlinear}
