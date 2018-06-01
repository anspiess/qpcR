\name{replist}
\alias{replist}

\encoding{latin1}

\title{Amalgamation of single data models into a model containing replicates}

\description{
Starting from a 'modlist' containing qPCR models from single data, \code{replist} amalgamates the models according to the grouping structure as defined in \code{group}. The result is a 'replist' with models obtained from fitting the replicates by \code{\link{pcrfit}}. A kinetic outlier detection and removal option is included.
}

\usage{
replist(object, group = NULL, check = "none",
        checkPAR = parKOD(), remove = c("none", "KOD"), 
        names = c("group", "first"), doFit = TRUE, opt = FALSE, 
        optPAR = list(sig.level = 0.05, crit = "ftest"), 
        verbose = TRUE, ...)
}

\arguments{
 \item{object}{an object of class 'modlist'.}
 \item{group}{a vector defining the replicates for each group.}
 \item{check}{which method to use for kinetic outlier detection. Either \code{none} or any of the methods in \code{\link{KOD}}.}
 \item{checkPAR}{parameters to be supplied to the \code{check} method, see \code{\link{KOD}}.}
 \item{remove}{which runs to remove. Either \code{none} or those that failed from the method defined in \code{check}.}
 \item{names}{how to name the grouped fit. Either 'group_1, ...' or the first name of the replicates.}
 \item{doFit}{logical. If set to \code{FALSE}, the replicate data is only aggregated without doing a refitting. See 'Details'.}
 \item{opt}{logical. Should model selection be applied to the final model?}
 \item{optPAR}{parameters to be supplied to \code{\link{mselect}}.}
 \item{verbose}{if \code{TRUE}, the analysis is printed to the console.}
 \item{...}{other parameters to be supplied to \code{\link{mselect}}.}    
}

\details{
As being defined by \code{group}, the 'modlist' is split into groups of runs and these amalgamated into a nonlinear model. Runs which have failed to be fitted by \code{\link{modlist}} are automatically removed and \code{group} is updated (that is, the correpsonding entries also removed) prior to fitting the replicate model by \code{\link{pcrfit}}. Model selection can be applied to the final replicate model by setting \code{opt = TRUE} and changing the parameters in \code{optPAR}. If \code{check} is set to any of the methods in \code{"KOD"}, kinetic outliers are identified and optionally removed, if \code{remove} is set to \code{"KOD"}.\cr
If \code{doFit = FALSE}, the replicate data is only aggregated and no refitting is done. This is useful when plotting replicate data by some grouping vector. See 'Examples'.
}

\value{
An object of class 'replist' containing the replicate models of class 'nls'/'pcrfit'.  
}

\author{
Andrej-Nikolai Spiess
}

\seealso{
\code{\link{modlist}}, \code{\link{pcrfit}}.
}

\examples{    
## Convert 'modlist' into 'replist'.
ml1 <- modlist(reps, model = l4)
rl1 <- replist(ml1, group = gl(7, 4))
plot(rl1)
summary(rl1[[1]])

## Optimize model based on Akaike weights.
rl2 <- replist(ml1, group = gl(7, 4), opt = TRUE, 
               optPARS = list(crit = "weights"))
plot(rl2)

\dontrun{
## Remove kinetic outliers,
## use first replicate name for output.
ml3 <- modlist(reps, model = l4)
rl3 <- replist(ml3, group = gl(7, 4), check = "uni1", 
               remove = "KOD", names = "first")
plot(rl3, which = "single")

## Just aggregation and no refitting.
ml4 <- modlist(reps, model = l4)
rl4 <- replist(ml4, group = gl(7, 4), doFit = FALSE)
plot(rl4, which = "single")

## Scenario 1:
## automatic removal of runs that failed to
## fit during 'modlist' by using 'testdat' set.
ml5 <- modlist(testdat, model = l5)
rl5 <- replist(ml5, gl(6, 4))
plot(rl5, which = "single")

## Scenario 2:
## automatic removal of runs that failed to
## fit during 'replist':
## samples F3.1-F3.4 is set to 1.
dat1 <- reps
ml6 <- modlist(dat1)
ml6[[9]]$DATA[, 2] <- 1
ml6[[10]]$DATA[, 2] <- 1
ml6[[11]]$DATA[, 2] <- 1
ml6[[12]]$DATA[, 2] <- 1
rl6 <- replist(ml6, gl(7, 4))
plot(rl6, which = "single")
}
}

\keyword{models}
\keyword{nonlinear}
