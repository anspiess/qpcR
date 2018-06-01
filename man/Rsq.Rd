\name{Rsq}
\alias{Rsq}

\title{R-square value of a fitted model}

\description{
Calculates the \eqn{R^2} value for objects of class \code{nls}, \code{lm}, \code{glm}, \code{drc} or any other models from which \code{\link{fitted}} and \code{\link{residuals}} can be extracted. Since version 1.2-9 it calculates a weighted \eqn{R^2} if the object has an item \code{object$weights} containing weighting values.
}

\usage{
Rsq(object)
}

\arguments{
  \item{object}{a fitted model.}
 }

\value{
The \eqn{R^2} value of the fit.
}

\details{
Uses the most general definition of \eqn{R^2}: \deqn{R^2 \equiv 1 - \frac{RSS}{TSS}} where
 \deqn{RSS = \sum_{i=1}^{n}w_i \cdot (y_i-\hat{y}_i)^2} and \deqn{TSS = \sum_{i=1}^{n}w_i \cdot (y_i - \bar{y})^2} using the weighted mean \deqn{\bar{y} = \frac{\sum_{i=1}^{n}w_ix_i}{\sum_{i=1}^{n}w_i}} 
}

\author{
Andrej-Nikolai Spiess
}


\examples{
m1 <- pcrfit(reps, 1, 2, l5)
Rsq(m1)   
}

\keyword{models}
\keyword{nonlinear}
