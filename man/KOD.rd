\name{KOD}
\alias{KOD}

\title{(K)inetic (O)utlier (D)etection using several methods}

\description{
Identifies and/or removes qPCR runs according to several published methods or own ideas. The univariate measures are based on efficiency or difference in first/second derivative maxima. Multivariate methods are implemented that describe the structure of the curves according to several fixpoints such as first/second derivative maximum, slope at first derivative maximum or plateau fluorescence. These measures are compared with a set of curves using the \code{\link{mahalanobis}} distance with a robust covariance matrix and calculation of statistics by a \eqn{\chi^2} distribution. See 'Details'.
}

\usage{
KOD(object, method = c("uni1", "uni2", "multi1", "multi2", "multi3"),
    par = parKOD(), remove = FALSE, verbose = TRUE, plot = TRUE,  ...)
}
    

\arguments{
  \item{object}{an object of class 'modlist' or 'replist'.}
  \item{method}{which method to use for kinetic outlier identification. Method \code{"uni1"} is default. See 'Details' for all methods.}
  \item{par}{parameters for the different \code{method}s. See \code{\link{parKOD}}.}
  \item{remove}{logical. If \code{TRUE}, outlier runs are removed and the object is updated. If \code{FALSE}, the individual qPCR runs are tagged as 'outliers' or not. See 'Details'.}
  \item{verbose}{logical. If \code{TRUE}, all calculation steps and results are displayed on the console.}
  \item{plot}{logical. If \code{TRUE}, a multivariate plot is displayed.}
  \item{...}{any other parameters to be passed to \code{\link{sliwin}}, \code{\link{efficiency}} or \code{\link{expfit}}.}
}

\details{
\bold{The following methods for the detection of kinetic outliers are implemented}\cr
\code{uni1}: KOD method according to Bar et al. (2003). Outliers are defined by removing the sample efficiency from the replicate group and testing it against the remaining samples' efficiencies using a Z-test:
\deqn{P = 2 \cdot \left[1 - \Phi\left(\frac{e_i - \mu_{train}}{\sigma_{train}}\right)\right] < 0.05}

\code{uni2}: This method from the package author is more or less a test on sigmoidal structure for the individual curves. It is different in that there is no comparison against other curves from a replicate set. The test is simple: The difference between first and second derivative maxima should be less than 10 cycles:
\deqn{\left(\frac{\partial^3 F(x;a,b,...)}{\partial x^3} = 0\right) - \left(\frac{\partial^2 F(x;a,b...)}{\partial x^2} = 0\right) < 10}
Sounds astonishingly simple, but works: Runs are defines as 'outliers' that really failed to amplify, i.e. have no sigmoidal structure or are very shallow. It is the default setting in \code{\link{modlist}}.\cr

\code{multi1}: KOD method according to Tichopad et al. (2010). Assuming two vectors with first and second derivative maxima \eqn{t_1} and \eqn{t_2} from a 4-parameter sigmoidal fit within a window of points around the first derivative maximum, a linear model \eqn{t_2 = t_1 \cdot b + a + \tau} is made. Both \eqn{t_1} and the residuals from the fit \eqn{\tau = t_2 - \hat{t_2}} are Z-transformed:
\deqn{t_1(norm) = \frac{t_1 - \bar{t}_1}{{\sigma_t}_1}, \; {\tau_1}_{norm} = \frac{\tau_1 - \bar{\tau}_1}{{\sigma_\tau}_1}} 
Both \eqn{t_1} and \eqn{\tau} are used for making a robust covariance matrix. The outcome is plugged into a \code{\link{mahalanobis}} distance analysis using the 'adaptive reweighted estimator' from package 'mvoutlier' and p-values for significance of being an 'outlier' are deduced from a \eqn{\chi^2} distribution. If more than two parameters are supplied, \code{\link{princomp}} is used instead.

\code{multi2}: Second KOD method according to Tichopad et al. (2010), mentioned in the paper. Uses the same pipeline as \code{multi1}, but with the slope at the first derivative maximum and maximum fluorescence as parameters:
\deqn{\frac{\partial F(x;a,b,...)}{\partial x}, F_{max}}

\code{multi3}: KOD method according to Sisti et al. (2010). Similar to \code{multi2}, but uses maximum fluorescence, slope at first derivative maximum and y-value at first derivative maximum as fixpoints:
\deqn{\frac{\partial F(x;a,b,...)}{\partial x}, F\left(\frac{\partial^2 F(x;a,b,...)}{\partial x^2} = 0\right), F_{max}}

All essential parameters for the methods can be tweaked by \code{\link{parKOD}}. See there and in 'Examples'.
}

\value{
An object of the same class as in \code{object} that is 'tagged' in its name (**name**) if it is an outlier and also with an item \code{$isOutlier} with outlier information (see \code{\link{is.outlier}}). If \code{remove = TRUE}, the outlier runs are removed (and the fitting updated in case of a 'replist').  
}

\author{
Andrej-Nikolai Spiess
}

\seealso{
Function \code{\link{is.outlier}} to get an outlier summary.
}

\references{
Kinetic Outlier Detection (KOD) in real-time PCR.\cr
Bar T, Stahlberg A, Muszta A & Kubista M.\cr
\emph{Nucl Acid Res} (2003), \bold{31}: e105. 

Quality control for quantitative PCR based on amplification compatibility test.\cr
Tichopad A, Bar T, Pecen L, Kitchen RR, Kubista M &, Pfaffl MW.\cr
\emph{Methods} (2010), \bold{50}: 308-312.

Shape based kinetic outlier detection in real-time PCR.\cr
Sisti D, Guescini M, Rocchi MBL, Tibollo P, D'Atri M & Stocchi V.\cr
\emph{BMC Bioinformatics} (2010), \bold{11}: 186.
}

\examples{
## kinetic outliers:
## on a 'modlist', using efficiency from sigmoidal fit
## and alpha = 0.01. 
## F7.3 detected as outlier (shallower => low efficiency)
ml1 <- modlist(reps, 1, c(2:5, 28), model = l5)
res1 <- KOD(ml1, method = "uni1", par = parKOD(eff = "sliwin", alpha = 0.01))
plot(res1)

## Sigmoidal outliers:
## remove runs without sigmoidal structure.
ml2 <- modlist(testdat, model = l5)
res2 <- KOD(ml2, method = "uni2", remove = TRUE)
plot(res2, which = "single")

\dontrun{
## Multivariate outliers:
## a few runs are identified.
ml3 <- modlist(reps, model = l5)
res3 <- KOD(ml3, method = "multi1")

## On a 'replist', several outliers identified.
rl3 <- replist(ml3, group = gl(7, 4))
res4 <- KOD(rl3, method = "uni1")
}
}

\keyword{models}
\keyword{nonlinear}
