\name{pcrfit}
\alias{pcrfit}

\encoding{latin1}

\title{Workhorse function for qPCR model fitting}

\description{
This is the workhorse function of the qpcR package that fits one of the available models to qPCR data using (weighted) nonlinear least-squares (Levenberg-Marquardt) fitting from \code{\link{nlsLM}} of the 'minpack.lm' package.
}

\usage{
pcrfit(data, cyc = 1, fluo, model = l4, start = NULL, 
       offset = 0, weights = NULL, verbose = TRUE, ...)
}

\arguments{
  \item{data}{the name of the dataframe containing the qPCR runs.}
  \item{cyc}{the column containing the cycle data. Defaults to 1.}
  \item{fluo}{the column(s) containing the raw fluorescence data of the run(s). If more than one column is given, the model will be built with the replicates. See 'Details' and 'Examples'.}
  \item{model}{the model to be used for the analysis. Defaults to 'l4'.} 
  \item{start}{a vector of starting values that can be supplied externally.}
  \item{offset}{an offset cycle number from the second derivative cut-off cycle for all \code{MAK} methods. See 'Details' and 'Example'.}
  \item{weights}{a vector with same length as \code{data} containing possible weights for the nonlinear fit, or an expression to calculate weights from. See 'Details'.} 
  \item{verbose}{logical. If \code{TRUE}, fitting and convergence results will be displayed in the console.}
  \item{...}{other parameters to be passed to \code{\link{nlsLM}}.}     
}

\details{
This is a newer (from qpcR 1.3-7 upwards) version of \code{pcrfit}. It is a much simpler implementation containing only the LM-Algorithm for fitting, but this fitting routine has proven to be so robust that other optimization routines (such as in \code{\link{optim}}) could safely be removed. The fitting is done with the new \code{\link{nlsLM}} function of the 'minpack.lm' package, which gives a model of class 'nls' as output.  

This function is to be used at the single run level or on replicates (by giving several columns). The latter will build a single model based on the replicate values. If many models should be built on a cohort of replicates, use \code{\link{modlist}} and \code{\link{replist}}.

The \code{offset} value defines the offset cycles from the second derivative maximum that is used as a cut-off criterion in the \code{MAK} methods. See 'Examples'.

Since version 1.3-7, an expression given as a character string can be supplied to the \code{weights} argument.
This expression, which is transferred to \code{qpcR:::wfct}, defines how the vector of weights is calculated from the data. In principle, five different parameters can be used to define weights:\cr
\code{"x"} relates to the cycles \eqn{x_i},\cr
\code{"y"} relates to the raw fluorescence values \eqn{y_i},\cr
\code{"error"} relates to the error \eqn{\sigma(y_{i, j})} of replicates \eqn{j},\cr
\code{"fitted"} relates to the fitted values \eqn{\hat{y}_i} of the fit,\cr
\code{"resid"} relates to the residuals \eqn{y_i - \hat{y}_i} of the fit.\cr
For \code{"fitted"} and \code{"resid"}, the model is fit unweighted by \code{\link{pcrfit}}, the fitted/residual values extracted and these subsequently used for refitting the model with weights.
These parameters can be used solely or combined to create a weights vector for different regimes. The most commonly used are (see also 'Examples'):\cr
Inverse of response (raw fluorescence) \eqn{\frac{1}{y_i}}: \code{"1/y"}\cr
Square root of predictor (Cycles) \eqn{\sqrt{x_i}}: \code{"sqrt(x)"}\cr
Inverse square of fitted values: \eqn{\frac{1}{\hat{y}^2_i}}: \code{"1/fitted^2"}\cr
Inverse variance \eqn{\frac{1}{\sigma^2(y_{i, j})}}: \code{"1/error^2"}
}

\value{
A model of class 'nls' and 'pcrfit' with the following items attached:\cr
  \item{DATA}{the initial data used for fitting.}
  \item{MODEL}{the model used for fitting.} 
  \item{call2}{the call to \code{pcrfit}.} 
  \item{parMat}{the trace of the parameter values. Can be used to track problems.}
  \item{opt.method}{defaults to \code{"LM"}.}
} 

\author{
Andrej-Nikolai Spiess
}

\references{
Bioassay analysis using R.\cr
Ritz C & Streibig JC.\cr
\emph{J Stat Soft} (2005), \bold{12}: 1-22.\cr

A Method for the Solution of Certain Problems in Least Squares.\cr
K. Levenberg.\cr
\emph{Quart Appl Math} (1944), \bold{2}: 164-168.\cr

An Algorithm for Least-Squares Estimation of Nonlinear Parameters.\cr
D. Marquardt.\cr
\emph{SIAM J Appl Math} (1963), \bold{11}: 431-441.\cr
}

\examples{
## Simple l4 fit of F1.1 of the 'reps' dataset.
m1 <- pcrfit(reps, 1, 2, l4) 
plot(m1)

## Supply own starting values.
pcrfit(reps, 1, 2, l4, start = c(-5, -0.05, 11, 16)) 

## Make a replicate model,
## use inverse variance as weights.
m2 <- pcrfit(reps, 1, 2:5, l5, weights = "1/error^2")
plot(m2)

## Fit a mechanistic 'mak2' model
## to -1 cycle from SDM.
m3 <- pcrfit(reps, 1, 2, mak2, offset = -1)
plot(m3)
}

\keyword{models}
\keyword{nonlinear}
