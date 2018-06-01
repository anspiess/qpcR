\name{RMSE}
\alias{RMSE}

\title{Root-mean-squared-error of a fitted model}

\description{
Calculates the root-mean-squared-error (RMSE) for objects of class \code{nls}, \code{lm}, \code{glm}, \code{drc} or any other models from which \code{\link{residuals}} can be extacted. 
}

\usage{
RMSE(object, which = NULL)
}

\arguments{
  \item{object}{a fitted model.}
  \item{which}{a subset of the curve to be used for RMSE calculation. If not defined, the complete curve is used.}
}
 
\details{
\deqn{RMSE = \sqrt{\overline{(y_i-\hat{y}_i)^2}}}
}

\value{
The root-mean-squared-error from the fit or a part thereof.
}

\author{
Andrej-Nikolai Spiess
}


\examples{
## For a curve subset.
m1 <- pcrfit(reps, 1, 2, l5)
RMSE(m1, 10:15)
}

\keyword{models}
\keyword{nonlinear}
