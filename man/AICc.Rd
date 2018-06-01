\name{AICc}
\alias{AICc}

\title{Akaike's second-order corrected Information Criterion}

\description{
Calculates the second-order corrected Akaike Information Criterion for objects of class \code{pcrfit}, \code{nls}, \code{lm}, \code{glm} or any other models from which \code{\link{coefficients}} and \code{\link{residuals}} can be extracted. This is a modified version of the original AIC which compensates for bias with small \eqn{n}. As qPCR data usually has \eqn{\frac{n}{k} < 40} (see original reference), AICc was implemented to correct for this.
}

\usage{
AICc(object)
}

\arguments{
\item{object}{a fitted model.}
}

\details{
Extends the AIC such that \deqn{AICc = AIC+\frac{2k(k + 1)}{n - k - 1}} with \eqn{k} = number of parameters, and \eqn{n} = number of observations. For large \eqn{n}, AICc converges to AIC.
}

\value{
The second-order corrected AIC value.
}

\author{
Andrej-Nikolai Spiess
}

\references{
Akaike Information Criterion Statistics.\cr
Sakamoto Y, Ishiguro M and Kitagawa G.\cr 
D. Reidel Publishing Company (1986).\cr

Regression and Time Series Model Selection in Small Samples.\cr
Hurvich CM & Tsai CL.\cr  
\emph{Biometrika} (1989), \bold{76}: 297-307.\cr
}

\seealso{
\code{\link{AIC}}, \code{\link{logLik}}.
}

\examples{
m1 <- pcrfit(reps, 1, 2, l5)
AICc(m1)
}

\keyword{models}
\keyword{nonlinear}
