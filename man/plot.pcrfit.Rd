\name{plot.pcrfit}
\alias{plot.pcrfit}

\title{Plotting qPCR data with fitted curves}

\description{
A plotting function for data of class 'pcrfit' (single curves) or 'modlist' (batch curves) displaying the data points and the fitted curve. Four different plot types are available, namely plotting all curves in a 2D graph, a 2D plot matrix, a 3D graph or a heatmap-like image plot.
}

\usage{
\method{plot}{pcrfit}(x, type = c("all", "single", "3D", "image"), 
        fitted = TRUE, add = FALSE, col = NULL, par2D = list(),
        par3D = list(), ...)
}

\arguments{
  \item{x}{an object of class 'pcrfit' or 'modlist'.}     
  \item{type}{plots all curves in 2D (\code{"all"}), a plot matrix with many curves (\code{"single"}), a 3D plot (\code{"3D"}) or a heatmap-like image plot (\code{image}).} 
  \item{fitted}{should the fitted lines be displayed?}      
  \item{add}{should the curve be added to an existing plot?}
  \item{col}{an optional color vector for the individual curves. Is recycled to the number of runs in \code{x}.} 
  \item{par2D}{a list containing graphical parameters to change the 2D-plots: \code{\link{plot}}, \code{\link{points}} or \code{\link{lines}}.}
  \item{par3D}{a list containing graphical parameters to change the 3D-plot: \code{\link{plot3d}}, \code{\link{points3d}}, \code{\link{lines3d}}, \code{\link{axis3d}} or \code{\link{mtext3d}}.}
  \item{...}{other parameters for downstream methods.}
}


\value{
A 2D, multiple 2D, 3D or heatmap-like qPCR plot. 
}
 

\details{
Uses the 'rgl' package for 3D plots. If the 'modlist' contains runs that failed to fit, these are displayed with RED asterisked names. In addition, sigmoidal outlier runs will be displayed in BLUE with double asterisked names. This approach makes the identification of failed runs easy and works only with \code{type = "single"}. See 'Examples'.\cr
For high-throughput data, the user of this function is encouraged to use the \code{"image"} kind of plot, as one can see quite nicely the differences in the amplification profiles of several hundred runs. Of course, this plot type does not display the fitted curve. See 'Examples'.
}
     
\author{
Andrej-Nikolai Spiess
}
        
\examples{
## Single plot.
m1 <- pcrfit(reps, 1, 2, l5)
plot(m1)

## Add another plot in blue.
m2 <- pcrfit(reps, 1, 12, l5)
plot(m2, add = TRUE, col = 4)

## Plot a 'modlist' batch with coloring of replicates.
ml1 <- modlist(reps, 1, 2:13, model = l4)
plot(ml1, col = gl(3,4))   

## Subset of cycle range.
plot(ml1, col = rep(1:3, each = 4), 
     par2D = list(xlim = c(10, 30)))

## Plot single curves for diagnostics.
plot(ml1, type = "single", col = rep(1:3, each = 4))

## 3D plots of 'modlist's.
plot(ml1, type = "3D", col = rep(1:3, each = 4))
rgl.close()

\dontrun{
## Example for "image" type when
## using large data.
ml2 <- modlist(vermeulen2)
plot(ml2, type = "image")

## Example for outlier identification:
## RED/*name* indicates failed fitting,
## BLUE/**name** indicates sigmoidal outlier
## using 'testdat' set.
ml3 <- modlist(testdat, model = l5)
plot(ml3, type = "single") 
}
}

\keyword{models}
\keyword{nonlinear}
