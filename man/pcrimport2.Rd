\name{pcrimport2}
\alias{pcrimport2}

\title{Simple qPCR data import function (i.e. from text files or clipboard)}

\description{
Simple wrapper function to easily import qPCR data from the clipboard (default) or tab-delimited text files.
In contrast to \code{\link{pcrimport}}, this function has no enhanced formatting features, but is quick and
easy to use on data that has been pre-formatted, i.e. as in dataset \code{\link{reps}} ('Cycles' in the first column, all
remaining columns with sensible names.
}

\usage{
pcrimport2(file = "clipboard", sep = "\t", header = TRUE, quote = "",
          dec = ".", colClasses = "numeric", ...)
}

\arguments{
  \item{file}{the name of the file which the data are to be read from (full path).}
  \item{sep}{the field separator character.}
  \item{header}{a logical value indicating whether the file contains the names of the variables as its first line.}
  \item{quote}{the set of quoting characters.}
  \item{dec}{the character used in the file to denote decimal points.}
  \item{colClasses}{character. A vector of classes to be assumed for the columns.} 
  \item{...}{further arguments to be passed on to \code{\link{read.table}}.}
 }

\details{
  For a more detailed description of the arguments see \code{\link{read.table}}.
}

\value{
A data frame containing a representation of the data in the file.  
}

\note{
This function is the former \code{pcrimport} from packages 1.3-3 downward.
See \code{\link{pcrimport}} for an enhanced version offering formatting in the presence of reference dyes, columns/rows deletion,
 transforming from wide to long format, and automatic batch analysis.
}

\author{
  Andrej-Nikolai Spiess
}

\examples{
## Paste some Excel data into the clipboard.
\dontrun{
temp <- pcrimport2()
}
## From a tab-delimited text file.
\dontrun{
temp <- pcrimport2("c:\\temp\\foo.txt")
}
}

\keyword{IO}
\keyword{file}
