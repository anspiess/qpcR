\name{expcomp}
\alias{expcomp}

\title{Comparison of all sigmodal models within the exponential region}

\description{
The exponential region of the qPCR data is identified by the studentized outlier method, as in \code{\link{expfit}}.
The root-mean-squared-error (RMSE) of all available sigmoidal models within this region is then calculated.
The result of the fits are plotted and models returned in order of ascending RMSE.
}

\usage{
expcomp(object, ...)
}

\arguments{
  \item{object}{an object of class 'pcrfit'.}
  \item{...}{other parameters to be passed to \code{expfit}.} 
}

\details{
The following sigmoidal models are fitted:
b4, b5, b6, b7, l4, l5, l6, l7
}


\value{
A dataframe with names of the models, in ascending order of RMSE.
}

\author{
Andrej-Nikolai Spiess
}

\examples{
m1 <- pcrfit(reps, 1, 2, l4)
expcomp(m1)
}

\keyword{models}
\keyword{nonlinear}
