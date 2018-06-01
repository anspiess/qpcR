\name{modlist}
\alias{modlist}

\title{Create nonlinear models from a dataframe and coerce them into a list}

\description{
Essential function to create a list of nonlinear models from the columns (runs) of a qPCR dataframe. This function houses different methods for curve transformation prior to fitting, such as normalization in [0, 1], smoothing, baseline subtraction etc. Runs that failed to fit or that have been identified as kinetic outliers (by default: lack of sigmoidal structure) can be removed automatically as well as their entries in an optionally supplied label vector. 
}

\usage{
modlist(x, cyc = 1, fluo = NULL, model = l4, check = "uni2", 
        checkPAR = parKOD(), remove = c("none", "fit", "KOD"), 
        exclude = NULL, labels = NULL, norm = FALSE, 
        baseline = c("none", "mean", "median", "lin", "quad", "parm"),
        basecyc = 1:8, basefac = 1, smooth = NULL, smoothPAR = NULL, 
        factor = 1, opt = FALSE, 
        optPAR = list(sig.level = 0.05, crit = "ftest"), verbose = TRUE, ...)
}

\arguments{
  \item{x}{a dataframe containing the qPCR data or a single qPCR run of class 'pcrfit'.}
  \item{cyc}{the column containing the cycle data. Defaults to first column.}
  \item{fluo}{the column(s) (runs) to be analyzed. If \code{NULL}, all runs will be considered.}
  \item{model}{the model to be used for all runs.} 
  \item{check}{the method for kinetic outlier detection. Default is check for sigmoidal structure, see \code{\link{KOD}}. To turn off, use \code{NULL}.}
  \item{checkPAR}{parameters to be supplied to the \code{check} method, see \code{\link{KOD}}.}
  \item{remove}{which runs to remove. Either \code{"none"}, those which failed to \code{"fit"} or from the \code{"KOD"} outlier method.}
  \item{exclude}{either \code{""} for samples with missing column names or a regular expression defining columns (samples) to be excluded from \code{modlist}. See 'Details'.} 
  \item{labels}{a vector containing labels, i.e. for defining replicate groups prior to \code{\link{ratiobatch}}.}
  \item{norm}{logical. Should the raw data be normalized within [0, 1] before model fitting?}
  \item{baseline}{type of baseline subtraction. See 'Details'.}
  \item{basecyc}{cycle range to be used for baseline subtraction, i.e. \code{1:5}.}
  \item{basefac}{a factor for the baseline value, such as \code{0.95}.}
  \item{smooth}{which curve smoothing method to use. See 'Details'.}
  \item{smoothPAR}{parameters to be supplied to the smoothing functions, supplied as a list. See 'Details'.}
  \item{factor}{a multiplication factor for the fluorescence response values (barely useful, but who knows...).}
  \item{opt}{logical. Should model selection be applied to each model?}
  \item{optPAR}{parameters to be supplied to \code{\link{mselect}}.}
  \item{verbose}{logical. If \code{TRUE}, fitting and tagging results will be displayed in the console.}
  \item{...}{other parameters to be passed to \code{\link{pcrfit}}.}
}

\value{
A list with each item containing the model from each column. A \code{names} item (which is tagged by *NAME*, if fitting failed) containing the column name is attached to each model as well as an item \code{isFitted} with either \code{TRUE} (fitting converged) or \code{FALSE} (a fitting error occured). This information is useful when \code{\link{ratiocalc}} is to be applied and unsuccessful fits should automatically removed from the given \code{group} definition. If kinetic outlier detection is selected, an item \code{isOutlier} is attached, defining the run as an outlier (\code{TRUE}) or not (\code{FALSE}). 
}

\details{
From version 1.4-0, the following baselining methods are available for the fluorescence values:\cr
\code{baseline = numeric}: a numeric value such as \code{baseline = 0.2} for subtracting from each \eqn{F_i}.\cr
\code{"mean"}: subtracts the mean of all \code{basecyc} cycles from each \eqn{F_i}.\cr
\code{"median"}: subtracts the median of all \code{basecyc} cycles from each \eqn{F_i}.\cr
\code{"lin"}: creates a linear model of all \code{basecyc} cycles, predicts \eqn{P_i} over all cycles \eqn{i} from this model, and subtracts \eqn{F_i - P_i}.\cr
\code{"quad"}: creates a quadratic model of all \code{basecyc} cycles, predicts \eqn{P_i} over all cycles \eqn{i} from this model, and subtracts \eqn{F_i - P_i}.\cr
\code{"parm"}: extracts the \eqn{c} parameter from the fitted sigmoidal model and subtracts this value from all \eqn{F_i}.\cr
It is switched off by default, but in case of data with a high baseline (such as in TaqMan PCR), it should be turned on as otherwise this will give highly underestimated efficiencies and hence wrong \code{init2} values.\cr

From version 1.3-8, the following smoothing methods are available for the fluorescence values:\cr
\code{"lowess"}: Lowess smoothing, see \code{\link{lowess}}, parameter in \code{smoothPAR}: f.\cr
\code{"supsmu"}: Friedman's SuperSmoother, see \code{\link{supsmu}}, parameter in \code{smoothPAR}: span.\cr
\code{"spline"}: Smoothing spline, see \code{\link{smooth.spline}}, parameter in \code{smoothPAR}: spar.\cr
\code{"savgol"}: Savitzky-Golay smoother, \code{qpcR:::savgol}, parameter in \code{smoothPAR}: none.\cr
\code{"kalman"}: Kalman smoother, see \code{\link{arima}}, parameter in \code{smoothPAR}: none.\cr
\code{"runmean"}: Running mean, see \code{qpcR:::runmean}, parameter in \code{smoothPAR}: wsize.\cr
\code{"whit"}: Whittaker smoother, see \code{qpcR:::whittaker}, parameter in \code{smoothPAR}: lambda.\cr
\code{"ema"}: Exponential moving average, see \code{qpcR:::EMA}, parameter in \code{smoothPAR}: alpha.\cr
The author of this package advocates the use of \code{"spline"}, \code{"savgol"} or \code{"whit"} because these three smoothers have the least influence on overall curve structure.\cr

In case of unsuccessful model fitting and if \code{remove = "none"} (default), the original data is included in the output, albeit with no fitting information. This is useful since using \code{plot.pcrfit} on the 'modlist' shows the non-fitted runs. If \code{remove = "fit"}, the non-fitted runs are automatically removed and will thus not be displayed. If \code{remove = "KOD"}, by default all runs without sigmoidal structure are removed likewise. If a \code{labels} vector \code{lab} is supplied, the labels from the failed fits are removed and a new label vector \code{lab_mod} is written to the global environment. This way, an initial labeling vector for all samples can be supplied, bad runs and their labels automatically removed and these transfered to downstream analysis (i.e. to \code{\link{ratiobatch}}) without giving errors. \code{exclude} offers an option to exclude samples from the modlist by some regular expression or by using \code{""} for samples with empty column names. See 'Examples'. 
}

\seealso{
\code{\link{pcrbatch}} for batch analysis using different methods.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
## Calculate efficiencies and ct values 
## for each run in the 'reps' data, 
## subtract baseline using mean of 
## first 8 cycles.
ml1 <- modlist(reps, model = l5, baseline = "mean")
getPar(ml1, type = "curve")

## 'Crossing points' for the first 3 runs (normalized)
##  and using best model from Akaike weights.
ml2 <- modlist(reps, 1, 2:5, model = l5, norm = TRUE, 
               opt = TRUE, optPAR = list(crit = "weights"))
sapply(ml2, function(x) efficiency(x, plot = FALSE)$cpD2)

## Convert a single run to a 'modlist'.
m <- pcrfit(reps, 1, 2, l5)
ml3 <- modlist(m)

## Using the 'testdat' set
## include failed fits.
ml4 <- modlist(testdat, 1, 2:9,  model = l5)
plot(ml4, which = "single")

## Remove failed fits and update a label vector.
GROUP <- c("g1s1", "g1s2", "g1s3", "g1s4", "g1c1", "g1c2", "g1c3", "g1c4") 
ml5 <- modlist(testdat, 1, 2:9,  model = l5, labels = GROUP, remove = "KOD")
plot(ml5, which = "single")

## Smoothing by EMA and alpha = 0.8.
ml6 <- modlist(reps, model = l5, smooth = "ema",
               smoothPAR = list(alpha = 0.5))
plot(ml6)

\dontrun{
## Use one of the mechanistic models
## get D0 values.
ml7 <- modlist(reps, model = mak3)
sapply(ml7, function(x) coef(x)[1])

## Exclude first sample in each 
## replicate group of dataset 'reps'.
ml8 <- modlist(reps, exclude = ".1")
plot(ml8, which = "single")

## Using weighted fitting:
## weighted by inverse residuals.
ml9 <- modlist(reps, weights = "1/abs(resid)")
plot(ml9, which = "single")

## Use linear model of the first 10
## cycles for baselining.
ml10 <- modlist(reps, basecyc = 1:10, baseline = "lin")
plot(ml10)

## Use a single value for baselining.
ml11 <- modlist(reps, basecyc = 1:10, baseline = 0.5)
plot(ml11)
}
}

\keyword{models}
\keyword{nonlinear}
