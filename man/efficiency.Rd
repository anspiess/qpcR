\name{efficiency}
\alias{efficiency} 


\title{Calculation of qPCR efficiency and other important qPCR parameters}

\description{
This function calculates the PCR efficiency of a model of class 'pcrfit', including several other important values for qPCR quantification like the first and second derivatives and the corresponding maxima thereof (i.e. threshold cycles). These values can subsequently be used for the calculation of PCR kinetics, fold induction etc. All values are included in a graphical output of the fit. Additionally, several measures of goodness-of-fit are calculated, i.e. the Akaike Information Criterion (AIC), the residual variance and the \eqn{R^2} value.   
}

\usage{
efficiency(object, plot = TRUE, type = "cpD2", thresh = NULL, 
           shift = 0, amount = NULL, ...)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{plot}{logical. If TRUE, a graph is displayed. If FALSE, values are printed out.}
  \item{type}{the method of efficiency estimation. See 'Details'.}
  \item{thresh}{an (optional) numeric value for a fluorescence threshold border. Overrides \code{type}.}
  \item{shift}{a user defined shift in cycles from the values defined by \code{type}. See 'Examples'.}
  \item{amount}{the template amount or molecule number for quantitative calibration.}
  \item{...}{other parameters to be passed to \code{\link{eff}} or \code{\link{plot.pcrfit}}.}
}

\details{
The efficiency is always (with the exception of \code{type = "maxRatio"}) calculated from the efficiency curve (in blue), which is calculated according to \eqn{E_n = \frac{F_n}{F_{n-1}}} from the fitted curve, but taken from different points at the curve, as to be defined in \code{type}: 

"cpD2"  taken from the maximum of the second derivative curve,\cr
"cpD1"  taken from the maximum of the first derivative curve,\cr
"maxE"  taken from the maximum of the efficiency curve,\cr
"expR"  taken from the exponential region by \eqn{expR = cpD2-(cpD1-cpD2)},\cr
"CQ"    taken from the 20\% value of the fluorescence at "cpD2" as developed by Corbett Research (comparative quantification),\cr
"Cy0"   the intersection of a tangent on the first derivative maximum with the abscissa as calculated according to Guescini et al. or\cr
a numeric value taken from the threshold cycle output of the PCR software, i.e. 15.24  as defined in \code{type} or\cr
a numeric value taken from the fluorescence threshold output of the PCR software as defined in \code{thresh}.

The initial fluorescence \eqn{F_0} for relative or absolute quantification is either calculated by setting \eqn{x = 0} in the sigmoidal model of \code{object} giving \code{init1} or by calculating an exponential model down (\code{init2}) with \eqn{F_0 = \frac{F_n}{E^n}}, with \eqn{F_n} = raw fluorescence, \eqn{E} = PCR efficiency and \eqn{n} = the cycle number defined by \code{type}. If a template amount is defined, a conversion factor \eqn{cf = \frac{amount}{F_0}} is given. The different measures for goodness-of-fit give an overview for the validity of the efficiency estimation. First and second derivatives are calculated from the fitted function and the maxima of the derivatives curve and the efficiency curve are obtained. 

If \code{type = "maxRatio"}, the maximum efficiency is calculated from the cubic spline interpolated raw fluorescence values and therefore NOT from the sigmoidal fit. This is a different paradigm and will usually result in fairly the same threshold cycles as with \code{type = "cpD2"}, but the efficiencies are generally lower. See documentation to \code{\link{maxRatio}}. This method is usually not applied for calculating efficiencies that are to be used for relative quantification, but one might try...  
}

\value{
  A list with the following components:
  \item{eff}{the PCR efficiency.}
  \item{resVar}{the residual variance.}
  \item{AICc}{the bias-corrected Akaike Information Criterion.}
  \item{AIC}{the Akaike Information Criterion.}
  \item{Rsq}{the \eqn{R^2} value.}
  \item{Rsq.ad}{the adjusted \eqn{R_{adj}^2} value.}
  \item{cpD1}{the first derivative maximum (point of inflection in 'l4' or 'b4' models, 
  can be used for defining the threshold cycle).}
  \item{cpD2}{the second derivative maximum (turning point of cpD1, more often used for defining 
  the threshold cycle).}
  \item{cpE}{the PCR cycle with the highest efficiency.}
  \item{cpR}{the PCR cycle within the exponential region calculated as under 'Details'.}
  \item{cpT}{the PCR cycle corresponding to the fluorescence threshold as defined in \code{thresh}.}
  \item{Cy0}{the PCR threshold cycle 'Cy0' according to Guescini et al. See 'Details'.} 
  \item{cpCQ}{the PCR cycle corresponding to the 20\% fluorescence value at 'cpD2'.}
  \item{cpMR}{the PCR cycle corresponding to the 'maxRatio', if this was selected.}
  \item{fluo}{the raw fluorescence value at the point defined by \code{type} or \code{thresh}.}
  \item{init1}{the initial template fluorescence from the sigmoidal model, calculated as under 'Details'.}
  \item{init2}{the initial template fluorescence from an exponential model, calculated as under 'Details'.}
  \item{cf}{the conversion factor between raw fluorescence and template amount, if the latter is defined.}

If \code{object} was of type 'modlist', the results are given as a matrix, with samples in columns.
}

\author{
Andrej-Nikolai Spiess 
}

\references{
Validation of a quantitative method for real time PCR kinetics.\cr
Liu W & Saint DA.\cr  
\emph{BBRC} (2002), \bold{294}: 347-353.\cr

A new real-time PCR method to overcome significant quantitative inaccuracy due to slight amplification inhibition.\cr
Guescini M, Sisti D, Rocchi MB, Stocchi L & Stocchi V.\cr
\emph{BMC Bioinformatics} (2008), \bold{9}: 326.  
}

\note{
In some curves that are fitted with the 'b5'/'l5' models, the 'f' (asymmetry) parameter can be extremely high due to severe asymmetric structure. The efficiency curve deduced from the coefficients of the fit can then be very extreme in the exponential region. It is strongly advised to use \code{efficiency(object, method = "spline")} so that \code{\link{eff}} calculates the curve from a cubic spline of the original data points (see 'Examples').

Three parameter models ('b3' or 'l3') do not work very well in calculating the PCR efficiency. It is advisable not to take too many cycles of the plateau phase prior to fitting the model as this has a strong effect on the validity of the efficiency estimates. 
}

\examples{
## Fitting initial model.
m1 <-  pcrfit(reps, 1, 2, l4)
efficiency(m1)
 
## Using one cycle 'downstream'
## of second derivative max.
efficiency(m1, type = "cpD2", shift = -1)

## Using "maxE" method, with calculation of PCR efficiency
## 2 cycles 'upstream' from the cycle of max efficiency.
efficiency(m1, type = "maxE", shift = 2)

## Using the exponential region.
efficiency(m1, type = "expR")

## Using threshold cycle (i.e. 15.32) 
## from PCR software.
efficiency(m1, type = 15.32)

## Using Cy0 method from Guescini et al. (2008)
## add Cy0 tangent. 
efficiency(m1, type = "Cy0")
Cy0(m1, add = TRUE)

## Using a defined fluorescence
## threshold value from PCR software.
efficiency(m1, thresh = 1)
 
## Using the first 30 cycles and a template amount
## (optical calibration).
m2 <-  pcrfit(reps[1:30, ], 1, 2, l5)
efficiency(m2, amount = 1E3)

## Using 'maxRatio' method from Shain et al. (2008)
## baseshifting essential!
efficiency(m1, type = "maxRatio", baseshift = 0.2)

## Using the efficiency from a cubic spline fit
## of the 'eff' function.
efficiency(m1, method = "spline")

\dontrun{
## On a modlist with plotting
## of the efficiencies.
ml1 <- modlist(reps, model = l5)
res <- sapply(ml1, function(x) efficiency(x)$eff)
barplot(as.numeric(res))
}
}

\keyword{models}
\keyword{nonlinear}
