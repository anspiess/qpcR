\name{evidence}
\alias{evidence}

\title{Evidence ratio for model comparisons with AIC, AICc or BIC}

\description{
The evidence ratio \deqn{\frac{1}{exp(-0.5 \cdot (IC2 - IC1))}} is calculated for one of the information criteria \eqn{IC = AIC, AICc, BIC} either from two fitted models or two numerical values. Models can be compared that are not nested and where the f-test on residual-sum-of-squares is not applicable.
}

\usage{
evidence(x, y, type = c("AIC", "AICc", "BIC"))
}

\arguments{
  \item{x}{a fitted object or numerical value.}
  \item{y}{a fitted object or numerical value.}
  \item{type}{any of the three Information Criteria \code{AIC, AICc or BIC}.} 
}

\details{
Small differences in values can mean substantial more 'likelihood' of one model over the other. For example, a model with AIC = -130 is nearly 150 times more likely than a model with AIC = -120.   
}

\value{
A value of the first model \code{x} being more likely than the second model \code{y}. If large, first model is better. If small, second model is better.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
## Compare two four-parameter and five-parameter
## log-logistic models.
m1 <- pcrfit(reps, 1, 2, l4)
m2 <- pcrfit(reps, 1, 2, l5)
evidence(m2, m1)

## Ratio of two AIC's.
evidence(-120, -123)
}

\keyword{models}
\keyword{nonlinear}
