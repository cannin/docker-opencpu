# Set up to use CRAN
setRepositories(ind=1:6)
options(repos="http://cran.rstudio.com/")
if(!require(devtools)) { install.packages("devtools") }

source("installPackages.R")

# Install packages 
pkg <- read.table("r-requirements.txt", stringsAsFactors = FALSE)
pkg <- pkg$V1

installPackages(pkg)
