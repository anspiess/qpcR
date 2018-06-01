\name{getPar}
\alias{getPar}

\title{Batch calculation of qPCR fit parameters/efficiencies/threshold cycles with simple output, especially tailored to high-throughput data}

\description{
This is a cut-down version of \code{\link{pcrbatch}}, starting with data of class 'modlist', which delivers a simple dataframe output, with either the parameters of the fit or calculated threshold cycles/efficiencies. The column names are deduced from the run names. All calculations have been error-protected through \code{\link{tryCatch}}, so whenever there is any kind of error (parameter extraction, efficiency estimation etc), \code{NA} is returned. This function can be used with high throughput data quite conveniently. All methods as in \code{\link{pcrbatch}} are available. The results are automatically copied to the clipboard.  
}

\usage{
getPar(x, type = c("fit", "curve"), cp = "cpD2", eff = "sigfit", ...)
}

\arguments{
  \item{x}{an object of class 'pcrfit' or 'modlist'.}
  \item{type}{\code{fit} will extract the fit parameters, \code{curve} will invoke \code{\link{efficiency}} and return threshold cycles/efficiencies.}
  \item{cp}{which method for threshold cycle estimation. Any of the methods in \code{\link{efficiency}}, i.e. "cpD2" (default), "cpD1", "maxE", "expR", "Cy0", "CQ", "maxRatio".}
  \item{eff}{which method for efficiency estimation. Either "sigfit" (default), "sliwin" or "expfit".}  
  \item{...}{other parameters to be passed to \code{\link{efficiency}}, \code{\link{sliwin}} or \code{\link{expfit}}.} 
}

\details{
Takes about 4 sec for 100 runs on a Pentium 4 Quad-Core (3 Ghz) when using \code{type = "curve"}. When using \code{type = "fit"}, the fitted model parameters are returned. If \code{type = "curve"}, threshold cycles and efficiencies are calculated by \code{\link{efficiency}} based on the parameters supplied in \code{...} (default \code{cpD2}).
}

\value{
A dataframe, which is automatically copied to the clipboard.
}

\author{
Andrej-Nikolai Spiess.
}

\examples{
## Simple example with fit parameters.
ml1 <- modlist(rutledge, model = l5)
getPar(ml1, type = "fit")

## Using a mechanistic model such as
## 'mak3' and extracting D0 values
## => initial template fluorescence.
ml2 <- modlist(rutledge, 1, 2:41, model = mak3)
res <- getPar(ml2, type = "fit")
barplot(log10(res[1, ]), las = 2)
}

\keyword{models}
\keyword{nonlinear}
