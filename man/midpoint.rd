\name{midpoint}
\alias{midpoint}

\title{Calculation of the 'midpoint' region}

\description{
Calculates the exponential region midpoint using the algorithm described in Peirson \emph{et al}. (2003).
}

\usage{
midpoint(object, noise.cyc = 1:5)
}

\arguments{
  \item{object}{a fitted object of class 'pcrfit'.}
  \item{noise.cyc}{the cycles defining the background noise.}      
}

\details{
The 'midpoint' region is calculated by \deqn{F_{noise} \cdot \sqrt{\frac{F_{max}}{F_{noise}}}}
 with \eqn{F_{noise}} = the standard deviation of the background cycles and \eqn{F_{max}} = the maximal fluorescence.
}

\value{
 A list with the following components:
  \item{f.mp}{the 'midpoint' fluorescence.}
  \item{cyc.mp}{the 'midpoint' cycle, as predicted from \code{f.mp}.}    
}

\author{
Andrej-Nikolai Spiess
}

\references{
Experimental validation of novel and conventional approaches to quantitative real-time PCR data analysis.\cr
Peirson SN, Butler JN & Foster RG.\cr
\emph{Nucleic Acids Research} (2003), \bold{31}: e73.  
}

\examples{
m1 <- pcrfit(reps, 1, 2, l5)
mp <- midpoint(m1) 
plot(m1)
abline(h = mp$f.mp, col = 2)
abline(v = mp$mp, col = 2)  
}

\keyword{models}
\keyword{nonlinear}
