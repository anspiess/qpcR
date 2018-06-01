\name{fitchisq}
\alias{fitchisq}      

\title{The chi-square goodness-of-fit}

\description{
Calculates \eqn{\chi^2}, reduced \eqn{\chi_{\nu}^2} and the \eqn{\chi^2} fit probability for objects of class \code{pcrfit}, \code{lm}, \code{glm}, \code{nls} or any other object with a \code{call} component that includes \code{formula} and \code{data}.
The function checks for replicated data (i.e. multiple same predictor values). If replicates are not given, the function needs error values, otherwise \code{NA}'s are returned. 
}

\usage{
fitchisq(object, error = NULL)
}

\arguments{
\item{object}{a single model of class 'pcrfit', a 'replist' or any fitted model of the above.}
\item{error}{in case of a model without replicates, a single error for all response values or a vector of errors for each response value.}
}

\details{
The variance of a fit \eqn{s^2} is also characterized by the statistic \eqn{\chi^2} defined as followed:
\deqn{\chi^2 \equiv \sum_{i=1}^n \frac{(y_i - f(x_i))^2}{\sigma_i^2}}
The relationship between \eqn{s^2} and \eqn{\chi^2} can be seen most easily by comparison with the reduced \eqn{\chi^2}:
\deqn{\chi_\nu^2 = \frac{\chi^2}{\nu} = \frac{s^2}{\langle \sigma_i^2 \rangle}}
whereas \eqn{\nu} = degrees of freedom (N - p), and \eqn{\langle \sigma_i^2 \rangle} is the weighted average of the individual variances. If the fitting function is a good approximation to the parent function, the value of the reduced chi-square should be approximately unity, \eqn{\chi_\nu^2 = 1}. If the fitting function is not appropriate for describing the data, the deviations will be larger and the estimated variance will be too large, yielding a value greater than 1. A value less than 1 can be a consequence of the fact that there exists an uncertainty in the determination of \eqn{s^2}, and the observed values of \eqn{\chi_\nu^2} will fluctuate from experiment to experiment. To assign significance to the \eqn{\chi^2} value, we can use the integral probability 
\deqn{P_\chi(\chi^2;\nu) = \int_{\chi^2}^\infty P_\chi(x^2, \nu)dx^2}
which describes the probability that a random set of \emph{n} data points sampled from the parent distribution would yield a value of \eqn{\chi^2} equal to or greater than the calculated one. This is calculated by \eqn{1 - pchisq(\chi^2, \nu)}.
}          

\value{
A list with the following items:
\item{chi2}{the \eqn{\chi^2} value.}
\item{chi2.red}{the reduced \eqn{\chi_\nu^2}.}
\item{p.value}{the fit probability as described above.}
}

\author{
Andrej-Nikolai Spiess
}

\references{
Data Reduction and Error Analysis for the Physical Sciences.\cr
Bevington PR & Robinson DK.\cr
McGraw-Hill, New York (2003).\cr   

Applied Regression Analysis.\cr
Draper NR & Smith H.\cr
Wiley, New York, 1998.\cr    
}             

\examples{
## Using replicates by making a 'replist'.
ml1 <- modlist(reps, fluo = 2:5)
rl1 <- replist(ml1, group = c(1, 1, 1, 1))
fitchisq(rl1[[1]])

## Using single model with added error.
m1 <- pcrfit(reps, 1, 2, l5)
fitchisq(m1, 0.1)
}

\keyword{models}
\keyword{nonlinear}
