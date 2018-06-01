\name{pcrGOF}
\alias{pcrGOF}

\title{Summarize measures for the goodness-of-fit}

\description{
Calculates all implemented measures for the goodness-of-fit and returns them as a list.
Works for objects of class \code{pcrfit}, \code{lm}, \code{glm}, \code{nls}, \code{drc} and many others...
}

\usage{
pcrGOF(object, PRESS = FALSE)
}

\arguments{
\item{object}{a fitted object.}
\item{PRESS}{logical. If \code{TRUE}, the more calculation intensive \eqn{P^2} is also returned.}
}

\value{
A list with all implemented Information criteria (\code{AIC, AICc, BIC}), residual variance, root-mean-squared-error, the reduced \eqn{\chi_{\nu}^2} from \code{\link{fitchisq}} (if replicates) and the \code{\link{PRESS}} \eqn{P^2} value (if \code{PRESS = TRUE}).  
}

\author{
Andrej-Nikolai Spiess
}


\examples{
## Single fit without replicates
## including PRESS statistic.
m1 <- pcrfit(reps, 1, 2, l5)
pcrGOF(m1, PRESS = TRUE)

## Fit containing replicates:
## calculation of reduced 
## chi-square included!
m2 <- pcrfit(reps, 1, 2:5, l5)
pcrGOF(m2)
}

\keyword{models}
\keyword{nonlinear}
