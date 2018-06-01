\name{resplot}
\alias{resplot}

\title{An (overlayed) residuals barplot}

\description{
A plotting function which displays a barplot of the (standardized) residuals. The bars are colour-coded with heat colours proportional to the residual value. As default, the residuals are displayed together with the points of the fitted PCR curve. 
}

\usage{
resplot(object, overlay = TRUE, ylim = NULL, ...)
}

\arguments{
 \item{object}{an object of class 'pcrfit.} 
 \item{overlay}{logical. If \code{TRUE}, the residuals are plotted on top of the fitted curve, else alone.}
 \item{ylim}{graphical ylim values for tweaking the scale and position of the barplot overlay.}
 \item{...}{any other parameters to be passed to \code{\link{barplot}}.} 	
}

\value{
A plot as described above.
}

\details{
If replicate data is present in the fitted curve, the residuals from all replicates \eqn{i, j} are summed up from the absolute values: \eqn{Y_i = \sum{|\hat{\varepsilon}_{i, j}|}}.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
## Create l5 model and plot 
## standardized residuals.
m1 <- pcrfit(reps, 1, 2, l5)
resplot(m1)

\dontrun{
## Using replicates.
m2 <- pcrfit(reps, 1, 2:5, l5)
resplot(m2)
}
}

\keyword{models}
\keyword{nonlinear}
