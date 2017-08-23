#' Install/update necessary packages from CRAN, Bioconductor, GitHub
#'
#' @param a vector of strings with names of packages from CRAN, Bioconductor, GitHub
installPackages <- function(packages) {
	require(devtools)

  for(package in packages) {
    if(!(package %in% installed.packages())) {
      if(package %in% rownames(available.packages())) {
        update.packages()
        install.packages(package)
      } else if(grepl("/", package)) {
        install_github(package)
      } else {
        # Try to install from Bioconductor
        source("http://bioconductor.org/biocLite.R")
        biocLite(character(), ask=FALSE)
        biocLite(package)
      }
    }
  }
}
