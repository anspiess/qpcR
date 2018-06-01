\name{llratio}
\alias{llratio}

\encoding{latin1}

\title{Calculation of likelihood ratios for nested models}

\description{
Calculates the likelihood ratio and p-value from a chi-square distribution for two nested models. 
}

\usage{
llratio(objX, objY)
}

\arguments{
 \item{objX}{Either a value of class \code{logLik} or a model for which \code{\link{logLik}} can be applied.}
 \item{objY}{Either a value of class \code{logLik} or a model for which \code{\link{logLik}} can be applied.}
}

\details{
The likelihood ratio statistic is \deqn{LR = \frac{f(X, \hat{\phi}, \hat{\psi})}{f(X, \phi, \hat{\psi_0})}}
The usual test statistic is \deqn{\Lambda = 2 \cdot (l(\hat{\phi}, \hat{\psi}) - l(\phi, \hat{\psi_0}))}
Following the large sample theory, if \eqn{H_0} is true, then \deqn{\Lambda \sim \chi_p^2}  

}

\value{
A list containing the following items:
\item{ratio}{the likelihood ratio statistic.}
\item{df}{the change in parameters.}
\item{p.value}{the p-value from a \eqn{\chi^2} distribution. See Details.}
}

\author{
Andrej-Nikolai Spiess
}


\seealso{
\code{\link{AIC}}, \code{\link{logLik}}.
}

\examples{
## Compare l5 and l4 model.
m1 <- pcrfit(reps, 1, 2, l5)
m2 <- pcrfit(reps, 1, 2, l4)
llratio(m1, m2)
}

\keyword{models}
\keyword{nonlinear}
