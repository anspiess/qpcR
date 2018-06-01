\name{calib}
\alias{calib}

\title{Calculation of qPCR efficiency using dilution curves and replicate bootstrapping}

\description{
This function calculates the PCR efficiency from a classical qPCR dilution experiment. The threshold cycles are plotted against the logarithmized concentration (or dilution) values, a linear regression line is fit and the efficiency calculated by \eqn{E = 10^{\frac{-1}{slope}}}. A graph is displayed with the raw values plotted with the threshold cycle and the linear regression curve. The threshold cycles are calculated either by some arbitrary fluorescence value (i.e. as given by the qPCR software) or calculated from the second derivative maximum of the dilution curves. If values to be predicted are given, they are calculated from the curve and also displayed within. \code{calib2} uses a bootstrap approach if replicates for the dilutions are supplied. See 'Details'.
} 

\usage{
calib(refcurve, predcurve = NULL, thresh = "cpD2", dil = NULL, 
       group = NULL, plot = TRUE, conf = 0.95, B = 200)
}

\arguments{
 \item{refcurve}{a 'modlist' containing the curves for calibration.}
 \item{predcurve}{an (optional) 'modlist' containing the curves for prediction.}
 \item{thresh}{the fluorescence value from which the threshold cycles are defined. Either "cpD2" or a numeric value.} 
 \item{dil}{a vector with the concentration (or dilution) values corresponding to the calibration curves.}
 \item{group}{a factor defining the group membership for the replicates. See 'Examples'.}
 \item{plot}{logical. Should the fitting (bootstrapping) be displayed? If \code{FALSE}, only values are returned.}
 \item{conf}{the confidence interval. Defaults to 95\%, can be omitted with \code{NULL}.}
 \item{B}{the number of bootstraps.}    
}

\details{
\code{calib2} calculates confidence intervals for efficiency, AICc, adjusted \eqn{R^2_{adj}} and the prediction curve concentrations. If single replicates per dilution are supplied by the user, confidence intervals for the prediction curves are calculated based on asymptotic normality. If multiple replicates are supplied, the regression curves are calculated by randomly sampling one of the replicates from each dilution group. The confidence intervals are then calculated from the bootstraped results.
}

\value{
A list with the following components:
 \item{eff}{the efficiency.}
 \item{AICc}{the second-order corrected AIC.}  
 \item{Rsq.ad}{the adjusted \eqn{R^2_{adj}}.}
 \item{predconc}{the (log) concentration of the predicted curves.}    
 \item{conf.boot}{a list containing the confidence intervals for the efficiency, the AICc, Rsq.ad and the predicted concentrations.} 

A plot is also supplied for \code{eff}iciency, \code{AICc}, \code{Rsq.ad} and predicted concentrations including confidence intervals in red.
}

\author{
Andrej-Nikolai Spiess
}       

\examples{
## Define calibration curves,
## dilutions (or copy numbers) 
## and curves to be predicted.
## Do background subtraction using
## average of first 8 cycles. No replicates.
CAL <- modlist(reps, fluo = c(2, 6, 10, 14, 18, 22), 
               baseline = "mean", basecyc = 1:8)
COPIES <- c(100000, 10000, 1000, 100, 10, 1)
PRED <- modlist(reps, fluo = c(3, 7, 11), 
                baseline = "mean", basecyc = 1:8)

## Conduct normal quantification using
## the second derivative maximum of first curve.
calib(refcurve = CAL, predcurve = PRED, thresh = "cpD2", 
       dil = COPIES, plot = FALSE) 

## Using a defined treshold value.
#calib(refcurve = CAL, predcurve = PRED, thresh = 0.5, dil = COPIES) 

## Using six dilutions with four replicates/dilution.
\dontrun{
#CAL2 <- modlist(reps, fluo = 2:25)
#calib(refcurve = CAL2, predcurve = PRED, thresh = "cpD2", 
#      dil = COPIES, group = gl(6,4)) 
} 
}

\keyword{models}
\keyword{nonlinear}
