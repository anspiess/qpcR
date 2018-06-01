\name{Cy0}
\alias{Cy0}

\title{Cy0 alternative to threshold cycles as in Guescini et al. (2008)}

\description{
An alternative to the classical crossing point/threshold cycle estimation as described in Guescini \emph{et al} (2002). A tangent is fit to the first derivative maximum (point of inflection) of the modeled curve and the intersection with the x-axis is calculated.   
}

\usage{
Cy0(object, plot = FALSE, add = FALSE, ...)
}

\arguments{
  \item{object}{a fitted object of class 'pcrfit'.}
  \item{plot}{if \code{TRUE}, displays a plot of Cy0.}
  \item{add}{if \code{TRUE}, a plot is added to any other existing plot, i.e. as from \code{\link{plot.pcrfit}}.}
  \item{...}{other parameters to be passed to \code{\link{plot.pcrfit}} or \code{\link{points}}.}	
 }

\details{
The function calculates the first derivative maximum (cpD1) of the curve and the slope and fluorescence \eqn{F_{cpD2}} at that point.
 Cy0 is then calculated by \eqn{Cy_0 = cpD1 - \frac{F_{cpD2}}{slope}}.
}

\value{
The \eqn{Cy_0} value.  
}

\author{
Andrej-Nikolai Spiess
}

\references{
A new real-time PCR method to overcome significant quantitative inaccuracy due to slight amplification inhibition.\cr
Guescini M, Sisti D, Rocchi MB, Stocchi L & Stocchi V.\cr
\emph{BMC Bioinformatics} (2008), \bold{9}: 326.\cr
}
          
\examples{
## Single curve with plot.
m1 <- pcrfit(reps, 1, 2, l5)
Cy0(m1, plot = TRUE)

## Add to 'efficiency' plot.
efficiency(m1)
Cy0(m1, add = TRUE)

## Compare s.d. of replicates between
## Cy0 and cpD2 method. cpD2 wins!
ml1 <- modlist(reps, model = l4)
cy0 <- sapply(ml1, function(x) Cy0(x))
cpd2 <- sapply(ml1, function(x) efficiency(x, plot = FALSE)$cpD2)
tapply(cy0, gl(7, 4), function(x) sd(x))
tapply(cpd2, gl(7, 4), function(x) sd(x)) 
}

\keyword{models}
\keyword{nonlinear}
