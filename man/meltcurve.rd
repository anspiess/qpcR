\name{meltcurve}
\alias{meltcurve}
\encoding{latin1}

\title{Melting curve analysis with (iterative) Tm identification and peak area calculation/cutoff}

\description{
This function conducts a melting curve analysis from the melting curve data of a real-time qPCR instrument.
The data has to be preformatted in a way that for each column of temperature values there exists a corresponding fluorescence value column. See \code{edit(dyemelt)} for a proper format. The output is a graph displaying the raw fluorescence curve (black), the first derivative curve (red) and the identified melting peaks. The original data together with the results (\eqn{-\frac{\partial F}{\partial T}} values, \eqn{T_m} values) are returned as a list. An automatic optimization procedure is also implemented which iterates over \code{span.smooth} and \code{span.peaks} values and finds the optimal parameter combination that delivers minimum residual sum-of-squares of the identified \eqn{T_m} values to known \eqn{T_m} values. For all peaks, the areas can be calculated and only those included which have areas higher than a given cutoff (\code{cut.Area}). If no peak was identified meeting the cutoff values, the melting curves are flagged with a 'bad' attribute. See 'Details'. 
}

\usage{
meltcurve(data, temps = NULL, fluos = NULL, window = NULL, 
          norm = FALSE, span.smooth = 0.05, span.peaks = 51, 
          is.deriv = FALSE, Tm.opt = NULL, Tm.border = c(1, 1), 
          plot = TRUE, peaklines = TRUE, calc.Area = TRUE, 
          plot.Area = TRUE, cut.Area = 0,...)
}

\arguments{
  \item{data}{a dataframe containing the temperature and fluorescence data.}
  \item{temps}{a vector of column numbers reflecting the temperature values. If \code{NULL}, they are assumed to be 1, 3, 5, ... .}     
  \item{fluos}{a vector of column numbers reflecting the fluorescence values. If \code{NULL}, they are assumed to be 2, 4, 6, ... .}  	
  \item{window}{a user-defined window for the temperature region to be analyzed. See 'Details'.}
  \item{norm}{logical. If \code{TRUE}, the fluorescence values are scaled between [0, 1].}
  \item{span.smooth}{the window span for curve smoothing. Can be tweaked to optimize \eqn{T_m} identification.}
  \item{span.peaks}{the window span for peak identification. Can be tweaked to optimize \eqn{T_m} identification. Must be an odd number.}
  \item{is.deriv}{logical. Use \code{TRUE}, if \code{data} is already in first derivative transformed format.}
  \item{Tm.opt}{a possible vector of known \eqn{T_m} values to optimize \code{span.smooth} and \code{span.peaks} against. See 'Details' and 'Examples'.}
  \item{Tm.border}{for peak area calculation, a vector containing left and right border temperature values from the \eqn{T_m} values. Default is -1/+1 ?C.}
  \item{plot}{logical. If \code{TRUE}, a plot with the raw melting curve, derivative curve and identified \eqn{T_m} values is displayed for each sample.}
  \item{peaklines}{logical. If \code{TRUE}, lines that show the identified peaks are plotted.} 
  \item{calc.Area}{logical. If \code{TRUE}, all peak areas are calculated.} 
  \item{plot.Area}{logical. If \code{TRUE}, the baselined area identified for the peaks is plotted by filling the peaks in red.} 
  \item{cut.Area}{a peak area value to identify only those peaks with a higher area.} 
  \item{...}{other parameters to be passed to \code{\link{plot}}.}
}

\details{
The melting curve analysis is conducted with the following steps:\cr

1a) Temperature and fluorescence values are selected in a region according to \code{window}.\cr
1b) If \code{norm = TRUE}, the fluorescence data is scaled into [0, 1] by \code{qpcR:::rescale}.\cr
Then, the function \code{qpcR:::TmFind} conducts the following steps:\cr
2a) A cubic spline function (\code{\link{splinefun}}) is fit to the raw fluorescence melt values.\cr
2b) The first derivative values are calculated from the spline function for each of the temperature values.\cr
2c) Friedman's supersmoother (\code{\link{supsmu}}) is applied to the first derivative values.\cr
2d) Melting peaks (\eqn{T_m}) values are identified by \code{qpcR:::peaks}.\cr
2e) Raw melt data, first derivative data, best parameters, residual sum-of-squares and identified \eqn{T_m} values are returned.\cr 
Peak areas are then calculated by \code{qpcR:::peakArea}:\cr
3a) A linear regression curve is fit from the leftmost temperature value (\eqn{T_m} - \code{Tm.border}[1]) to the rightmost temperature value (\eqn{T_m} + \code{Tm.border}[2]) by \code{\link{lm}}.\cr
3b) A baseline curve is calculated from the regression coefficients by \code{\link{predict.lm}}.\cr
3c) The baseline data is subtracted from the first derivative melt data (baselining).\cr
3d) A \code{\link{splinefun}} is fit to the baselined data.\cr
3e) The area of this spline function is \code{\link{integrate}}d from the leftmost to rightmost temperature value.\cr
4) If calculated peak areas were below \code{cut.Area}, the corresponding \eqn{T_m} values are removed.\cr 
Finally,\cr
5) A matrix of xyy-plots is displayed using \code{qpcR:::xyy.plot}.\cr

\code{is.deriv} must be set to \code{TRUE} if the exported data was already transformed to \eqn{-\frac{\partial F}{\partial T}} by the PCR system (i.e. Stratagene MX3000P).\cr

If values are given to \code{Tm.opt} (see 'Examples'), then \code{meltcurve} is iterated over all combinations of \code{span.smooth = seq(0, 0.2, by = 0.01)} and \code{span.peaks = seq(11, 201, by = 10)}. For each iteration, \eqn{T_m} values are calculated and compared to those given by measuring the residual sum-of-squares between the given values \code{Tm.opt} and the \eqn{Tm} values obtained during the iteration:
 \deqn{RSS = \sum_{i=1}^n{(Tm_i - Tm.opt_i)^2}} 

The returned list items containing the resulting data frame each has an attribute \code{"quality"} which is set to "bad" if none of the peaks met the \code{cut.Area} criterion (or "good" otherwise).
}

\value{
A list with as many items as melting curves, named as in \code{data}, each containing a data.frame with the temperature (\emph{Temp}), fluorescence values (\emph{Fluo}), first derivative (\emph{dF.dT}) values, (optimized) parameters of \emph{span.smooth}/\emph{span.peaks}, residual sum-of-squares (if \code{Tm.opt != NULL}), identified melting points (\emph{Tm}), calculated peak areas (\emph{Area}) and peak baseline values (\emph{baseline}).  
}

\note{
The \code{peaks} function is derived from a R-Help mailing list entry in Nov 2005 by Martin Maechler.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
## Default columns.
data(dyemelt)
res1 <- meltcurve(dyemelt, window = c(75, 86))
res1

## Selected columns and normalized fluo values.
res2 <- meltcurve(dyemelt, temps = c(1, 3), fluos = c(2, 4), 
                  window = c(75, 86), norm = TRUE)  

## Removing peaks based on peak area
## => two peaks have smaller areas and are not included.
res3 <- meltcurve(dyemelt, temps = 1, fluos = 2, window = c(75, 86),  
                  cut.Area = 0.2) 
attr(res3[[1]], "quality")
                 
## If all peak areas do not meet the cutoff value, meltcurve is
## flagged as 'bad'.
res4 <- meltcurve(dyemelt, temps = 1, fluos = 2, window = c(75, 86),  
                  cut.Area = 0.5) 
attr(res4[[1]], "quality")

## Optimizing span and peaks values.
\dontrun{
res5 <- meltcurve(dyemelt[, 1:6], window = c(74, 88), 
                  Tm.opt = c(77.2, 80.1, 82.4, 84.8))
}
}

\keyword{models}
\keyword{nonlinear}
