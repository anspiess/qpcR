\name{propagate}
\alias{propagate}
\encoding{latin1}

\title{Error propagation using different methods}

\description{
A general function for the calculation of error propagation by Monte Carlo simulation, permutation and first/second-order Taylor expansion including covariances. Can be used for qPCR data, but any data that should be subjected to error propagation analysis will do. The different methods can be used for any expression based on either replicate or summary data (mean & standard deviation). 
}

\usage{
propagate(expr, data, type = c("raw", "stat"), second.order = TRUE,
          do.sim = FALSE, dist.sim = c("norm", "tnorm"), use.cov = FALSE, 
          nsim = 10000, do.perm = FALSE, perm.crit = NULL, ties = NULL, 
          nperm = 2000, alpha = 0.05, plot = TRUE, logx = FALSE, 
          verbose = FALSE, ...)  
}

\arguments{
  \item{expr}{an expression, such as \code{expression(x/y)}.}
  \item{data}{a dataframe or matrix containing either a) the replicates in columns or b) the means in the first row and the standard deviations in the second row. The variable names must be defined in the column headers.}
  \item{type}{either \code{raw} if replicates are given, or \code{stat} if means and standard deviations are supplied.}
  \item{second.order}{logical. If \code{TRUE}, error propagation will be calculated with first AND second-order Taylor expansion. See 'Details'.}
  \item{do.sim}{logical. Should Monte Carlo simulation be applied?}
  \item{dist.sim}{\code{"norm"} will use a multivariate normal distribution, \code{"tnorm"} a multivariate truncated normal distribution. See 'Details'.}
  \item{use.cov}{logical or variance-covariance matrix with the same column descriptions and column order as \code{data}. If \code{TRUE} together with replicates, the covariances are calculated from these and used within Monte Carlo simulation and error propagation. If \code{type = "stat"}, a square variance-covariance matrix can be supplied in the right dimensions (n x n, n = number of variables). If \code{FALSE}, Monte Carlo simulation and error propagation use only the diagonal (variances).}
  \item{nsim}{the number of simulations to be performed, minimum is 5000.}  
  \item{do.perm}{logical. Should permutation error analysis be applied?}     
  \item{perm.crit}{a character string of one or more criteria defining the null hypothesis for the permutation p-value. See 'Details'.}
  \item{ties}{a vector defining the columns that should be tied together for the permutations. See 'Details'.}
  \item{nperm}{the number of permutations to be performed.}  
  \item{alpha}{the confidence level.}
  \item{plot}{logical. Should histograms with confidence intervals (in blue) be plotted for all methods?}
  \item{logx}{logical. Should the x-axis of the graphs have logarithmic scale?}
  \item{verbose}{logical. If \code{TRUE}, a longer output is given including the simulated data, derivatives, covariance matrix, etc.}
  \item{...}{other parameters to be supplied to \code{hist}, \code{boxplot} or \code{abline}.}
}

\details{
The implemented methods are:\cr\cr
1) \bold{Monte Carlo simulation:}\cr
For each variable in \code{data}, simulated data with \code{nsim} samples is generated from a multivariate (truncated) normal distribution using mean \eqn{\mu} and standard deviation \eqn{\sigma} of each variable. All data is coerced into a new dataset that has the same covariance structure as the initial \code{data}. Each row of the simulated dataset is evaluated and summary statistics are calculated. In scenarios that are nonlinear in nature the distribution of the result values can be skewed, mainly due to the simulated values at the extreme end of the normal distribution. Setting \code{dist.sim = "tnorm"} will fit a multivariate normal distribution, calculate the lower/upper 2.5\% quantile on each side for each input variable and use these as bounds for simulating from a multivariate truncated normal distribution. This will (in part) remove some of the skewness in the result distribution. 

2) \bold{Permutation approach:}\cr
The original \code{data} is permutated \code{nperm} times by binding observations together according to \code{ties}. The \code{ties} bind observations that can be independent measurements from the same sample. In qPCR terms, this would be a real-time PCR for two different genes on the same sample. If \code{ties} are omitted, the observations are shuffled independently. In detail, two datasets are created for each permutation: Dataset1 samples the rows (replicates) of the data according to \code{ties}. Dataset2 is obtained by sampling the columns (samples), also binding columns as defined in \code{ties}. For both datasets, the permutations are evaluated and statistics are collected. A confidence interval is calculated from all evaluations of Dataset1. A p-value is calculated from all permutations that follow \code{perm.crit}, whereby \code{init} reflects the permutations of the initial \code{data} and \code{perm} the permutations of the randomly reallocated samples. Thus, the p-value gives a measure against the null hypothesis that the result in the initial group is just by chance. See also 'Examples'.\cr
The criterion for the permutation p-value (\code{perm.crit}) has to be defined by the user. For example, let's say we calculate some value 0.2 which is a ratio between two groups. We would hypothesize that by randomly reallocating the values between the groups, the mean values are not equal or smaller than in the initial data. We would thus define \code{perm.crit} as "perm < init" meaning that we want to test if the mean of the initial data (\code{init}) is frequently smaller than by the randomly allocated data (\code{perm}). The default (\code{NULL}) is to test all three variants "perm > init", "perm == init" and "perm < init".
 
3) \bold{Error propagation:}\cr
The propagated error is calculated by first and second-order Taylor expansion using matrix algebra. Often omitted, but important in models where the variables are correlated, is the second covariance term:
\deqn{\sigma_y^2 = \underbrace{\sum_{i=1}^N\left(\frac{\partial f}{\partial x_i} \right)^2 \sigma_i^2}_{\rm{variance}} + \underbrace{2\sum_{i=1\atop i \neq j}^N\sum_{j=1\atop j \neq i}^N\left(\frac{\partial f}{\partial x_i} \right)\left(\frac{\partial f}{\partial x_j} \right) \sigma_{ij}}_{\rm{covariance}}}
\code{propagate} calculates the propagated error either with or without covariances using matrix algebra for first- and second-order (since version 1.3-8) Taylor expansion.\cr
\bold{First-order:}\cr
\eqn{\mathrm{E}(y) = f(\bar{x}_i)}\cr
\eqn{\mathbf{C}_y = \nabla_x\mathbf{C}_x\nabla_x^T}\cr
\bold{Second-order:}\cr
\eqn{\mathrm{E}(y) = f(\bar{x}_i) + \frac{1}{2}[tr(\mathbf{H}_{xx}\mathbf{C}_x)]}\cr
\eqn{\mathbf{C}_y = \nabla_x\mathbf{C}_x\nabla_x^T + \frac{1}{2}[tr(\mathbf{H}_{xx}\mathbf{C}_x\mathbf{H}_{xx}\mathbf{C}_x)]}\cr

with \eqn{\mathrm{E}(y)} = expectation of \eqn{y}, \eqn{\mathbf{C}_y} = variance of \eqn{y}, \eqn{\nabla_x} = the p x n gradient matrix with all partial first derivatives, \eqn{\mathbf{C}_x} = the p x p covariance matrix, \eqn{\mathbf{H}_{xx}} the Hessian matrix with all partial second derivatives and \eqn{tr(\cdot)} = the trace (sum of diagonal) of the matrix. For a detailed derivation, see 'References'.\cr 
The second-order Taylor expansion (\code{second.order = TRUE}) corrects for bias in nonlinear expressions as the first-order Taylor expansion assumes linearity around \eqn{\bar{x}_i}.\cr
Depending on the input formula, the error propagation may result in an error that is not normally distributed. The Monte Carlo simulation, starting with normal distributions of the variables, can clarify this. A high tendency from deviation of normality is encountered in formulas in which the error of the denominator is relatively high or in exponential models where the exponent has a high error. This is one of the problems that is inherent in real-time PCR analysis, as the classical ratio calculation with efficiencies (i.e. by the delta-ct method) is of an exponential type.  
}

\value{
A plot containing histograms of the Monte Carlo simulation, the permutation values and error propagation. Additionally inserted are a boxplot, median values in red and confidence intervals as blue borders. 

A list with the following components (if \code{verbose = TRUE}):   
  \item{data.Sim}{the Monte Carlo simulated data with evaluations in the last column.}       
  \item{data.Perm}{the data of the permutated observations and samples with corresponding evaluations and the decision according to \code{perm.crit}.}      
  \item{data.Prop}{\code{nsim} values generated from a normal distribution with mean and s.d. as calculated from the propagated error.}   
  \item{gradient}{the evaluated gradient vector \eqn{\nabla_x} of partial first derivatives.}   
  \item{hessian}{the evaluated hessian matrix \eqn{\mathbf{H}_{xx}} of partial second derivatives.}  
  \item{covMat}{the covariance matrix \eqn{\mathbf{C}_x} used for Monte Carlo simulation and error propagation.}    
  \item{summary}{a summary of the collected statistics, given as a dataframe. These are: mean, s.d. median, mad, lower/upper confidence interval and permutation p-values.} 
}

\author{
Andrej-Nikolai Spiess
}   

\references{
\bold{Error propagation (in general):}\cr
An Introduction to error analysis.\cr
Taylor JR.\cr
University Science Books (1996), New York.\cr

Evaluation of measurement data - Guide to the expression of uncertainty in measurement.\cr
JCGM 100:2008 (GUM 1995 with minor corrections).\cr
\url{https://www.bipm.org/utils/common/documents/jcgm/JCGM_100_2008_E.pdf}.\cr

\bold{Higher-order Taylor expansion:}\cr
On higher-order corrections for propagating uncertainties.\cr
Wang CM & Iyer HK.\cr
\emph{Metrologia} (2005), \bold{42}: 406-410.\cr

Accuracy of error propagation exemplified with ratios of random variables.\cr
Winzer PJ.\cr
\emph{Rev Sci Instrum} (2000), \bold{72}: 1447-1454.\cr

\bold{Matrix algebra for error propagation:}\cr
An Introduction to Error Propagation: Derivation, Meaning and Examples of Equation Cy = FxCxFx^t.\cr
\url{www.nada.kth.se/~kai-a/papers/arrasTR-9801-R3.pdf}.\cr

Second order nonlinear uncertainty modeling in strapdown integration using MEMS IMUs.\cr
Zhang M, Hol JD, Slot L, Luinge H.\cr
2011 Proceedings of the 14th International Conference on Information Fusion (FUSION) (2011).\cr

\bold{Error propagation (in qPCR):}\cr
Error propagation in relative real-time reverse transcription polymerase chain reaction quantification models: The balance between accuracy and precision.\cr
Nordgard O, Kvaloy JT, Farmen RK, Heikkila R.\cr
\emph{Anal Biochem} (2006), \bold{356}: 182-193.\cr

qBase relative quantification framework and software for management and analysis of real-time quantitative PCR data.\cr
Hellemans J, Mortier G, De Paepe A, Speleman F, Vandesompele J.\cr
\emph{Genome Biol} (2007), \bold{8}: R19.\cr 

\bold{Multivariate normal distribution:}\cr
Stochastic Simulation.\cr
Ripley BD.\cr
Stochastic Simulation (1987). Wiley. Page 98.\cr

\bold{Testing for normal distribution:}\cr
Testing for  Normality.\cr
Thode Jr. HC.\cr
Marcel Dekker (2002), New York.\cr

Approximating the Shapiro-Wilk W-test for non-normality.\cr
Royston P.\cr 
\emph{Stat Comp} (1992), \bold{2}: 117-119.\cr
}

\seealso{
Function \code{\link{ratiocalc}} for error analysis within qPCR ratio calculation.
}

\examples{
## From summary data just calculate 
## Monte-Carlo and propagated error.
EXPR <- expression(x/y)
x <- c(5, 0.01)
y <- c(1, 0.01)
DF <- cbind(x, y)
RES1 <- propagate(expr = EXPR, data = DF, type = "stat", 
                 do.sim = TRUE, verbose = TRUE)

## Do Shapiro-Wilks test on Monte Carlo evaluations 
## !maximum 5000 datapoints can be used!
## => p.value on border to non-normality
shapiro.test(RES1$data.Sim[1:5000, 3])
## How about a graphical analysis:
qqnorm(RES1$data.Sim[, 3])

## Using raw data
## If data is of unequal length,
## use qpcR:::cbind.na to avoid replication!
## Do permutations (swap x and y values)
## and simulations.
EXPR <- expression(x*y)
x <- c(2, 2.1, 2.2, 2, 2.3, 2.1)
y <- c(4, 4, 3.8, 4.1, 3.1)
DF <- qpcR:::cbind.na(x, y)  
RES2 <- propagate(EXPR, DF, type = "raw", do.perm = TRUE, 
                 do.sim = TRUE, verbose = TRUE)
RES2$summary

## For replicate data, using relative 
## quantification ratio from qPCR.
## How good is the estimation of the propagated error?
## Done without using covariance in the 
## calculation and simulation.
## cp's and efficiencies are tied together
## because they are two observations on the
## same sample!
## As we are using an exponential type function,
## better to logarithmize the x-axis.
EXPR <- expression((E1^cp1)/(E2^cp2))
E1 <- c(1.73, 1.75, 1.77)
cp1 <- c(25.77,26.14,26.33)
E2 <-  c(1.72,1.68,1.65)
cp2 <- c(33.84,34.04,33.33)
DF <- cbind(E1, cp1, E2, cp2)
RES3 <- propagate(EXPR, DF, type = "raw", do.sim = TRUE,
                 do.perm = TRUE, verbose = TRUE, logx = TRUE)                 
## STRONG deviation from normality!
shapiro.test(RES3$data.Sim[1:5000, 5])
qqnorm(RES3$data.Sim[, 5])

## Same setup as above but also
## using a permutation approach
## for resampling the confidence interval.
## Cp's and efficiencies are tied together
## because they are two observations on the
## same sample! 
## Similar to what REST2008 software does.
RES4 <- propagate(EXPR, DF, type = "raw", do.sim = TRUE,
                 perm.crit = NULL, do.perm = TRUE, 
                 ties = c(1, 1, 2, 2), logx = TRUE, verbose = TRUE)
RES4$summary
## p-value of 0 in perm < init indicates that not a single 
## exchange of group memberships resulted in a smaller ratio!
              
## Proof that covariance of Monte-Carlo
## simulated dataset is the same as from 
## initial data.
RES4$covMat
cov(RES4$data.Sim[, 1:4])
all.equal(RES4$covMat, cov(RES4$data.Sim[, 1:4]))
}   

\keyword{distribution}
\keyword{htest}
