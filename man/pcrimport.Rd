\name{pcrimport}
\alias{pcrimport}

\title{Advanced qPCR data import function}

\description{
Advanced function to easily import/preformat qPCR data from delimited text files, the clipboard or the workspace. The data files can be located in a directory which is automatically browsed for all files. In a series of steps, the data can be imported and transformed to the appropriate format of the 'qpcR' package (such as in dataset \code{reps}, with 'Cycles' in the first column and named runs with raw fluorescence data in remaining columns). A dataset can function as a transformation template, and the remaining files in the directory are then formatted according to the established parameters. See 'Details' and tutorial video in \url{http://www.dr-spiess.de/qpcR/tutorials.html}.
}

\usage{
pcrimport(file = NA, sep = NA, dec = NA, delCol = NA, delRow = NA,
          format = c(NA, "col", "row"), sampleDat = NA, refDat = NA,
          names = NA, sampleLen = NA, refLen = NA, check = TRUE,
          usePars = TRUE, dirPars = NULL, needFirst = TRUE, ...)
}

\arguments{
 \item{file}{either a directory such as \code{"c:/temp"} containing the data file(s), the Windows \code{"clipboard"} or an object in the workspace such as \code{"reps"}.}
 \item{sep}{the field separator character, i.e. \code{"\t"} for tabs.}
 \item{dec}{the decimal seperator, i.e. \code{"."}.}
 \item{delCol}{unneeded columns to delete after successful import, i.e. \code{2, 1:3, seq(1, 5, by = 2), etc...}.}
 \item{delRow}{unneeded rows to delete after successful import, i.e. \code{2, 1:3, seq(1, 5, by = 2), etc...}.}
 \item{format}{how the data is organized, i.e. in \code{col}umns or \code{row}s.}
 \item{sampleDat}{the columns with the raw fluorescence reporter dye data.}
 \item{refDat}{optional columns with the raw fluorescence reference dye data.}
 \item{names}{the row(s) that should be used for naming the runs.}
 \item{sampleLen}{the rows with the reporter dye cycles.}
 \item{refLen}{the rows with the reference dye cycles.}
 \item{check}{logical. If \code{TRUE}, a window displaying the transformed data after each step is displayed. This assists in choosing the right parameters.}
 \item{usePars}{logical. If \code{TRUE}, then all files in the directory are batch analysed using the stored parameters. See 'Details'.}
 \item{dirPars}{an optional directory such as \code{"c:/pars"} where the formatting parameters can be stored. If \code{NULL}, the 'qpcR' directory is used.}
 \item{needFirst}{logical. If \code{TRUE}, then the (alphabetically) first file in the directory is used for an initial definition of transformation parameters.}
 \item{...}{other parameters to be passed to \code{\link{read.delim}}.}
}

\details{
This function has been designed to offer maximal flexibility in importing qPCR data from all kinds of systems. This is accomplished by asking the user for many formatting options in single steps, with the final goal of obtaining a dataset that is transformed in a way suitable for \code{\link{pcrfit}}, as in all datasets in this package (i.e. 'reps'): it must be a dataframe with the first column containing the cycle numbers ("Cycles") and all subsequent columns with sensible sample names, such as "S1_1". In detail, the following steps are queried:\cr

1) Location of the file. Either a directory containing the file(s), the (Windows) clipboard or a dataframe in the workspace.\cr
2) How are the fields separated, i.e. by tabs?\cr
3) What is the decimal separator?\cr
4) Which columns can be deleted? For analysis, we only need the raw fluorescence values and sample names. Everything else should be deleted.\cr
5) Which rows can be deleted? Same as above.\cr
6) Are the runs organized in rows or in columns?\cr
After these steps, the unwanted rows/columns are deleted and the data transformed into vertical format (if it was in rows).\cr
7) In which columns are the runs with reporter dye data (i.e. SybrGreen)?\cr
8) If a reference dye (i.e. ROX) was used, in which columns are the runs?\cr
9) How should the runs be named (automatically or from a row/rows containing names)? If more than one row is supplied, the names in the rows are pasted together, i.e. "A4.GAPDH".\cr
10) Which are the rows containing the raw fluorescence data from cycle to cycle for the reporter dye?\cr
11) If a reference dye was used, which are the rows with the cycle to cycle data?\cr
After these steps, a 'Cycles' column is prepended to the data which should then be in the right format for downstream analysis.\cr
\bold{ATTENTION:} Because of this step, if the imported data also initially had a column containing cycle numbers, these should be removed in steps 2) or 3)!\cr

One major advantage of this function is that the formatting parameters are stored in a file and can be reused with new data, most conveniently when doing a batch analysis of several files in a directory. When \code{needFirst = TRUE}, the alphabetically first run in the directory is used for defining the formatting parameters, and if \code{usePars = TRUE} these are applied on all remaining datasets. If the initial definition of formatting parameters is not needed, then setting \code{needFirst = FALSE} will apply the last stored parameters on all datasets. By using different \code{dirPars}, one can establish different formatting options for different qPCR systems.\cr

The function will query (if \code{needFirst = TRUE}) all parameters that are defined as \code{NA}. For example, using
\code{pcrimport(file = "c:/temp", sep = "\t", dec = ".", delCol = c(1, 3), ...)} will result in these parameters not being queried.\cr

If reference dye data was supplied, the function checks if the data is of same dimensions than the reporter dye data. The output is then the normalized fuorescence data \eqn{\frac{F_{rep}}{F_{ref}}}.\cr

The 'Examples' feature internal datasets, but this function is best understood by the tutorial under \url{http://www.dr-spiess.de/qpcR/tutorials.html}.
}

\value{
A list with the transformed data as \code{data.frame} list items, suitable for downstream analysis.
}

\author{
 Andrej-Nikolai Spiess
}

\examples{

\dontrun{
## EXAMPLE 1:
## Internal dataset format01.txt (in 'add01' directory)
## with 384 runs.
## Tab delimited, 30 cycles, only reporter dye,
## data in rows, and some unneeded columns and rows.
## This is the example data path, but could be any path
## with data such as c:/temp.
PATH <- path.package("qpcR")
PATHall <- paste(PATH, "/add01/", sep = "")
res <- pcrimport(PATHall)

## Answer queries with the following parameters and
## verify the effects in the 'View' windows:
## 1 => data is tab delimited
## 1 => decimal separator is "."
## c(1, 3) => remove columns 1 + 3
## 1:2 => remove rows 1 + 2
## 2 => data is in rows
## 0 => all data is from reporter dye
## 1 => sample names are in row #1
## 0 => reporter data goes until end of table
## Data is stored as dataframe list items and can
## then be analyzed:
ml <- modlist(res[[1]], model = l5)
plot(ml, which = "single")

## Alternative without query:
res <- pcrimport(PATHall, sep = "\t", dec = ".",
                 delCol = c(1, 3), delRow = 1:2,
                 format = "row", sampleDat = 0,
                 names = 1, sampleLen = 0,
                 check = FALSE)

## Do something useful with the data:
ml <- modlist(res[[1]], model = l5)
plot(ml, which = "single")
                 
## EXAMPLE 2:
## Internal datasets format02a.txt - format02d.txt
## (in 'add02' directory) with 96 runs.
## Tab delimited, 40 cycles, reporter dye + reference dye,
## data in columns, and some unneeded columns and rows.
PATH <- path.package("qpcR")
PATHall <- paste(PATH, "/add02/", sep = "")
res <- pcrimport(PATHall)

## Answer queries with the following parameters and
## verify the effects in the 'View' windows:
## 1 => data is tab delimited
## 1 => decimal separator is "."
## 1 => remove column 1 with cycle data
## c(1, 43, 44) => remove rows 1, 43, 44
## 1 => data is in columns
## 1:96 => data columns for reporter dye
## -2 => reference dye stacked under reporter dye
## 1 => sample names are in row #1
## 1:40 => reporter data is in rows 1-40
## -1 => reference data is stacked under samples
## Data is stored as dataframe list items and can
## then be analyzed.

## Alternative without query:
res2 <- pcrimport(PATHall, sep = "\t", dec = ".",
                 delCol = 1, delRow = c(1, 43, 44),
                 format = "col", sampleDat = 1:96,
                 refDat = -2, names = 1,
                 sampleLen = 1:40, refLen = -1,
                 check = FALSE)

## Do something useful with the data:
ml2 <- modlist(res2[[1]], model = l5)
plot(ml2)
}
}




\keyword{IO}
\keyword{file}
