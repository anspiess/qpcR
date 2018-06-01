\name{update.pcrfit}
\alias{update.pcrfit}

\title{Updating and refitting a qPCR model}

\description{
Updates and re-fits a model of class 'pcrfit'. 
}

\usage{
\method{update}{pcrfit}(object, ..., evaluate = TRUE)
}

\arguments{
  \item{object}{a fitted model of class 'pcrfit'.}
  \item{...}{arguments to alter in object.}
  \item{evaluate}{logical. If \code{TRUE}, model is re-fit; otherwise an unevaluated call is returned.}   
}

\value{
An updated model of class 'pcrfit' and 'nls'.
}

\author{
Andrej-Nikolai Spiess
}

\seealso{
The function \code{\link{pcrfit}} in this package.
}

\examples{
m1 <- pcrfit(reps, 1, 2, l4)

## Update model.
update(m1, model = l5)

## Update qPCR run.
update(m1, fluo = 20)

## Update data.
update(m1, data = guescini1)    
}

\keyword{models}
\keyword{nonlinear}
