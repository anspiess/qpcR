\name{PRESS}
\alias{PRESS}

\title{Allen's PRESS (Prediction Sum-Of-Squares) statistic, aka P-square}

\description{
 Calculates the PRESS statistic, a leave-one-out refitting and prediction method, as described in Allen (1971).
 Works for any regression model with a \code{call} slot, an \code{\link{update}} and a \code{\link{predict}} function, hence all models of class \code{lm}, \code{glm}, \code{nls} and \code{drc} (and maybe more...).
 The function also returns the PRESS analog to R-square, the P-square. 
}

\usage{
PRESS(object, verbose = TRUE)
}

\arguments{
  \item{object}{a fitted model.}
  \item{verbose}{logical. If \code{TRUE}, iterations are displayed on the console.} 
}

\details{
From a fitted model, each of the predictors \eqn{x_i, i = 1 \ldots{n}} is removed and the model is refitted to the \eqn{n-1} points.
The predicted value \eqn{\hat{y}_{i, -i}} is calculated at the excluded point \eqn{x_i} and the PRESS statistic is given by:
\deqn{\sum_{i=1}^n (y_i - \hat{y}_{i, -i})^2}
The PRESS statistic is a surrogate measure of crossvalidation of small sample sizes and a measure for internal validity.
Small values indicate that the model is not overly sensitive to any single data point.
The P-square value, the PRESS equivalent to R-square, is given by \deqn{P^2 = \frac{\sum_{i=1}^n \hat{\varepsilon}^2_{-i}}{\sum_{i=1}^n (y_i - \bar{y})^2}}
 with \eqn{\hat\varepsilon_{-i} = y_i - \hat{y}_{-i}}.
}

\value{
A list with the following components:
  \item{stat}{The PRESS statistic.}
  \item{residuals}{a vector containing the PRESS residuals for each \eqn{x_i}.}  
  \item{P.square}{the P-square value. See 'Details'.}  
}

\author{
Andrej-Nikolai Spiess
}

\note{
There is also a \code{PRESS} function in library 'MPV' that works solely for \code{lm} models using the hat matrix.
}

\references{
The relationship between variable selection and data augmentation and a method for prediction.\cr
Allen DM.\cr
\emph{Technometrics} (1974), \bold{16}: 25-127.

The Prediction Sum of Squares as a Criterion for Selecting Predictor Variables.\cr
Allen DM.\cr
Technical Report Number 23 (1971), Department of Statistics, University of Kentucky.

Classical and Modern Regression with Applications.\cr
Myers RH.\cr
Second Edition (1990), Duxbury Press (PWS-KENT Publishing Company), 299-304.
}

\examples{
## Example for PCR analysis.
m1 <- pcrfit(reps, 1, 2, l7)
PRESS(m1)

## Compare PRESS statistic in models
## with fewer parameters.
m2 <- pcrfit(reps, 1, 2, l5)
PRESS(m2)
m3 <- pcrfit(reps, 1, 2, l4)
PRESS(m3)

## Example for linear regression.
x <- 1:10
y <- rnorm(10, x, 0.1)
mod <- lm(y ~ x)
PRESS(mod)

## Example for NLS fitting.     
DNase1 <- subset(DNase, Run == 1)
fm1DNase1 <- nls(density ~ SSlogis(log(conc), Asym, xmid, scal), DNase1)
res <- PRESS(fm1DNase1)

## PRESS residuals plot.
barplot(res$residuals)
}

\keyword{models}
\keyword{nonlinear}
