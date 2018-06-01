\name{resVar}
\alias{resVar}

\title{Residual variance of a fitted model}

\description{
Calculates the residual variance for objects of class \code{nls}, \code{lm}, \code{glm}, \code{drc} or any other models from which \code{\link{coef}} and \code{\link{residuals}} can be extracted.
}

\usage{
resVar(object)
}

\arguments{
  \item{object}{a fitted model.}
 }

\value{
The residual variance of the fit.
}

\details{
\deqn{resVar = \frac{\sum_{i=1}^n(y_i - \hat{y}_i)^2}{n - p}}
where \eqn{n} is the number of response values and \eqn{p} the number of parameters in the model.
}

\author{
Andrej-Nikolai Spiess
}


\examples{
m1 <- pcrfit(reps, 1, 2, l5)
resVar(m1)
}

\keyword{models}
\keyword{nonlinear}
