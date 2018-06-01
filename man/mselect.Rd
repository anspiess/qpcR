\name{mselect}
\alias{mselect}

\encoding{latin1}

\title{Sigmoidal model selection by different criteria}

\description{
Model selection by comparison of different models using\cr

  1) the maximum log likelihood value,\cr
  2) Akaike's Information Criterion (AIC),\cr
  3) bias-corrected Akaike's Information Criterion (AICc),\cr
  4) the estimated residual variance,\cr
  5) the p-value from a nested F-test on the residual variance,\cr
  6) the p-value from the likelihood ratio,\cr
  7) the Akaike weights based on AIC,\cr
  8) the Akaike weights based on AICc, and\cr
  9) the reduced chi-square, \eqn{\chi_\nu^2}, if replicates exist.

The best model is chosen by 5), 6), 8) or 9) and returned as a new model.
}

\usage{
mselect(object, fctList = NULL, sig.level = 0.05, verbose = TRUE, 
        crit = c("ftest", "ratio", "weights", "chisq"), do.all = FALSE, ...)
}

\arguments{
\item{object}{an object of class 'pcrfit' or 'replist'.}
\item{fctList}{a list of functions to be analyzed, i.e. for a non-nested regime. Should also contain the original model.}
\item{sig.level}{the significance level for the nested F-test.}
\item{verbose}{logical. If \code{TRUE}, the result matrix is displayed in the console.}
\item{crit}{the criterium for model selection. Either \code{"ftest"/"ratio"} for nested models or \code{"weights"/"fitprob"} for nested and non-nested models.}
\item{do.all}{if \code{TRUE}, all available sigmoidal models are tested and the best one is selected based on AICc weights.}
\item{...}{other parameters to be passed to \code{\link{fitchisq}}.} 
}

\details{
Criteria 5) and 6) cannot be used for comparison unless the models are nested. Criterion 8), Akaike weights, can be used for nested and non-nested regimes, which also accounts for the reduced \eqn{\chi_\nu^2}. For criterion 1) the larger the better. For criteria 2), 3) and 4): the smaller the better. The best model is chosen either from the nested F-test (\code{\link{anova}}), likelihood ratio (\code{\link{llratio}}), corrected Akaike weights (\code{\link{akaike.weights}}) or reduced \eqn{\chi_\nu^2} (\code{\link{fitchisq}}) and returned as a new model. When using \code{"ftest"/"ratio"} the corresponding nested functions are analyzed automatically, i.e. b3/b4/b5/b6/b7; l3/l4/l5/l6/l7. If supplying nested models, please do this with ascending number of parameters.  
}

\value{
A model of the best fit selected by one of the criteria above. The new model has an additional list item 'retMat' with a result matrix of the criterion tests.
}

\author{
Andrej-Nikolai Spiess
}

\seealso{
\code{\link{llratio}}, \code{\link{akaike.weights}} and \code{\link{fitchisq}}.   
}  

\examples{
## Choose best model based on F-tests 
## on the corresponding nested models.
m1 <- pcrfit(reps, 1, 2, l4)
m2 <- mselect(m1)
summary(m2)  ## Converted to l7 model!

## Use Akaike weights on non-nested models
## compare to original model.
m2 <- mselect(m1, fctList = list(l4, b5, cm3), crit = "weights")
summary(m2) ## Converted to b5 model!

## Try all sigmoidal models.
m3 <- pcrfit(reps, 1, 20, l4)
mselect(m3, do.all = TRUE) ## l7 wins by far!

## On replicated data using reduced chi-square.
ml1 <- modlist(reps, fluo = 2:5, model = l4)
rl1 <- replist(ml1, group = c(1, 1, 1, 1))
mselect(rl1, crit = "chisq")  ## converted to l6!
}

\keyword{models}
\keyword{nonlinear}
