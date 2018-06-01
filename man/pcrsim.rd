\name{pcrsim}
\alias{pcrsim}

\title{Simulation of sigmoidal qPCR data with goodness-of-fit analysis}

\description{Simulated sigmoidal qPCR curves are generated from an initial model to which some user-defined homoscedastic or heteroscedastic noise is added. One or more models can then be fit to this random data and goodness-of-fit (GOF) measures are calculated for each of the models. This is essentially a Monte-Carlo approach testing for the best model in dependence to some noise structure in sigmodal models.
}

\usage{
pcrsim(object, nsim = 100, error = 0.02, 
       errfun = function(y) 1, plot = TRUE,
       fitmodel = NULL, select = FALSE, 
       statfun = function(y) mean(y, na.rm = TRUE),
       PRESS = FALSE, ...)
}

\arguments{
  \item{object}{an object of class 'pcrfit.} 
  \item{nsim}{the number of simulated curves.}
  \item{error}{the gaussian error used for the simulation. See 'Details'.}
  \item{errfun}{an optional function for the error distribution. See 'Details'.}
  \item{plot}{should the simulated and fitted curves be displayed?}
  \item{fitmodel}{a model or model list to test against the initial model.} 
  \item{select}{if \code{TRUE}, a matrix is returned with the best model in respect to each of the GOF measures.}  
  \item{statfun}{a function to be finally applied to all collected GOF measures, default is the average.} 
  \item{PRESS}{logical. If set to \code{TRUE}, the computationally expensive \code{\link{PRESS}} statistic will be calculated.}
  \item{...}{other parameters to be passed on to \code{\link{plot}} or \code{\link{pcrfit}}.}
}

\details{
The value defined under \code{error} is just the standard deviation added plainly to each y value from the initial model, thus generating a dataset with homoscedastic error. With aid of \code{errfun}, the distribution of the error along the y values can be altered and be used to generate heteroscedastic error along the curve, i.e. as a function of the magnitude.
 
Example:\cr
\code{errfun = function(y) 1}\cr
same variance for all y, as is.\cr

\code{errfun = function(y) y}\cr
variance as a function of the y-magnitude.\cr

\code{errfun = function(y) 1/y}\cr
variance as an inverse function of the y-magnitude.

For the effect, see 'Examples'.
}

\value{
A list containing the following items:
  \item{cyc}{same as in 'arguments'.}
  \item{fluoMat}{a matrix with the simulated qPCR data in columns.}
  \item{coefList}{a list with the coefficients from the fits for each model, as subitems.}
  \item{gofList}{a list with the GOF measures for each model, as subitems.} 
  \item{statList}{a list with the GOF measures summarized by \code{statfun} for each model, as subitems.} 
  \item{modelMat}{if \code{select = TRUE}, a matrix with the best model for each GOF measure and each simulation.}   
}

\author{
Andrej-Nikolai Spiess
}  

\examples{
## Generate initial model.
m1 <- pcrfit(reps, 1, 2, l4)

## Simulate homoscedastic error
## and test l4 and l5 on data.
res1 <- pcrsim(m1, error = 0.2, nsim = 20, 
               fitmodel = list(l4, l5))

\dontrun{
## Use heteroscedastic noise typical for 
## qPCR: more noise at lower fluorescence.
res2 <- pcrsim(m1, error = 0.01, errfun = function(y) 1/y,
              nsim = 20, fitmodel = list(l4, l5, l6))

## Get 95\% confidence interval for 
## the models GOF in question (l4, l5, l6).
res3 <- pcrsim(m1, error = 0.2, nsim = 20, fitmodel = list(l4, l5, l6),
              statfun = function(y) quantile(y, c(0.025, 0.975)))
res3$statList  

## Count the selection of the 'true' model (l4)
## for each of the GOF measures,
## use PRESS statistic => SLOW!
## BIC wins!!
res4 <- pcrsim(m1, error = 0.05, nsim = 10, fitmodel = list(l4, l5, l6),
               select = TRUE, PRESS = TRUE)
apply(res4$modelMat, 2, function(x) sum(x == 1))
} 
}  

\keyword{models}
\keyword{nonlinear}
