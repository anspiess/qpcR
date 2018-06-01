\name{qpcR_datasets}
\alias{batsch1}
\alias{batsch2}
\alias{batsch3}
\alias{batsch4}
\alias{batsch5}
\alias{boggy}
\alias{competimer}
\alias{dil4reps94}
\alias{dyemelt}
\alias{guescini1}
\alias{guescini2}
\alias{htPCR}
\alias{karlen1}
\alias{karlen2}
\alias{karlen3}
\alias{lievens1}
\alias{lievens2}
\alias{lievens3}
\alias{reps}
\alias{reps2}
\alias{reps3}
\alias{reps384}
\alias{rutledge}
\alias{testdat}
\alias{vermeulen1}
\alias{vermeulen2}

\title{The (published) datasets implemented in qpcR}

\description{
A compilation of published datasets for method evaluation/comparison.
}

\usage{
batsch1
batsch2
batsch3
batsch4
batsch5
boggy
competimer
dil4reps94
dyemelt
guescini1
guescini2
htPCR
karlen1
karlen2
karlen3
lievens1
lievens2
lievens3
reps
reps2
reps3
reps384
rutledge
testdat
vermeulen1
vermeulen2
}

\details{
\bold{batsch1-5:}\cr
Setup: Five 4-fold dilutions with 3 replicates.\cr
Annotation: FX.Y (X = dilution number, Y = replicate number).\cr
Hardware: Lightcycler 1.0 (Roche).\cr
Details:\cr
batsch1: Primers for rat SLC6A14, Taqman probes.\cr
batsch2: Primers for human SLC22A13, Taqman probes.\cr
batsch3: Primers for pig EMT, Taqman probes.\cr
batsch4: Primers for chicken ETT, SybrGreen.\cr 
batsch5: Primers for human GAPDH, SybrGreen.

\bold{boggy}:\cr
Setup: Six 10-fold dilutions with 2 replicates.\cr
Annotation: FX.Y (X = dilution number, Y = replicate number).\cr
Hardware: Chromo4 (BioRad).\cr
Details:\cr
Primers for a synthetic template, consisting of a secondary structure-optimized random sequence (129 bp), Syto-13 dye.

\bold{competimer}\cr
Setup: 7 concentrations of inhibitor, six 4-fold dilutions, 3 replicates.\cr
Annotation: X_Y_Z (X = inhibitor concentration, Y = dilution number, Z = replicate number).\cr
X: \% competimer\cr
A 0\%, B 5\%, C 10\%, D 20\%, E 30\%, F 40\%, G 50\%.\cr
Y: dilution factor (-fold)\cr
A 64, B 16, C 4, D 1, E 0.25, F 0.0625, G NTC.\cr
Hardware: Lightcycler 480 (Roche).\cr
Details:\cr
Primers for human AluSx repeats, competitive primers, SybrGreen I dye. NTCs are included.

\bold{dil4reps94}\cr
Setup: Four 10-fold dilutions with 94 replicates.\cr
Annotation: FX_Y (X = copy number, Y = replicate number).\cr 
Hardware: CFX384 (BioRad).\cr
Details:\cr
Primers for the human MYCN gene, synthetic MYCN oligo used as template, SybrGreen I dye. NTCs were removed.

\bold{dyemelt}:\cr
Setup: Melting curves of a 4-plex qPCR with different fluorescence dyes.\cr
Annotation: T0 (Temperature), EvaGreen, T1 (Temperature), SybrGreen.I, T2 (Temperature), Syto13.\cr
Hardware: Lightcycler 1.0 (Roche).\cr
Details:\cr
A melting curve analysis of a 4-plex real-time PCR on genomic DNA with AZF deletion-specific primers. The dyes used were EvaGreen, SybrGreen I and Syto-13.

\bold{guescini1-2:}\cr
Setup: Seven 10-fold dilutions with 12 replicates (\code{guescini1}). Five decreasing steps of PCR mix with 12 replicates (\code{guescini2}).\cr
Annotation: FX.Y (X = dilution number, Y = replicate number).\cr
Hardware: Lightcycler 480 (Roche).\cr
Details:\cr
Primers for NADH dehydrogenase 1, SybrGreen I dye, data is background subtracted.

\bold{htPCR:}\cr
Setup: High throughput experiment containing 8858 runs from a 95 x 96 PCR grid.\cr
Annotation: PX.Y (X = plate number, Y = well number).\cr
Hardware: Biomark HD (Fluidigm).\cr
Details:\cr
Proprietary primers, EvaGreen dye, data is ROX normalized.

\bold{karlen1-3:}\cr
Setup: 4 (5) dilutions (1-, 10-, 50-, 100-, (1000)-fold) with 5 (4) replicates in 4 samples. \cr
Annotation: FX.Y.Z (X = sample number, Y = dilution number, Z = replicate number).\cr
Hardware: ABI Prism 7700 (Applied Biosystems).\cr
Details:\cr
Primers for Caveolin (\code{karlen1}), Fibronectin (\code{karlen2}) and L27 (\code{karlen3}),  SybrGreen I dye, data is background subtracted.

\bold{lievens1-3:}\cr
Setup: Five 5-fold dilutions with 18 replicates (\code{lievens1}). Five different concentrations of isopropanol (2.5\%, 0.5\%, 0.1\%, 0.02\% and 0.004\% (v/v)) with 18 replicates (\code{lievens2}). Five different amounts of tannic acid per reaction (5 ng, 1 ng, 0.2 ng, 0.04 ng and 0.008 ng) and 18 replicates (\code{lievens3}).\cr
Annotation: SX.Y (X = dilution number, Y = replicate number) (\code{lievens1}). SX.Y (X = concentration step, Y = replicate number) (\code{lievens2 & lievens3}).\cr 
Hardware: ABI7300 (ABI) or Biorad IQ5 (Biorad).\cr
Details:\cr
Primers for the soybean lectin endogene Le1, SybrGreen I dye.

\bold{reps, reps2, reps3:}\cr
Setup: Seven 10-fold dilutions with 4 replicates (\code{reps}). Five 4-fold dilutions with 3 replicates, 2 different cDNAs (\code{reps2}). Seven 4-fold dilutions with 3 replicates (\code{reps3}).\cr
Annotation: FX.Y (X = dilution number, Y = replicate number) (\code{reps & reps3}). FX.Y.Z (X = cDNA number, Y = dilution number, Z = replicate number) (\code{reps2}).\cr 
Hardware: Lightcycler 1.0 (Roche) (\code{reps}) or MXPro3000P (Stratagene) (\code{reps2 & reps3}).\cr
Details:\cr
Primers for the S27a housekeeping gene, SybrGreen I dye, \code{reps3} was ROX-normalized.

\bold{reps384}\cr
Setup: A data frame with 379 replicate runs of a 384 microtiter plate.\cr
Annotation: A_A_X (X = replicate number).\cr 
Hardware: CFX384 (BioRad).\cr
Details:\cr
Primers for the human MYCN gene, synthetic MYCN oligo used as template (15000 copies), SybrGreen I dye. NTCs were removed.

\bold{rutledge}:\cr
Setup: Six 10-fold dilutions with 4 replicates in 5 individual batches.\cr
Annotation: X.RY.Z (X = dilution number, Y = batch number, Z = replicate number).\cr
Hardware: Opticon 2 (MJ Research).\cr
Details:\cr
Primers for a 102 bp amplicon, SybrGreen I dye, data is background subtracted.

\bold{testdat}:\cr
Setup: Six 10-fold dilutions with 4 replicates.\cr
Annotation: FX.Y (X = dilution number, Y = replicate number).\cr
Hardware: Lightcycler 1.0 (Roche).\cr
Details:\cr
Same as \code{reps}, but each FX.3 has noisy data which fails to fit with the \code{\link{l5}} model, each FX.4 passes fitting but fails in sigmoidal structure detection by \code{\link{KOD}}. Used for evaluating quality checking methods.

\bold{vermeulen1-2:}\cr
Setup: A subset of the first 20 samples for each of 64 genes (\code{vermeulen1}) and the corresponding dilution data for all 64 genes with five 10-fold dilutions and 3 replicates (\code{vermeulen2}).\cr
Annotation: X.Y (X = gene name, Y = sample name) (\code{vermeulen1}), X.STD_Y.Z (X = gene name, Y = copy number, Z = replicate number) (\code{vermeulen2}).\cr
Hardware: Lightcycler 480 (Roche).\cr
Details:\cr
Primers for AHCY, AKR1C1, ALUsq(Eurogentec), ARHGEF7, BIRC5, CAMTA1, CAMTA2, CD44, CDCA5, CDH5, CDKN3, CLSTN1, CPSG3, DDC, DPYSL3, ECEL1, ELAVL4, EPB41L3, EPHA5, EPN2, FYN, GNB1, HIVEP2, HMBS, HPRT1, IGSF4, INPP1, MAP2K4, MAP7, MAPT, MCM2, MRPL3, MTSS1, MYCN(4), NHLH2, NM23A, NRCAM, NTRK1, ODC1, PAICS, PDE4DIP, PIK3R1, PLAGL1, PLAT, PMP22, PRAME, PRDM2, PRKACB, PRKCZ, PTN, PTPRF, PTPRH, PTPRN2, QPCT, SCG2, SDHA(1), SLC25A5, SLC6A8, SNAPC1, TNFRSF, TYMS, UBC(2), ULK2 and WSB1. SybrGreen I dye.\cr
Originally, raw data was available at \emph{http://medgen.ugent.be/jvermeulen}, but site is down. The complete (\code{vermeulen_all}) and smaller (\code{vermeulen_sub}) datasets can be downloaded from \url{http://www.dr-spiess.de/qpcR/datasets.html}.
}

\author{
Andrej-Nikolai Spiess
}

\references{
\bold{batsch1-5:}\cr
Simultaneous fitting of real-time PCR data with efficiency of amplification modeled as Gaussian function of target fluorescence.\cr
Batsch A, Noetel A, Fork C, Urban A, Lazic D, Lucas T, Pietsch J, Lazar A, Schoemig E & Gruendemann D.\cr 
\emph{BMC Bioinformatics} (2008), \bold{9}: 95.
Additional File 5 to the paper.

\bold{boggy:}\cr
A Mechanistic Model of PCR for Accurate Quantification of Quantitative PCR Data.\cr
Boggy GJ & Woolf PJ.\cr
\emph{PLOS One} (2010), \bold{5}: e12355.
Additional File S1 to the paper.

\bold{dyemelt:}\cr
A one-step real-time multiplex PCR for screening Y-chromosomal microdeletions without downstream
amplicon size analysis.\cr
Kozina V, Cappallo-Obermann H, Gromoll J & Spiess AN.\cr
\emph{PLOS One} (2011), \bold{6}: e23174. Figure 2 to the paper.

\bold{guescini1-2:}\cr
A new real-time PCR method to overcome significant quantitative inaccuracy due to slight amplification inhibition.\cr
Guescini M, Sisti D, Rocchi MB, Stocchi L & Stocchi V.\cr
\emph{BMC Bioinformatics} (2008), \bold{9}: 326. Supplemental Data 1 to the paper.

\bold{htPCR:}\cr
Kindly supplied by Roman Bruno.

\bold{karlen1-3:}\cr
Karlen Y, McNair A, Perseguers S, Mazza C & Mermod N.\cr
Statistical significance of quantitative PCR.\cr 
\emph{BMC Bioinformatics} (2007), \bold{20}: 131. Supplemental Data 2 to the paper.

\bold{lievens1-3:}\cr
Enhanced analysis of real-time PCR data by using a variable efficiency model: FPK-PCR.\cr
Lievens A, Van Aelst S, Van den Bulcke M & Goetghebeur E.\cr
\emph{Nucleic Acids Res} (2012), \bold{40}: e10. Supplemental Data to the paper.

\bold{reps, reps2, reps3:}\cr
Andrej-Nikolai Spiess & Nadine Mueller, Institute for Hormone and Fertlity Research, Hamburg, Germany.

\bold{competimer, dil4reps94, reps384:}\cr
Evaluation of qPCR curve analysis methods for reliable biomarker discovery: Bias, resolution, precision, and implications.\cr
Ruijter JM, Pfaffl MW, Zhao S, Spiess AN, Boggy G, Blom J, Rutledge RG, Sisti D, Lievens A, De Preter K, Derveaux S, Hellemans J, Vandesompele J.\cr
\emph{Methods} (2012), [Epub ahead of print] PubMed PMID: 22975077.

\bold{rutledge:}\cr
Sigmoidal curve-fitting redefines quantitative real-time PCR with the prospective of developing automated high-throughput applications.\cr
Rutledge RG.\cr
\emph{Nucleic Acids Research} (2004), \bold{32}: e178. Supplemental Data 1 to the paper.

\bold{vermeulen1-2:}\cr
Predicting outcomes for children with neuroblastoma using a multigene-expression signature: a retrospective SIOPEN/COG/GPOH study.\cr
Vermeulen J, De Preter K, Naranjo A, Vercruysse L, Van Roy N, Hellemans J,
Swerts K, Bravo S, Scaruffi P, et. al.\cr 
\emph{Lancet Oncol} (2009), \bold{10}:663-671.
}


\examples{
\dontrun{
## 'reps' dataset.
g1 <- gl(7, 4)
ml1 <- modlist(reps, model = l5)
plot(ml1, col = g1)

## 'rutledge' dataset.
g2 <- gl(6, 20)
ml2 <- modlist(rutledge, model = l5)
plot(ml2, col = g2)

## 'lievens1' dataset.
g3 <- gl(5, 18)
ml3 <- modlist(lievens1, model = l5)
plot(ml3, col = g3)
}
}

\keyword{models}
\keyword{nonlinear}
