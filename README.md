## qpcR: Modelling and Analysis of Real-Time PCR Data (R-package)

*qpcR* is an R package that can analyze sigmoidal qPCR (quantitative polymerase chain reaction) data by fitting various sigmoidal, mechanistic, exponential and spline models to the raw data. From the fitted curves, various location indices, also called _Cq_ values, as well as qPCR efficiencies _E_ can be extracted and employed for ratio calculations, and this under an error propagation regime. This packages houses many published algorithms that other qPCR analysis softwares do not provide. 

#### Installation
You can install the latest development version of the code using the [devtools](https://cran.r-project.org/package=devtools) R package.

```R
# Install devtools, if you haven't already.
install.packages("devtools")
library(devtools)
install_github("anspiess/qpcR")
source("https://install-github.me/anspiess/qpcR")
```