\name{predict.pcrfit}
\alias{predict.pcrfit}


\title{Value prediction from a fitted qPCR model}

\description{
After fitting the appropriate model, either the raw fluorescence values can be predicted from the cycle number or \emph{vice versa}. 
}

\usage{
\method{predict}{pcrfit}(object, newdata, which = c("y", "x"), 
        interval = c("none", "confidence", "prediction"),
        level = 0.95, ...) 
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}  
  \item{newdata}{a dataframe containing the values to estimate from, using the same variable naming as in the fitted model.}
  \item{which}{either \code{"y"} (default) for prediction of the raw fluorescence or \code{"x"} for prediction of the cycle number.}
  \item{interval}{if not \code{"none"}, confidence or prediction intervals are calculated.}      
  \item{level}{the confidence level.}	
  \item{...}{some methods for this generic require additional arguments. None are used in this method.}
 }

\details{
y-values (Fluorescence) are estimated from \code{object$MODEL$expr}, x-values (Cycles) are estimated from \code{object$MODEL$inv}. Confidence intervals are calculated from the gradient of the function and the variance-covariance matrix of \code{object} by \eqn{\nabla f(x) \cdot cov(y) \cdot \nabla f(x)} and are based on asymptotic normality (t-distribution).
}

\value{
A dataframe containing the estimated values and (if chosen) standard error/upper confidence limit/lower confidence limit. 
The gradient is attached to the dataframe and can be accessed with \code{attr}. 
}

\note{
The estimation of x (cycles) from fluorescence data if \code{which = "x"} is problematic in the asymptotic regions of the sigmoidal curves
 (often gives NaN, due to logarithmation of negative values) and works fairly well in the ascending part.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
m1 <- pcrfit(reps, 1, 2, l5)

## Which raw fluorescence value at cycle number = 17?
predict(m1, newdata = data.frame(Cycles = 17))

## Cycle numbers 20:25, with 95\% confidence?
predict(m1, newdata = data.frame(Cycles = 20:25), interval = "confidence")

## Which cycle at Fluo = 4, with 95\% prediction?
predict(m1, newdata = data.frame(Fluo = 4), which = "x", interval = "prediction")
}

\keyword{models}
\keyword{nonlinear}
