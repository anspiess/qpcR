\name{takeoff}
\alias{takeoff}

\title{Calculation of the qPCR takeoff point}

\description{
Calculates the first significant cycle of the exponential region (takeoff point) using externally studentized residuals as described in Tichopad \emph{et al.} (2003).
}

\usage{
takeoff(object, pval = 0.05, nsig = 3)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{pval}{the p-value for the takeoff test.}
  \item{nsig}{the number of successive takeoff tests. See 'Details'.}      
}

\details{
Takeoff points are calculated essentially as described in the reference below.
The steps are:

1) Fitting a linear model to background cycles \eqn{1:n}, starting with \eqn{n = 5}.\cr
2) Calculation of the external studentized residuals using \code{\link{rstudent}}, which uses the hat matrix of the linear model and leave-one-out:
\deqn{\langle \hat{\varepsilon}_i \rangle = \frac{\hat{\varepsilon}_i}{\hat{\sigma}_{(i)} \sqrt{1-h_{ii}}}, \hat{\sigma}_{(i)} = \sqrt{\frac{1}{n - p - 1} \sum_{j = 1 \atop j \ne i }^n \hat{\varepsilon}_j^2}}
with \eqn{h_{ii}} being the \eqn{i}th diagonal entry in the hat matrix \eqn{H = X(X^TX)^{-1}X^T}.\cr
3) Test if the last studentized residual \eqn{\langle \hat{\varepsilon}_n \rangle} is an outlier in terms of t-distribution:
\deqn{1 - pt(\langle \hat{\varepsilon}_n \rangle, n - p) < 0.05} with \eqn{n} = number of residuals and \eqn{p} = number of parameters.\cr
4) Test if the next \code{nsig} - 1 cycles are also outlier cycles.\cr
5) If so, take cycle number from 3), otherwise \eqn{n = n + 1}  and start at 1).\cr
}

\value{
A list with the following components:
  \item{top}{the takeoff point.}
  \item{f.top}{the fluorescence at \code{top}.}    
}

\author{
Andrej-Nikolai Spiess
}

\references{
Standardized determination of real-time PCR efficiency from a single reaction set-up.\cr
Tichopad A, Dilger M, Schwarz G & Pfaffl MW.\cr
\emph{Nucleic Acids Research} (2003), \bold{e122}.\cr       
}

\examples{
m1 <- pcrfit(reps, 1, 2, l5)
res1 <- takeoff(m1) 
plot(m1)
abline(v = res1$top, col = 2)
abline(h = res1$f.top, col = 2)  
}

\keyword{models}
\keyword{nonlinear}
