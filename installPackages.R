#' Install/update necessary packages from CRAN, Bioconductor, GitHub
#'
#' @param packages a vector of strings with names of packages from CRAN, Bioconductor, GitHub
#' @param file a file with packages; overrides packages parameter
#' @param updatePackages whether to update existing packages (Default: FALSE)
#' @param repos the CRAN repository to use
#'
#' @example 
#' \dontrun {
#' source("https://gist.githubusercontent.com/cannin/6b8c68e7db19c4902459/raw/installPackages.R")
#' tmp <- read.table("r-requirements-all.txt")
#' tmp <- tmp$V1
#' installPackages(tmp)
#' }
installPackages <- function(file=NULL, packages=NULL, updatePackages=FALSE, repos="http://cran.rstudio.com/") {
  setRepositories(ind=1:6)
  options(repos=repos, unzip="internal") # unzip needed for Ubuntu
  
  # Install packages 
  if(!is.null(file)) {
    packages <- read.table(file, stringsAsFactors = FALSE)
    packages <- packages$V1
  }
  
  if("devtools" %in% rownames(installed.packages())) {
    require(devtools)	  
  } else {
    install.packages("devtools")  
  }
  
  if("stringr" %in% rownames(installed.packages())) {
    require(stringr)	  
  } else {
    install.packages("stringr")  
  }

  for(package in packages) {
    tmp <- strsplit(package, .Platform$file.sep)[[1]]
    packageName <- tmp[length(tmp)]

    if(!(packageName %in% installed.packages())) {
      if(package %in% rownames(available.packages())) {
        if(updatePackages) {
          update.packages()
        }
        install.packages(package)
      } else if(str_count(package, '/') == 1) {
        install_github(package)
      } else if(str_count(package, .Platform$file.sep) > 1) {
        install.packages(package, repos = NULL, type="source")
      } else if(TRUE) {
        source("http://bioconductor.org/biocLite.R")
        biocLite(package, ask=updatePackages, suppressUpdates=!updatePackages, suppressAutoUpdate=!updatePackages)
      } else {
        cat("ERROR: Package: ", package, "\n")
      }
    }
  }
}