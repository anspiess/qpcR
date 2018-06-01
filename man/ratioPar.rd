\name{ratioPar}
\alias{ratioPar}

\title{Calculation of ratios in a batch format from external PCR parameters}

\description{Starting from external PCR parameters such as threshold cycles/efficiency values commonly obtained from other programs, this function calculates ratios between samples, using normalization against one or more reference gene(s), if supplied. By default, multiple reference genes are averaged according to Vandesompele \emph{et al}. (2002). The input can be single qPCR data or (more likely) data containing replicates. It is similar to \code{\link{ratiobatch}} and can handle multiple reference genes and genes-of-interest with multiple (replicated) samples as found in large-scale qPCR runs such as 96- or 384-Well plates. The results are automatically stored as a file or copied into the clipboard. A boxplot representation for all Monte-Carlo simulations, permutations and error propagations including 95\% confidence intervals is also given.
}

\usage{
ratioPar(group = NULL, effVec = NULL, cpVec = NULL, 
         type.eff = "individual", plot = TRUE, 
         combs = c("same", "across", "all"), 
         refmean = FALSE, verbose = TRUE, ...)
}

\arguments{
  \item{group}{a character vector defining the replicates (if any) of control/treatment samples and reference genes/genes-of-interest. See 'Details'.}
  \item{effVec}{a vector of efficiency values with the same length of \code{group}.}
  \item{cpVec}{a vector of threshold cycle values with the same length of \code{group}.}
  \item{type.eff}{type of efficiency averaging used. Same as in \code{\link{ratiocalc}}.}
  \item{plot}{logical. If \code{TRUE}, plots are displayed for the diagnostics and analysis.}
  \item{combs}{type of combinations between different samples (i.e. r1s1:g1s2). See 'Details'.}
  \item{refmean}{logical. If \code{TRUE}, multiple reference are averaged before calculating the ratios. See 'Details'.}
  \item{verbose}{logical. If \code{TRUE}, the steps of analysis are shown in the console window}
  \item{...}{other parameters to be passed to \code{\link{ratiocalc}}.}
}

\details{
As in \code{\link{ratiobatch}}, the replicates are to be defined as a character vector with the following abbreviations:

"g1s1":   gene-of-interest #1 in treatment sample #1\cr
"g1c1":   gene-of-interest #1 in control sample #1\cr
"r1s1":   reference gene #1 in treatment sample #1\cr
"r1c1":   reference gene #1 in control sample #1

There is no distinction between the different technical replicates so that three different runs of gene-of-interest #1 in treatment sample #2 are defined as c("g1s2", "g1s2", "g1s2"). 

Example:\cr
1 control sample with 2 genes-of-interest (2 technical replicates), 2 treatment samples with 2 genes-of-interest (2 technical replicates):\cr
"g1c1", "g1c1", "g2c1", "g2c1", "g1s1", "g1s1", "g1s2", "g1s2", "g2s1", "g2s1", "g2s2", "g2s2"

The ratios are calculated for all pairwise 'rc:gc' and 'rs:gs' combinations according to:\cr
For all control samples \eqn{i = 1 \ldots I} and treatment samples \eqn{j = 1 \ldots J}, reference genes \eqn{k = 1 \ldots K} and genes-of-interest \eqn{l = 1 \ldots L}, calculate\cr

Without reference genes:  \deqn{\frac{E(g_lc_i)^{cp(g_lc_i)}}{E(g_ls_j)^{cp(g_ls_j)}}}
With reference genes: \deqn{\frac{E(g_lc_i)^{cp(g_lc_i)}}{E(g_ls_j)^{cp(g_ls_j)}}/\frac{E(r_kc_i)^{cp(r_kc_i)}}{E(r_ks_j)^{cp(r_ks_j)}}}
For the mechanistic models \code{makX/cm3} the following is calculated:\cr

Without reference genes: \deqn{\frac{D_0(g_ls_j)}{D_0(g_lc_i)}} 
With reference genes: \deqn{\frac{D_0(g_ls_j)}{D_0(g_lc_i)}/\frac{D_0(r_ks_j)}{D_0(r_kc_i)}}

Efficiencies can be taken from the individual samples or averaged from the replicates as described in the documentation to \code{\link{ratiocalc}}. Different settings in \code{type.eff} can yield very different results in ratio calculation. We observed a relatively stable setup which minimizes the overall variance using the \code{type.eff = "mean.single"}.   

There are three different combination setups possible when calculating the pairwise ratios:\cr
\code{combs = "same"}: reference genes, genes-of-interest, control and treatment samples are the \code{same}, i.e. \eqn{i = k, m = o, j = n, l = p}.\cr
\code{combs = "across"}: control and treatment samples are the same, while the genes are combinated, i.e. \eqn{i \neq k, m \neq o, j = n, l = p, }.\cr
\code{combs = "all"}: reference genes, genes-of-interest, control and treatment samples are all combinated, i.e. \eqn{i \neq k, m \neq o, j \neq n, l \neq p}.

The last setting rarely makes sense and is very time-intensive. \code{combs = "same"} is the most common setting, but \code{combs = "across"} also makes sense if different genes-of-interest and reference gene combinations should be calculated for the same samples.

\code{ratioPar} has an option of averaging several reference genes, as described in Vandesompele \emph{et al.} (2002). Threshold cycles and efficiency values for any \eqn{i} reference genes with \eqn{j} replicates are averaged before calculating the ratios using the averaged value \eqn{\mu_r} for all reference genes in a control/treatment sample. The overall error \eqn{\sigma_r} is obtained by error propagation. The whole procedure is accomplished by function \code{\link{refmean}}, which can be used as a stand-alone function, but is most conveniently used inside \code{ratioPar} setting \code{refmean = TRUE}. For details about reference gene averaging by \code{\link{refmean}}, see there.
}

\value{
A list with the following components:
\item{resList}{a list with the results from the combinations as list items.}
\item{resDat}{a dataframe with the results in colums.}
Both \code{resList} and \code{resDat} have as names the combinations used for the ratio calculation.
If \code{plot = TRUE}, a boxplot matrix from the Monte-Carlo simulations, permutations and error propagations is given including 95\% confidence intervals as coloured horizontal lines.
}

\author{
Andrej-Nikolai Spiess
}

\note{
This function can be used quite conveniently when the PCR parameters are from 96- or 384-well runs plates and exported to a tab-delimited file.
}

\references{
Accurate normalization of real-time quantitative RT-PCR data by geometric averaging of multiple internal control genes.\cr
Vandesompele J, De Preter K, Pattyn F, Poppe B, Van Roy N, De Paepe A, Speleman F.\cr
\emph{Genome Biol} (2002), \bold{3}: research0034-research0034.11.\cr
}

\examples{
## One control sample, two treatment samples, 
## one gene-of-interest, two reference genes, 
## two replicates each. Replicates are averaged,
## but reference genes not, so that we have 4 ratios.
GROUP1 <- c("r1c1", "r1c1", "r2c1", "r2c1", "g1c1", "g1c1",
           "r1s1", "r1s1", "r1s2", "r1s2", "r2s1", "r2s1",
           "r2s2", "r2s2", "g1s1", "g1s1", "g1s2", "g1s2") 
EFF1 <- c(1.96, 2.03, 1.60, 1.67, 1.91, 1.97, 1.53, 1.61, 1.87, 
          1.92, 1.52, 1.58, 1.84, 1.90, 1.49, 1.56, 1.83, 1.87)
CP1 <- c(15.44, 15.33, 14.84, 15.34, 18.89, 18.71, 18.13, 17.22, 22.06, 
        21.85, 21.03, 20.92, 25.34, 25.12, 25.00, 24.62, 28.39, 28.28)
RES1 <- ratioPar(group = GROUP1, effVec = EFF1, cpVec= CP1, refmean = FALSE)


\dontrun{
## Same as above, but now we average the two
## reference genes, so that we have 2 ratios.
RES2 <- ratioPar(group = GROUP1, effVec = EFF1, cpVec= CP1, refmean = TRUE)

## Two control samples, one treatment sample, 
## one gene-of-interest, one reference gene, 
## no replicates. Reference gene has efficiency = 1.8,
## gene-of-interest has efficiency = 1.9.
GROUP3 <- c("r1c1", "r1c2", "g1c1", "g1c2", 
            "r1s1", "g1s1") 
EFF3 <- c(1.8, 1.8, 1.9, 1.9, 1.8, 1.9)
CP3 <- c(17.25, 17.38, 22.52, 23.18, 21.42, 19.83)
RES3 <- ratioPar(group = GROUP3, effVec = EFF3, cpVec= CP3, refmean = TRUE)
                   
## One control sample, one treatment sample, 
## three genes-of-interest, no reference gene, 
## three replicates. Using efficiency from sigmoidal model. 
GROUP4 <- c("g1c1", "g1c1", "g1c1", "g2c1", "g2c1", "g2c1", "g3c1", "g3c1", "g3c1",
            "g1s1", "g1s1", "g1s1", "g2s1", "g2s1", "g2s1", "g3s1", "g3s1", "g3s1")
EFF4 <- c(1.79, 1.71, 1.83, 1.98, 1.85, 1.76, 1.76, 1.91, 1.84, 1.80, 1.79, 1.91,
          1.88, 1.79, 1.78, 1.89, 1.86, 1.81)
CP4 <- c(15.68, 15.84, 14.47, 14.96, 18.97, 19.04, 17.65, 16.76, 22.11, 22.03, 20.43, 
         20.36, 25.29, 25.29, 24.27, 23.99, 28.34, 28.38)
RES4 <- ratioPar(group = GROUP4, effVec = EFF4, cpVec= CP4, refmean = TRUE)

## Compare to REST software using the data from the 
## REST 2008 manual (http://rest.gene-quantification.info/)
cp.rc <- c(26.74, 26.85, 26.83, 26.68, 27.39, 27.03, 26.78, 27.32)
cp.rs <- c(26.77, 26.47, 27.03, 26.92, 26.97, 26.97, 26.07, 26.3, 26.14, 26.81)
cp.gc <- c(27.57, 27.61, 27.82, 27.12, 27.76, 27.74, 26.91, 27.49)
cp.gs <- c(24.54, 24.95, 24.57, 24.63, 24.66, 24.89, 24.71, 24.9, 24.26, 24.44)
eff.rc <- rep(1.97, 8)
eff.rs <- rep(1.97, 10)
eff.gc <- rep(2.01, 8)
eff.gs <- rep(2.01, 10)
CP5 <- c(cp.rc, cp.rs, cp.gc, cp.gs)
EFF5 <- c(eff.rc, eff.rs, eff.gc, eff.gs) 
GROUP5 <- rep(c("r1c1", "r1s1", "g1c1", "g1s1"), c(8, 10, 8, 10))
RES5 <- ratioPar(group = GROUP5, effVec = EFF5, cpVec = CP5)
RES5$resDat
}        
}



\keyword{nonlinear}

