\name{RSS}
\alias{RSS}

\title{Residual sum-of-squares of a fitted model}

\description{
Calculates the residual sum-of-squares for objects of class \code{nls}, \code{lm}, \code{glm}, \code{drc} or any other models from which \code{\link{residuals}} can be extacted. From version 1.3-6, this function uses weights, if \code{object} has an item \code{$weights}.
}

\usage{
RSS(object)
}

\arguments{
  \item{object}{a fitted model.}  
}

\details{
\deqn{RSS = \sum_{i=1}^{n}w_i \cdot (y_i-\hat{y}_i)^2}
}

\value{
The (weighted) residual sum-of-squares from the fit.
}

\author{
Andrej-Nikolai Spiess
}


\examples{
m1 <- pcrfit(reps, 1, 2, l5)
RSS(m1)
}

\keyword{models}
\keyword{nonlinear}
