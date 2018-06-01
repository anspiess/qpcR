\name{parKOD}
\alias{parKOD}

\title{Parameters that can be changed to tweak the kinetic outlier methods}

\description{
A control function with different list items that change the performance of the different (kinetic) outlier functions as defined in \code{\link{KOD}}. 
}

\usage{
parKOD(eff = c("sliwin", "sigfit", "expfit"), train = TRUE, 
       alpha = 0.05, cp.crit = 10, cut = c(-6, 2))
}

\arguments{
\item{eff}{\bold{uni1}. The efficiency method to be used. Either \code{sliwin}, \code{sigfit} or \code{expfit}.}
\item{train}{\bold{uni1}. If \code{TRUE}, the sample's efficiency is NOT included in the calculation of the average efficiency (default), if \code{FALSE} it is.}
\item{cp.crit}{\bold{uni2}. The cycle difference between first and second derivative maxima, default is 10.} 
\item{cut}{\bold{multi1}. A 2-element vector defining the lower and upper border from the first derivative maximum from where to cut the complete curve.}
\item{alpha}{the p-value cutoff value for all implemented statistical tests.}
}

\details{
For more details on the function of the parameters within the different kinetic and sigmoidal outlier methods, see \code{\link{KOD}}.
}

\value{
If called, returns a list with the parameters as items.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
## Multivariate outliers,
## adjusting the 'cut' parameter.
ml1 <- modlist(reps, 1, 2:5, model = l5)
res1 <- KOD(ml1, method = "multi1", par = parKOD(cut = c(-5, 2)))
}

\keyword{models}
\keyword{nonlinear}
