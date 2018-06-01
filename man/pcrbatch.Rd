\name{pcrbatch}
\alias{pcrbatch}

\encoding{latin1}

\title{Batch calculation of qPCR efficiency and other qPCR parameters}

\description{
This function batch calculates the results obtained from \code{\link{efficiency}}, \code{\link{sliwin}}, \code{\link{expfit}}, \code{\link{LRE}} or the coefficients from any of the \code{makX/cm3} models on a dataframe containing many qPCR runs. The input can also be a list obtained from \code{\link{modlist}}, which simplifies things in many cases. The output is a dataframe with the estimated parameters and model descriptions. Very easy to use on datasheets containing many qPCR runs, i.e. as can be imported from Excel. The result is automatically copied to the clipboard.
}

\usage{
pcrbatch(x, cyc = 1, fluo = NULL, 
         methods = c("sigfit", "sliwin", "expfit", "LRE"),
         model = l4, check = "uni2", checkPAR = parKOD(), 
         remove = c("none", "fit", "KOD"), exclude = NULL, 
         type = "cpD2", labels = NULL, norm = FALSE, 
         baseline = c("none", "mean", "median", "lin", "quad", "parm"),
         basecyc = 1:8, basefac = 1, smooth = NULL, smoothPAR = NULL, 
         factor = 1, opt = FALSE, optPAR = list(sig.level = 0.05, crit = "ftest"), 
         group = NULL, names = c("group", "first"), plot = TRUE, 
         verbose = TRUE, ...)
}

\arguments{
  \item{x}{a dataframe containing the qPCR raw data from the different runs or a list obtained from \code{\link{modlist}}.}
  \item{cyc}{the column containing the cycle data. Defaults to first column.}
  \item{fluo}{the column(s) (runs) to be analyzed. If \code{NULL}, all runs will be considered.}
  \item{methods}{a character vector defining the methods to use. See 'Details'.}
  \item{model}{the model to be used for all runs.} 
  \item{check}{the method for outlier detection in \code{\link{KOD}}. Default is check for sigmoidal structure.}
  \item{checkPAR}{parameters to be supplied to the \code{check} method.}
  \item{remove}{which runs to remove. Either \code{none}, those which failed to \code{fit} or from the outlier methods.}
  \item{exclude}{either \code{""} for samples with missing column names or a regular expression defining columns (samples) to be excluded from \code{pcrbatch}. See 'Details' and 'Examples' in \code{\link{modlist}}.}
  \item{type}{the point on the amplification curve from which the efficiency is estimated. See \code{\link{efficiency}}.}  
  \item{labels}{a vector containing labels, i.e. for defining replicate groups prior to \code{\link{ratiobatch}}.}  
  \item{norm}{logical. Should the raw data be normalized within [0, 1] before model fitting?}
  \item{baseline}{type of baseline subtraction. See 'Details' in \code{\link{modlist}}.}
  \item{basecyc}{cycle range to be used for baseline subtraction, i.e. \code{1:5}.}
  \item{basefac}{a factor when using averaged baseline cycles, such as \code{0.95}.}
  \item{smooth}{which curve smoothing method to use. See \code{\link{modlist}}.}
  \item{smoothPAR}{parameters to be supplied to the smoothing functions, supplied as a list. See \code{\link{modlist}}.}
  \item{factor}{a multiplication factor for the fluorescence response values (barely useful, but who knows...).}
  \item{opt}{logical. Should model selection be applied to each model?}
  \item{optPAR}{parameters to be supplied to \code{\link{mselect}}.}
  \item{group}{a vector containing the grouping for possible replicates.}
  \item{names}{how to name the grouped fit. Either 'group_1, ...' or the first name of the replicates.}   
  \item{plot}{logical. If \code{TRUE}, the single runs are plotted from the internal 'modlist' for diagnostics.}
  \item{verbose}{logical. If \code{TRUE}, fitting and tagging results will be displayed in the console.}  
  \item{...}{other parameters to be passed to downstream methods.} 
}

\details{
The \code{methods} vector is used for defining the different methods from which \code{pcrbatch} will concatenate the results. The mechanistic models (\code{mak2, mak2i, mak3, mak3i, cm3}) are omitted by default, because fitting is time-expensive. If they should be included, just add \code{"mak3"} to \code{methods}. See 'Examples'. The qPCR raw data should be arranged with the cycle numbers in the first column with the name "Cycles". All subsequent columns must be plain raw data with sensible column descriptions. If replicates are defined by \code{group}, the output will contain a numbering of groups (i.e. "group_1" for the first replicate group). The model selection process is optional, but we advocate using this for obtaining better parameter estimates. Normalization has been described to improve certain qPCR analyses, but this has still to be independently evaluated. Background subtraction is done as in \code{\link{modlist}} and \code{\link{efficiency}}. In case of unsuccessful model fitting or lack of sigmoidal structure, the names are tagged by *NAME* or **NAME**, respectively (if \code{remove = "none"}). However, if \code{remove = "fit"} or \code{remove = "KOD"}, the  failed runs are excluded from the output. Similar to \code{\link{modlist}}, if a \code{labels} vector \code{lab} is supplied, the labels from the failed fits are removed and a new label vector \code{lab_mod} is written to the global environment. 
}

\value{
A dataframe with the results in columns containing the calculated values, fit parameters and (tagged) model name together with the different methods used as the name prefix. A plot shows a plot matrix of all amplification curves/sigmoidal fits and failed amplifications marked with asterisks.
} 

\seealso{
The function \code{\link{modlist}} for creating a list of models, which is used internally by \code{pcrbatch}.
}

\author{
Andrej-Nikolai Spiess
}

\note{
IMPORTANT: When subsequent use of \code{\link{ratiocalc}} is desired, use \code{pcrbatch} on the single run level with \code{group = NULL} and \code{remove = "none"}, so that \code{\link{ratiocalc}} can automatically delete the failed runs from its \code{group} definition. Otherwise error propagation will fail.
}
     
     
\examples{
## First 4 runs and return parameters of fit
## do background subtraction using mean the first 5 cycles.
pcrbatch(reps, fluo = 2:5, baseline = "mean", basecyc = 1:5)

\dontrun{
##  First 8 runs, with 4 replicates each, l5 model.
pcrbatch(reps, fluo = 2:9, model = l5, group = c(1,1,1,1,2,2,2,2))

## Using model selection (Akaike weights) 
## on the first 4 runs, runs 1 and 2 are replicates.
pcrbatch(reps, fluo = 2:5, group = c(1,1,2,3), 
         opt = TRUE, optPAR = list(crit = "weights"))

## Fitting a sigmoidal and 'mak3' mechanistic model.
pcrbatch(reps, methods = c("sigfit", "mak3"))

## Converting a 'modlist' to 'pcrbatch'.
ml5 <- modlist(reps, 1, 2:5, b5)
res5 <- pcrbatch(ml5)

## Using Whittaker smoothing.
pcrbatch(reps, smooth = "whit")
}    
}

\keyword{models}
\keyword{nonlinear}
