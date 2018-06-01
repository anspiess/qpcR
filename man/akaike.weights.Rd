\name{akaike.weights}
\alias{akaike.weights}

\encoding{latin1}

\title{Calculation of Akaike weights/relative likelihoods/delta-AICs}

\description{
Calculates Akaike weights from a vector of AIC values. 
}

\usage{
akaike.weights(x)
}

\arguments{
\item{x}{a vector containing the AIC values.}
}

\details{
Although Akaike's Information Criterion is recognized as a major measure for selecting models, it has one major drawback: The AIC values lack intuitivity despite higher values meaning less goodness-of-fit. For this purpose, Akaike weights come to hand for calculating the weights in a regime of several models. Additional measures can be derived, such as \eqn{\Delta(AIC)} and relative likelihoods that demonstrate the probability of one model being in favor over the other. This is done by using the following formulas:

delta AICs: \deqn{\Delta_i(AIC) = AIC_i - min(AIC)}

relative likelihood: \deqn{L \propto exp\left(-\frac{1}{2}\Delta_i(AIC)\right)}

Akaike weights: \deqn{w_i(AIC) = \frac{exp\left(-\frac{1}{2}\Delta_i(AIC)\right)}{\sum_{k=1}^K exp\left(-\frac{1}{2}\Delta_k(AIC)\right)}}
}

\value{
A list containing the following items:
\item{deltaAIC}{the \eqn{\Delta(AIC)} values.}
\item{rel.LL}{the relative likelihoods.}
\item{weights}{the Akaike weights.}
}

\author{
Andrej-Nikolai Spiess
}

\references{
Classical literature:\cr
Akaike Information Criterion Statistics.\cr
Sakamoto Y, Ishiguro M and Kitagawa G.\cr
D. Reidel Publishing Company (1986).\cr

Model selection and inference: a practical information-theoretic approach.\cr
Burnham KP & Anderson DR.\cr
Springer Verlag, New York, USA (2002).\cr
 
A good summary:\cr
AIC model selection using Akaike weights.
Wagenmakers EJ & Farrell S.\cr
\emph{Psychonomic Bull Review} (2004), \bold{11}: 192-196.\cr
}

\seealso{
\code{\link{AIC}}, \code{\link{logLik}}.
}

\examples{
## Apply a list of different sigmoidal models to data
## and analyze GOF statistics with Akaike weights
## on 8 different sigmoidal models.
modList <- list(l7, l6, l5, l4, b7, b6, b5, b4)
aics <- sapply(modList, function(x) AIC(pcrfit(reps, 1, 2, x))) 
akaike.weights(aics)$weights 
}

\keyword{models}
\keyword{nonlinear}
