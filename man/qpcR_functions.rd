\name{qpcR_functions}
\alias{l7}
\alias{l6}
\alias{l5}
\alias{l4}
\alias{b7}
\alias{b6}
\alias{b5}
\alias{b4}
\alias{expGrowth}  
\alias{expSDM}
\alias{linexp}
\alias{mak2}
\alias{mak2i}
\alias{mak3}
\alias{mak3i}
\alias{lin2}
\alias{cm3}
\alias{spl3}

\encoding{latin1}

\title{The nonlinear/mechanistic models implemented in qpcR}

\description{
A summary of all available models implemented in this package.
}

\usage{
l7
l6
l5
l4
b7
b6
b5
b4
expGrowth 
expSDM
linexp
mak2
mak2i
mak3
mak3i
lin2
cm3
spl3
}

\details{
The following nonlinear sigmoidal models are implemented:\cr\cr
\bold{l7:} \deqn{f(x) = c + k1 \cdot x + k2 \cdot x^2 + \frac{d - c}{(1 + exp(b(log(x) - log(e))))^f}}
\bold{l6:} \deqn{f(x) = c + k \cdot x + \frac{d - c}{(1 + exp(b(log(x) - log(e))))^f}}
\bold{l5:} \deqn{f(x) = c + \frac{d - c}{(1 + exp(b(log(x) - log(e))))^f}}
\bold{l4:} \deqn{f(x) = c + \frac{d - c}{1 + exp(b(log(x) - log(e)))}}
\bold{b7:} \deqn{f(x) = c + k1 \cdot x + k2 \cdot x^2 + \frac{d - c}{(1 + exp(b(x - e)))^f}}
\bold{b6:} \deqn{f(x) = c + k \cdot x + \frac{d - c}{(1 + exp(b(x - e)))^f}}
\bold{b5:} \deqn{f(x) = c + \frac{d - c}{(1 + exp(b(x - e)))^f}}
\bold{b4:} \deqn{f(x) = c + \frac{d - c}{1 + exp(b(x - e))}}

The following nonlinear models for subsets of the curve are implemented:\cr\cr
\bold{expGrowth}: \deqn{f(x) = \left. a \cdot exp(b \cdot x) + c \; \right|_{n_1 \leq x \leq n_2}}\cr
\bold{expSDM}: \deqn{f(x) = \left. a \cdot exp(b \cdot x) + c \; \right|_{1 \leq x \leq \rm{SDM}}}\cr
\bold{linexp}: \deqn{f(x) = \left. a \cdot exp(b \cdot x) + (k \cdot x) + c \; \right|_{1 \leq x \leq \rm{SDM}}}\cr
\bold{lin2}: \deqn{f(x) = \left. \eta \cdot log\left(exp\left(a1 \cdot \frac{x - \tau}{\eta}\right) + exp\left(a2 \cdot \frac{x - \tau}{\eta}\right)\right) + c \; \right|_{1 \leq x \leq \rm{SDM}}}\cr

The following mechanistic models are implemented:\cr\cr
\bold{mak2 & mak2i}: \deqn{F_n = \left. F_{n-1} + k \cdot log \left(1 + \left(\frac{F_{n-1}}{k}\right)\right) + Fb \; \right|_{1 \leq x \leq \rm{SDM}}}
\bold{mak3 & mak3i}: \deqn{F_n = \left. F_{n-1} + k \cdot log \left(1 + \left(\frac{F_{n-1}}{k}\right)\right) + (slope \cdot n + Fb) \; \right|_{1 \leq x \leq \rm{SDM}}}
\bold{cm3}: \deqn{F_n = F_{n-1} \cdot \left(1 + \left(\frac{max - F_{n-1}}{max}\right) - \left(\frac{F_{n-1}}{Kd + F_{n-1}}\right)\right) + Fb}

Other models:\cr\cr
\bold{spl3}:  \deqn{S:[a, b] \to Real, a = n_0 < n_1 < \ldots < n_{k-1} < n_k = b}

\bold{mak2} and \bold{mak3} are two mechanistic models developed by Gregory Boggy (see references). The mechanistic models are a completely different approach in that the response value (Fluorescence) is not a function of the predictor value (Cycles), but a function of the preceeding response value, that is, \eqn{F_n = f(F_{n-1})}. These are also called 'recurrence relations' or 'iterative maps'. The implementation of these models in the 'qpcR'' package is the following:\cr
1) In case of \code{mak2/mak2i} or \code{mak3/mak3i}, all cycles up from the second derivative maximum (SDM) of a four-parameter log-logistic model (l4) are chopped off. This is because these two models do not fit to a complete sigmoidal curve. An \code{offset} criterion from the SDM can be defined in \code{\link{pcrfit}}, see there.\cr 
2) For \code{mak2i/mak3i}, a grid of sensible starting values is created for all parameters in the model. For \code{mak2/mak3} the recurrence function is fitted directly (which is much faster, but may give convergence problems), so proceed to 7).\cr
3) For each combination of starting parameters, the model is fit.\cr
4) The acquired parameters are collected in a parameter matrix together with the residual sum-of-squares (RSS) of the fit.\cr
5) The parameter combination is selected that delivered the lowest RSS.\cr
6) These parameters are transferred to \code{\link{pcrfit}}, and the data is refitted.\cr
7) Parameter \eqn{D_0} can be used directly to calculate expression ratios, hence making the use of threshold cycles and efficiencies expendable.\cr
\bold{cm3} is a mechanistic model by Carr & Moore (see references). In contrast to the \code{mak} models, \code{cm3} models the complete curve, which might prove advantageous as no decision on curve subset selection has to be done. As in the \code{mak} models, \eqn{D_0} is the essential parameter to use.\cr
\bold{spl3} is a cubic spline function that treats each point as being exact. It is just implemented for comparison purposes.\cr
\bold{lin2} is a bilinear model developed by P. Buchwald (see references). These are essentially two linear functions connected by a transition region. 
 
The functions are defined as a list containing the following items:\cr
\code{$expr}        the function as an expression for the fitting procedure.\cr
\code{$fct}         the function defined as \code{f(x, parm)}.\cr
\code{$ssfct}       the self-starter function.\cr
\code{$d1}          the first derivative function.\cr
\code{$d2}          the second derivative function.\cr
\code{$inv}         the inverse function.\cr
\code{$expr.grad}   the function as an expression for gradient calculation.\cr
\code{$inv.grad}    the inverse functions as an expression for gradient calculation.\cr
\code{$parnames}    the parameter names.\cr
\code{$name}        the function name.\cr
\code{$type}        the function type as a character string.\cr  
}

\note{
For models \code{l6, l7, b6, b7} there are no explicit solutions to the inverse function. The calculation of \code{x} from \code{y} (Cycles from Fluorescence) is done using \code{\link{uniroot}} by minimizing \code{model$fct(x, parm)} - y in the interval [1, 100].
}

\author{
Andrej-Nikolai Spiess
}

\references{
\bold{4-parameter logistic}:\cr
Validation of a quantitative method for real time PCR kinetics.\cr
Liu W & Saint DA.\cr
\emph{Biochem Biophys Res Commun} (2002), \bold{294}:347-53. 

Standardized determination of real-time PCR efficiency from a single reaction set-up.\cr
Tichopad A, Dilger M, Schwarz G & Pfaffl MW.\cr
\emph{Nucleic Acids Res} (2003), \bold{31}:e122. 

Sigmoidal curve-fitting redefines quantitative real-time PCR with the prospective of developing automated high-throughput applications.\cr
Rutledge RG.\cr
\emph{Nucleic Acids Res} (2004), \bold{32}:e178. 

A kinetic-based sigmoidal model for the polymerase chain reaction and its application to high-capacity absolute quantitative real-time PCR.\cr
Rutledge RG & Stewart D.\cr
\emph{BMC Biotechnol} (2008), \bold{8}:47.

Evaluation of absolute quantitation by nonlinear regression in probe-based real-time PCR.\cr
Goll R, Olsen T, Cui G & Florholmen J.\cr
\emph{BMC Bioinformatics} (2006), \bold{7}:107

Comprehensive algorithm for quantitative real-time polymerase chain reaction.\cr
Zhao S & Fernald RD.\cr
\emph{J Comput Biol} (2005), \bold{12}:1047-64. 

\bold{4-parameter log-logistic; 5-parameter logistic/log-logistic}:\cr
qpcR: an R package for sigmoidal model selection in quantitative real-time polymerase chain reaction analysis.\cr
Ritz C & Spiess AN.\cr
\emph{Bioinformatics} (2008), \bold{24}:1549-51. 

Highly accurate sigmoidal fitting of real-time PCR data by introducing a parameter for asymmetry.\cr
Spiess AN, Feig C & Ritz C.\cr
\emph{BMC Bioinformatics} (2008), \bold{29}:221. 

\bold{exponential model}:\cr
Standardized determination of real-time PCR efficiency from a single reaction set-up.\cr
Tichopad A, Dilger M, Schwarz G & Pfaffl MW.\cr
\emph{Nucleic Acids Research} (2003), \bold{31}:e122.

Comprehensive algorithm for quantitative real-time polymerase chain reaction.\cr
Zhao S & Fernald RD.\cr
\emph{J Comput Biol} (2005), \bold{12}:1047-64.

\bold{mak2, mak2i, mak3, mak3i}:\cr
A Mechanistic Model of PCR for Accurate Quantification of Quantitative PCR Data.\cr
Boggy GJ & Woolf PJ.\cr
\emph{PLoS ONE} (2010), \bold{5}:e12355.

\bold{lin2}:\cr
A general bilinear model to describe growth or decline time profiles.\cr
Buchwald P.\cr
\emph{Math Biosci} (2007), \bold{205}:108-36.

\bold{cm3}:\cr
Robust quantification of polymerase chain reactions using global fitting.\cr
Carr AC & Moore SD.\cr
\emph{PLoS One} (2012), \bold{7}:e37640.
}

\examples{
m1 <- pcrfit(reps, 1, 2, b4)
m2 <- pcrfit(reps, 1, 2, b5)
m3 <- pcrfit(reps, 1, 2, l6)
m4 <- pcrfit(reps, 1, 2, l7)

## Get the second derivative
## curve of m2.
d2 <- b5$d2(m2$DATA[, 1], coef(m2))
plot(m2)
lines(d2, col = 2)  
}

\keyword{models}
\keyword{nonlinear}
