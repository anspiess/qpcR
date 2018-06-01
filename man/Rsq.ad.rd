\name{Rsq.ad}
\alias{Rsq.ad}

\title{Adjusted R-square value of a fitted model}

\description{
Calculates the adjusted \eqn{R_{adj}^2} value for objects of class \code{nls}, \code{lm}, \code{glm}, \code{drc} or any other models from which \code{\link{fitted}}, \code{\link{residuals}} and \code{\link{coef}} can be extracted.
}

\usage{
Rsq.ad(object)
}

\arguments{
  \item{object}{a fitted model.}
 }

\value{
The adjusted \eqn{R_{adj}^2} value of the fit.
}

\details{
\deqn{R_{adj}^2 = 1 - \frac{n - 1}{n - p} \cdot (1 - R^2)}
 with \eqn{n} = sample size, \eqn{p} = number of parameters.
}

\author{
Andrej-Nikolai Spiess
}


\examples{
## Single model.
m1 <- pcrfit(reps, 1, 2, l7)
Rsq.ad(m1)

## Compare different models with increasing
## number of parameters.
ml1 <- lapply(list(l4, l5, l6), function(x) pcrfit(reps, 1, 2, x))
sapply(ml1, function(x) Rsq.ad(x)) 
}

\keyword{models}
\keyword{nonlinear}
